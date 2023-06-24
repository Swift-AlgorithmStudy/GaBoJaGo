/***
전략 : 서류 심사를 기준으로 오름차순으로 정렬한 뒤, 면접 성적을 비교해서 만약 높은 순위(낮은 값 min)가 나타난다면 result를 +1 하고, min을 변경한다.
*/

import Foundation

final class FileIO {
    private let buffer:[UInt8]
    private var index: Int = 0

    init(fileHandle: FileHandle = FileHandle.standardInput) {
        
        buffer = Array(try! fileHandle.readToEnd()!)+[UInt8(0)] // 인덱스 범위 넘어가는 것 방지
    }

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }

        return buffer[index]
    }

    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true

        while now == 10
                || now == 32 { now = read() } // 공백과 줄바꿈 무시
        if now == 45 { isPositive.toggle(); now = read() } // 음수 처리
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }

        return sum * (isPositive ? 1:-1)
    }

    @inline(__always) func readString() -> String {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return String(bytes: Array(buffer[beginIndex..<(index-1)]), encoding: .ascii)!
    }

    @inline(__always) func readByteSequenceWithoutSpaceAndLineFeed() -> [UInt8] {
        var now = read()

        while now == 10 || now == 32 { now = read() } // 공백과 줄바꿈 무시
        let beginIndex = index-1

        while now != 10,
              now != 32,
              now != 0 { now = read() }

        return Array(buffer[beginIndex..<(index-1)])
    }
}

let fIO = FileIO()
//let T = Int(readLine()!)!
let T = fIO.readInt()

for _ in 0..<T {
//    let N = Int(readLine()!)!
    let N = fIO.readInt()
    var ranks = [(Int, Int)]()
    var result = 1
    for _ in 0..<N {
//        let rank = readLine()!.split(separator: " ").map { Int($0)! }
        ranks.append((fIO.readInt(), fIO.readInt()))
    }
    ranks.sort { $0.0 < $1.0 }
    var min = ranks[0].1
    
    for i in 1..<N {
        if ranks[i].1 < min {
            min = ranks[i].1
            result += 1
        }
    }
    print(result)
}
