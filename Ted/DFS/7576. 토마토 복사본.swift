let MN = readLine()!.split(separator: " ").map{ Int($0)! }
let M = MN[0]
let N = MN[1]
let dx = [0, 0, -1, 1]
let dy = [1, -1, 0, 0]

var box = [[Int]]()

for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map{ Int($0)! }
    box.append(input)
}

var day = Array(repeating: Array(repeating: 0, count: 1001), count: 1001)

var queue = [[Int]]()
var lastIdx = [0, 0]
var idx = 0
var isCooked = true

for row in 0..<N {
    for col in 0..<M {
        if box[row][col] == 1 {
            queue.append([row, col])
        }
    }
}

func bfs() {
    while idx < queue.count {
        let pop = queue[idx]
        idx += 1
        
        for i in 0..<4 {
            let nx = pop[0] + dx[i]
            let ny = pop[1] + dy[i]
            
            if nx >= 0 && nx < N && ny >= 0 && ny < M {
                if box[nx][ny] == 0 {
                    box[nx][ny] = 1
                    queue.append([nx, ny])
                    day[nx][ny] = day[pop[0]][pop[1]] + 1
                    lastIdx = [nx, ny]
                }
            }
        }
    }
}

bfs()
for row in 0..<N {
    for col in 0..<M {
        if box[row][col] == 0 {
            isCooked = false
        }
    }
}

if isCooked {
    print(day[lastIdx[0]][lastIdx[1]])
} else {
    print(-1)
}
