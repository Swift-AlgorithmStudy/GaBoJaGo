var input = readLine()!.split(separator: " ").map({ Int($0)! })
let (numberOfNodes, numberOfEdges, startingNode) = (input[0], input[1], input[2])

var graph = Array(repeating: [Int](), count: numberOfNodes + 1)
for _ in 0..<numberOfEdges {
    input = readLine()!.split(separator: " ").map({ Int($0)! })
    graph[input[0]].append(input[1])
    graph[input[1]].append(input[0])
}

for node in 0...numberOfNodes {
    graph[node].sort()
}

var visitedDFS = Array(repeating: false, count: numberOfNodes + 1)
var visitedBFS = Array(repeating: false, count: numberOfNodes + 1)

dfs(currentNode: startingNode)
bfs(currentNode: startingNode)

func dfs(currentNode: Int) {
    print("\(currentNode)", terminator: " ")
    visitedDFS[currentNode] = true
    for nextNode in graph[currentNode] {
        if !visitedDFS[nextNode] {
            dfs(currentNode: nextNode)
        }
    }
}

func bfs(currentNode: Int) {
    print()
    var queue = [currentNode]
    visitedBFS[startingNode] = true
    
    while !queue.isEmpty {
        let nextNode = queue.removeFirst()
        print("\(nextNode)", terminator: " ")
        
        for node in graph[nextNode] {
            if !visitedBFS[node] {
                queue.append(node)
                visitedBFS[node] = true
            }
        }
    }
}
