let numberOfComputers = Int(readLine()!)!
let numberOfEdges = Int(readLine()!)!

var graph = Array(repeating: [Int](), count: numberOfComputers + 1)

for _ in 0..<numberOfEdges {
    let input = readLine()!.split(separator: " ").map({ Int($0)! })
    graph[input[0]].append(input[1])
    graph[input[1]].append(input[0])
}

var queue = [1]
var wormVirusComputers = 0
var visited = Array(repeating: false, count: numberOfComputers + 1)
visited[1] = true

while !queue.isEmpty {
    let computer = queue.removeFirst()
    wormVirusComputers += 1
    for nextComputer in graph[computer] {
        if visited[nextComputer] { continue }
        queue.append(nextComputer)
        visited[nextComputer] = true
    }
}

print(wormVirusComputers - 1)

/*
 1번 컴퓨터가 웜 바이러스에 걸렸을 때, "1번 컴퓨터를 통해 웜 바이러스에 걸리게 되는 컴퓨터의 수"를 첫째 줄에 출력한다.
 "1번 컴퓨터를 통해 웜 바이러스에 걸리게 되는 컴퓨터의 수"를 출력하라 했으므로 1번 컴퓨터는 제외
 */
