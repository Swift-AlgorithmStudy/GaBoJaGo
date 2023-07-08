/***
1. 그림을 저장할 배열(grid)과 크기를 입력받는다.
2. bfs 메소드에서 x, y, 색상, 색맹 여부, 방문 여부를 파라미터로 받는다.
3. 처음 x, y을 큐에 추가한다.
4. 큐에 값을 제거하며 현재 값(curX, curY)으로 지정한다.
5. 상하좌우를 순환하며 해당 값(nx, ny)이 0보다 크고 크기보다 작거나 방문하지 않은 곳이라면,
5-1. 적록색약이 아니라면 큐에 값을 추가하고, 방문했다고 작성한다.
5-2. 적록색약이라면 적색과 녹색을 같이 보고 큐에 추가한다.
6. countAreas 메소드에서 bfs를 순환한다.
7. 만약 방문하지 않은 곳이 있다면 count를 추가한다.
*/

let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]
var grid = [[Character]]() // 그림을 저장할 2차원 배열
let n = Int(readLine()!)! // 그리드의 크기 입력 받기

for _ in 0..<n {
    let row = Array(readLine()!)
    grid.append(row)
}

func bfs(_ x: Int, _ y: Int, _ color: Character, _ isBlind: Bool, _ visited: inout [[Bool]]) {
    var queue = [(Int, Int)]()
    queue.append((x, y))
    visited[x][y] = true

    while !queue.isEmpty {
        let (curX, curY) = queue.removeFirst()

        for i in 0..<4 {
            let nx = curX + dx[i]
            let ny = curY + dy[i]

            if nx >= 0 && nx < n && ny >= 0 && ny < n && !visited[nx][ny] {
                if !isBlind { // 적록색약이 아닌 경우
                    if grid[nx][ny] == color {
                        queue.append((nx, ny))
                        visited[nx][ny] = true
                    }
                } else { // 적록색약인 경우
                    if (color == "R" || color == "G") && (grid[nx][ny] == "R" || grid[nx][ny] == "G") {
                        queue.append((nx, ny))
                        visited[nx][ny] = true
                    } else if color == "B" && grid[nx][ny] == "B" {
                        queue.append((nx, ny))
                        visited[nx][ny] = true
                    }
                }
            }
        }
    }
}

func countAreas(_ isBlind: Bool) -> Int {
    var visited = Array(repeating: Array(repeating: false, count: n), count: n)
    var count = 0

    for i in 0..<n {
        for j in 0..<n {
            if !visited[i][j] {
                bfs(i, j, grid[i][j], isBlind, &visited)
                count += 1
            }
        }
    }

    return count
}

let normalCount = countAreas(false) // 적록색약이 아닌 경우 구역의 수 계산
let blindCount = countAreas(true) // 적록색약인 경우 구역의 수 계산

print("\(normalCount) \(blindCount)")
