#BFS

BFS는 그래프를 탐색하는 방법중 하나이다. 인접한 노드들을 탐색하고 다 탐색하면 인접한 노드들의 노드들부터 탐색하는 것이다.

## 구현

너비 우선 탐색은 보통 두개의 큐로 구현.

1. 방문해야하는 노드를 저장하는 Queue
2. 이미 방문한 노드를 저장하는 Queue

- 탐색할 노드의 데이터를 needVisitQueue에 insert

- needVisitQueue의 첫 번째 값을 추출해서, visitedQueue에 해당 값이 존재하는지 확인

- 추출된 값이 visitedQueue에 존재하지 않으면,visitedQueue에 추가한다. 

- 추출된 값에 연결된 에지들을 모두 needVisitQueue에 추가

```swift
extension Graph where Element: Hashable {
  
  func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
    var queue = QueueStack<Vertex<Element>>()
    var enqueued: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []
    
    queue.enqueue(source)
    enqueued.insert(source)
    
    while let vertex = queue.dequeue() {
      visited.append(vertex)
      let neighborEdges = edges(from: vertex)
      neighborEdges.forEach { edge in
        if !enqueued.contains(edge.destination) {
          queue.enqueue(edge.destination)
          enqueued.insert(edge.destination)
        }
      }
    }
    
    return visited
  }
}
```
