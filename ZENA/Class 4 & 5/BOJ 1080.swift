/*
 https://www.acmicpc.net/problem/1080
 */
var input = readLine()!.split(separator: " ").map{ Int($0)! }
let (n, m) = (input[0], input[1])
var matrixA = Array(repeating: [Int](), count: n)
var matrixB = Array(repeating: [Int](), count: n)

for row in 0..<n {
    matrixA[row] = Array(readLine()!).map{Int(String($0))!}
}

for row in 0..<n {
    matrixB[row] = Array(readLine()!).map{Int(String($0))!}
}

if n < 3 || m < 3 {
    print(isIdentical ? 0 : -1)
} else {
    var count = 0
    for row in 0..<n-2 {
        for column in 0..<m-2 {
            if matrixA[row][column] != matrixB[row][column] {
                reverseMatrix(row, column)
                count += 1
            }
        }
    }
    print(isIdentical ? count : -1)
}

func reverseMatrix(_ row: Int, _ column: Int) {
    for offsetX in 0..<3 {
        for offsetY in 0..<3 {
            let currentValue = matrixA[row + offsetX][column + offsetY]
            matrixA[row + offsetX][column + offsetY] = currentValue == 1 ? 0 : 1
        }
    }
}

/// 두 행렬이 같은지 비교
var isIdentical: Bool {
    for row in 0..<n {
        for column in 0..<m {
            if matrixA[row][column] != matrixB[row][column] { return false }
        }
    }
    return true
}
