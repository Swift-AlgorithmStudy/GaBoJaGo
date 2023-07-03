var input = readLine()!.split(separator: " ").map({ Int($0)! })
let (n, m) = (input[0], input[1])

var drawing = Array(repeating: Array(repeating: 0, count: m), count: n)

for row in 0..<n {
    input = readLine()!.split(separator: " ").map({ Int($0)! })
    for col in 0..<m {
        drawing[row][col] = input[col]
    }
}

var visited = Array(repeating: Array(repeating: false, count: m), count: n)
var countDrawings = 0
var maxArea = 0
var currentArea = 0

for row in 0..<n {
    for col in 0..<m {
        if !visited[row][col],
           drawing[row][col] == 1 {
            countDrawings += 1
            currentArea = 1
            maxArea = max(maxArea, currentArea)
            dfs(row, col)
        } else {
            currentArea = 0
        }
    }
}

func dfs(_ row: Int, _ col: Int) {
    visited[row][col] = true
    let vertical = [-1, 1, 0, 0]
    let horizontal = [0, 0, -1, 1]
    for index in 0..<4 {
        let newX = row + vertical[index]
        let newY = col + horizontal[index]
        
        if newX >= 0, newX < n,
           newY >= 0, newY < m {
            if !visited[newX][newY], drawing[newX][newY] == 1 {
                currentArea += 1
                maxArea = max(maxArea, currentArea)
                dfs(newX, newY)
            }
        }
    }
}

print(countDrawings)
print(maxArea)
