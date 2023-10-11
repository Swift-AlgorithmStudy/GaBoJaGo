/*
 https://www.acmicpc.net/problem/10924
 
 for문 안에서 print문을 반복출력하는 것 때문에 시간초과가 계속 났던 문제
 FileIO 클래스를 통해 입력받아야 함
 
 타입명시까지 해줬는데 없어도 됐음
 */

import Foundation

let file = FileIO()
let N = file.readInt()
var numbers = [-1]
var dp = Array(repeating: Array(repeating: false, count: N+1), count: N+1)

// input, length 1
for n in 1...N {
    numbers.append(file.readInt())
    dp[n][n] = true
}

// length 2
for n in 1..<N {
    if numbers[n] == numbers[n + 1] {
        dp[n][n + 1] = true
    }
}

let M = file.readInt()

// length > 3
for row in stride(from: N-2, through: 1, by: -1) {
    for col in row+2...N {
        if dp[row + 1][col - 1],
           numbers[row] == numbers[col] {
            dp[row][col] = true
        }
    }
}

var result = ""
for _ in 0..<M {
    result += "\(dp[file.readInt()][file.readInt()] ? 1 : 0)\n"
}
print(result)

final class FileIO {
    private var buffer:[UInt8]
    private var index: Int
    
    init(fileHandle: FileHandle = FileHandle.standardInput) {
        buffer = Array(fileHandle.readDataToEndOfFile())+[UInt8(0)]
        index = 0
    }
    
    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        
        return buffer.withUnsafeBufferPointer { $0[index] }
    }
    
    @inline(__always) func readInt() -> Int {
        var sum = 0
        var now = read()
        var isPositive = true
        
        while now == 10 || now == 32 { now = read() }
        if now == 45{ isPositive.toggle(); now = read() }
        while now >= 48, now <= 57 {
            sum = sum * 10 + Int(now-48)
            now = read()
        }
        
        return sum * (isPositive ? 1:-1)
    }
}
