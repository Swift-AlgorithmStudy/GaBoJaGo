let MAX_POSITION = 100_001

var input = readLine()!.split(separator: " ").map({ Int($0)! })
let (N, K) = (input[0], input[1])

var visited = Array(repeating: false, count: MAX_POSITION)
var time = Array(repeating: 0, count: MAX_POSITION)

var queue = [Int]()
queue.append(N)

while !queue.isEmpty {
    let current = queue.removeFirst()
    if current == K {
        break
    }

    let movement = [-1, 1, current]

    for move in movement {
        let next = current + move
        if next >= 0, next < MAX_POSITION, !visited[next] {
            if time[next] == 0 {
                time[next] = time[current] + 1
                queue.append(next)
            }
        }
    }
}

print(time[K])
