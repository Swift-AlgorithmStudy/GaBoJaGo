/*
 https://www.acmicpc.net/problem/17144
 */
func diffusion() {
    var storeDiffusion = Array(repeating: Array(repeating: 0, count: C), count: R)
    for row in 0..<R {
        for col in 0..<C {
            if room[row][col] > 0 {
                var diffusedCount = 0
                let diffusionAmount = room[row][col] / 5
                
                for index in 0..<4 {
                    let (newRow, newColumn) = (row + dx[index], col + dy[index])
                    if newRow < 0 || newRow >= R || newColumn < 0 || newColumn >= C || room[newRow][newColumn] == -1 { continue }
                    diffusedCount += 1
                    storeDiffusion[newRow][newColumn] += diffusionAmount
                }
                storeDiffusion[row][col] -= (diffusedCount * diffusionAmount)
            }
        }
    }
    room = zip(room, storeDiffusion).map { zip($0, $1).map { $0 + $1 }}
}

func airPurification() {
    // 반시계방향
    let row = airPurifier[0].0
    let col = airPurifier[0].1
    
    for newRow in stride(from: row - 1, through: 1, by: -1) {
        room[newRow][col] = room[newRow-1][col]
    }
    for newCol in stride(from: 0, through: C-2, by: 1) {
        room[0][newCol] = room[0][newCol+1]
    }
    for newRow in stride(from: 0, through: row - 1, by: 1) {
        room[newRow][C-1] = room[newRow+1][C-1]
    }
    for newCol in stride(from: C-1, through: 2, by: -1) {
        room[row][newCol] = room[row][newCol-1]
    }
    room[row][col + 1] = 0
    
    // 시계방향
    let x = airPurifier[1].0
    let y = airPurifier[1].1
    
    for newX in stride(from: x + 1, through: R - 2, by: 1) {
        room[newX][y] = room[newX + 1][y]
    }
    for newY in stride(from: 0, through: C-2, by: 1) {
        room[R - 1][newY] = room[R - 1][newY + 1]
    }
    for newX in stride(from: R - 1, through: x + 1, by: -1) {
        room[newX][C - 1] = room[newX - 1][C - 1]
    }
    for newY in stride(from: C - 1, through: 2, by: -1) {
        room[x][newY] = room[x][newY - 1]
    }
    room[x][y + 1] = 0
}

func printRoom() {
    for row in 0..<R {
        print(room[row])
    }
    print()
}

var input = readLine()!.split(separator: " ").map { Int($0)! }
let (R, C, T) = (input[0], input[1], input[2])
var room = [[Int]]()
var airPurifier = [(Int, Int)]()

let dx = [1, -1, 0, 0]
let dy = [0, 0, -1, 1]

for row in 0..<R {
    input = readLine()!.split(separator: " ").map { Int($0)! }
    for column in 0..<input.count {
        if input[column] == -1 {
            airPurifier.append((row, column))
        }
    }
    room.append(input)
}

for _ in 0..<T {
    diffusion()
    airPurification()
}

print(room.flatMap{$0}.filter{$0 > 0}.reduce(0, +))
