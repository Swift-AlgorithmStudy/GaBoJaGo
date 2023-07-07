
// 왜인지는 모르겠지만 순서는 상관없다고 생각해서 헷갈렸던 문제!

var numberBoard = Array(repeating: Array(repeating: 0, count: 5), count: 5)
for row in 0..<5 {
    let input = readLine()!.split(separator: " ").map({ Int($0)! })
    for col in 0..<5 {
        numberBoard[row][col] = input[col]
    }
}

var resultNumbers = Set<Int>()

for row in 0..<5 {
    for col in 0..<5 {
        dfs(row: row, col: col, value: numberBoard[row][col], count: 0)
    }
}


func dfs(row: Int, col: Int, value: Int, count: Int) {
    if count == 5 {
        resultNumbers.insert(value)
        return
    }
    
    let vertical = [-1, 1, 0, 0]
    let horizontal = [0, 0, 1, -1]
    
    for index in 0..<4 {
        let newRow = row + vertical[index]
        let newCol = col + horizontal[index]
        
        if newRow >= 0, newRow < 5,
           newCol >= 0, newCol < 5 {
            dfs(row: newRow, col: newCol, value: value * 10 + numberBoard[newRow][newCol], count: count + 1)
        }
    }
}

print(resultNumbers.count)
