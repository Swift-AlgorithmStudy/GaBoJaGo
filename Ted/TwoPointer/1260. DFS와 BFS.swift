/***
1. N, M, V를 받아오고, 그래프를 2차원 배열로 만들고 visited 배열을 1차원 배열로 만든다.
  그래프를 2차원 배열로 만든 이유는 정점이 다른 정점들과 연결되어 있는지 보여주기 위함이다.
2. 연결되어 있는 정점(a,b)을 받아온다.
3. graph[a], graph[b]에 각각 b,a를 추가해준다. 
  a 정점에 b를 추가하고, b정점에도 a를 추가하기 위함
4. 그 뒤 오름차순으로 정렬해준다. 
5. dfs와 bfs 함수를 만들어준다.
5-1. dfs : 그래프를 순환하여 만약 방문한 곳이 없다면 재귀를 통해 다시 순환하고, 방문한 곳은 true로 변경해준다.
5-2-1. bfs : 방문이 필요한 곳(needVisit)과 방문한 곳(visited)을 만든다.
5-2-2. 만약 방문이 필요한 곳이 비어있지 않다면, 가장 첫번째 값을 제거하면서 node라는 변수로 선언한다.
5-2-3. 만약 visited에 node가 없다면 node를 추가하고 needVisit에 graph[node]를 추가한다.
*/

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (N, M, V) = (input[0], input[1], input[2])
var graph: [[Int]] = Array(repeating: [], count: N+1)
//정점이 어떤 정점들과 연결되어 있는지 보여줌
//ex) 1번 정점과 연결된 정점 [ , ], 2번 정점과 연결된 정점 [ , ]
var visited = Array(repeating: false, count: N+1)
var result = ""


for _ in 0..<M {
    let relation = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b) = (relation[0], relation[1])
    
    graph[a].append(b)
    graph[b].append(a)
    graph[a].sort()
    graph[b].sort()
}

func dfs(_ V: Int) {
    visited[V] = true
    result += "\(V) "
    for i in graph[V] {
        if !visited[i] {
            dfs(i)
        }
    }
}

func bfs(_ V: Int) {
    var needVisit: [Int] = [V]
    var visited = Set<Int>()
    
    while !needVisit.isEmpty {
        let node = needVisit.removeFirst()
        
        if !visited.contains(node) {
            visited.insert(node)
            result += "\(node) "
            needVisit.append(contentsOf: graph[node])
        }
    }
}

dfs(V)
print(result)
result = "" //초기화
bfs(V)
print(result)
