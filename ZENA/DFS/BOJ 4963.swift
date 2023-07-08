let vertical = [-1, 1, 0, 0, -1, -1, 1, 1]
let horizontal = [0, 0, -1, 1, -1, 1, -1, 1]
while true {
    var input = readLine()!.split(separator: " ").map({ Int($0)! })
    let (w, h) = (input[0], input[1])
    if w == 0, h == 0 {
        break
    }
    var island = Array(repeating: Array(repeating: 0, count: w), count: h)
    for row in 0..<h {
        input = readLine()!.split(separator: " ").map({ Int($0)! })
        for col in 0..<w {
            island[row][col] = input[col]
        }
    }
    
    var visited = Array(repeating: Array(repeating: false, count: w), count: h)
    var queue = [(Int, Int)]()
    var count = 0
    
    for row in 0..<h {
        for col in 0..<w {
            if island[row][col] == 1,
               !visited[row][col] {
                count += 1
                visited[row][col] = true
                queue.append((row, col))
                
                // dfs
                while !queue.isEmpty {
                    let (x, y) = queue.removeFirst()
                    
                    for index in 0..<8 {
                        let newX = x + vertical[index]
                        let newY = y + horizontal[index]
                        
                        if newX >= 0, newX < h,
                           newY >= 0, newY < w,
                           island[newX][newY] == 1,
                           !visited[newX][newY] {
                            visited[newX][newY] = true
                            queue.append((newX, newY))
                        }
                    }
                }
            }
        }
    }
    print(count)
}
