import Foundation

// 중복 방문을 허용하지 않는 BFS (어느 버튼을 눌러도 가중치는 1이므로)
var input = readLine()!.split(separator: " ").map({ Int($0)! })
let (F, S, G, U, D) = (input[0], input[1], input[2], input[3], input[4])
/*
 F: 건물 층 수
 S: 강호가 현재 있는 층
 G: 스타트링크 층 (이동해야 하는 층)
 */

if S == G {
    print(0)
    exit(0)
}

var queue = [Int]()
var visited = Array(repeating: false, count: F + 1)
queue.append(S)
visited[S] = true
var countOfMove = 0

while !queue.isEmpty {
    let lastFloors = queue.count
    for _ in 0..<lastFloors {
        let currentFloor = queue.removeFirst()
        
        // MARK: UP
        let nextUpFloor = currentFloor + U
        if nextUpFloor <= F, !visited[nextUpFloor] {
            if nextUpFloor == G {
                print(countOfMove + 1)
                exit(0)
            }
            queue.append(nextUpFloor)
            visited[nextUpFloor] = true
        }
        
        // MARK: DOWN
        let nextDownFloor = currentFloor - D
        if nextDownFloor >= 1, !visited[nextDownFloor] {
            if nextDownFloor == G {
                print(countOfMove + 1)
                exit(0)
            }
            queue.append(nextDownFloor)
            visited[nextDownFloor] = true
        }
    }
    countOfMove += 1
}

print("use the stairs")
