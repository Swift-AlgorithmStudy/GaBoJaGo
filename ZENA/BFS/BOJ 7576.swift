import Foundation

let file = FileIO()
let (M, N) = (file.readInt(), file.readInt())

var tomatos = Array(repeating: Array(repeating: 0, count: M), count: N)
for n in 0..<N {
    for m in 0..<M {
        tomatos[n][m] = file.readInt()
    }
}

var days = Array(repeating: Array(repeating: 0, count: M), count: N)
var queue = [(row: Int, col: Int)]()
for row in 0..<N {
    for col in 0..<M {
        if tomatos[row][col] == 1 {
            queue.append((row, col))
            days[row][col] = 1
        }
        else if tomatos[row][col] == -1 {
            days[row][col] = -1
        }
    }
}

let vertical = [-1, 1, 0, 0]
let horizontal = [0, 0, -1, 1]
while !queue.isEmpty {
    let (x, y) = queue.removeFirst()
    
    for index in 0..<4 {
        let newX = x + horizontal[index]
        let newY = y + vertical[index]
        if newX >= 0, newX < N,
           newY >= 0, newY < M,
           days[newX][newY] == 0 {
            days[newX][newY] = days[x][y] + 1
            queue.append((newX, newY))
        }
    }
}

var maxDay = 0
for row in 0..<N {
    for col in 0..<M {
        maxDay = max(maxDay, days[row][col])
        if days[row][col] == 0 {
            print(-1)
            exit(0)
        }
    }
}

print(maxDay-1)

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
