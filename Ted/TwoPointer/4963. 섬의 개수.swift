/***
1. w, h가 0, 0일때까지 while문을 순환한다.
2. map에 값들을 입력받는다.
3. 상하좌우대각선을 확인하면서, 만약 값이 음수이거나 범위를 벗어난 경우에는 지나친다.
4. 포함된 값에선 만약 방문하지 않았거나 섬(1)인 경우에는 방문을 true로 변경하고, dfs를 재귀로 호출한다.
5. for문으로 순환하며 값들을 확인한다.
*/

//상하좌우대각선
let dx = [0,0,-1,1,-1,1,-1,1]
let dy = [-1,1,0,0,-1,-1,1,1]

while true {
    var map = [[Int]]()
    var count = 0
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let (w, h) = (input[0], input[1])
    var visited = [[Bool]](repeating: [Bool](repeating: false, count: w), count: h)

    if w == 0 && h == 0 {
        break
    }
    
    for _ in 0..<h {
        let row = readLine()!.split(separator: " ").map { Int($0)! }
        map.append(row)
    }
    
    
    func dfs(_ row: Int, _ col: Int) {
        
        for i in 0..<dx.count {
            let nx = row + dx[i]
            let ny = col + dy[i]

            if nx < 0 || nx > w-1 || ny < 0 || ny > h-1 {
                continue
            } else {
                if !visited[ny][nx] && map[ny][nx] == 1 {
                    visited[ny][nx] = true
                    dfs(nx, ny)
                }
            }
        }
    }
    
    for col in 0..<h {
        for row in 0..<w {
            if map[col][row] == 1 && !visited[col][row] {
                visited[col][row] = true
                dfs(row, col)
                count += 1
            }
        }
    }
    print(count)
}
