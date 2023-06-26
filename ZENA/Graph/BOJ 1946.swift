/*
 https://www.acmicpc.net/problem/1946
 
 메모리 125524KB, 시간 488ms, 코드길이 1112B
 
 입력
 테케 개수 T
 (0..<T)
 지원자 수 N
 (0..<N)
 (서류 순위, 면접 순위)
 
 출력
 신입사원으로 뽑힌 사원의 수
 
 서류 점수로 정렬 -> 나머지는 면접 순위만 보면 됨
 뒤로 갈수록 이전 사람보다 서류순위는 낮은거니까, 면접 순위만 높으면 됨
 (숫자는 작아야함. <.)
 면접 순위 숫자가 작으면 신입사원으로 뽑히고 +1,
 prevRank를 이 사람의 면접 순위로 갱신
 */

import Foundation

final class FileIO {
    @inline(__always) private var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], index = 0

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum: Int = 0, now = read(), isNegative = false
        while now == 10 || now == 32 { now = read() }
        if now == 45 { isNegative = true; now = read() }
        while 48...57 ~= now { sum = sum * 10 + Int(now - 48); now = read() }
        return sum * (isNegative ? -1 : 1)
    }
}

let fileIO = FileIO()
let T = fileIO.readInt()

for _ in 0..<T {
    let N = fileIO.readInt()
    var ranks = [(Int, Int)]()
    for _ in 0..<N {
        ranks.append((fileIO.readInt(), fileIO.readInt()))
    }
    ranks = ranks.sorted{ $0.0 < $1.0 }
    var newbie = 0
    var prevRank = Int.max
    for rank in ranks {
        if rank.1 < prevRank {
            newbie += 1
            prevRank = rank.1
        }
    }
    print(newbie)
}
