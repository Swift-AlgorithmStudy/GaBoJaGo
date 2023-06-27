# BFS(Breadth-First Search)

지난 장에서는 객체들의 관계를 파악하기 위해 그래프를 사용하였습니다. 정점(vertices)과 간선(edges)은 객체들 간의 관계를 표현합니다. 

여러 알고리즘은 그래프의 정점을 탐색하거나 순회하기 위해 존재합니다. 이러한 알고리즘 중 하나는 너비 우선 탐색(BFS) 알고리즘입니다.

BFS는 다양한 문제들을 해결할 수 있습니다.

1. 최소 신장 트리를 만들 수 있습니다.
2. 정점 간의 잠재적 경로를 찾을 수 있습니다.
3. 두 정점 간 가장 짧은 경로를 찾을 수 있습니다.

- 신장 트리(Spanning Tree)
    
    **신장 트리(Spanning Tree)**
    
    - 그래프 내의 모든 정점을 포함하는 트리입니다.
    - 그래프의 최소 연결 부분 그래프입니다.
        - 최소 연결 = 간선의 수가 가장 적습니다.
        - n개의 정점을 가지는 그래프의 최소 간선의 수는 (n-1)개이고, (n-1)개의 간선으로 연결되어 있으면 필연적으로 트리 형태가 되고 이것이 바로 Spanning Tree가 됩니다.
        
    
    신장 트리의 특징
    
    - DFS, BFS을 이용하여 그래프에서 신장 트리를 찾을 수 있습니다.
        - 탐색 도중에 사용된 간선만 모으면 만들 수 있습니다.
    - 하나의 그래프에는 많은 신장 트리가 존재할 수 있습니다.
    - Spanning Tree는 트리의 특수한 형태이므로 모든 정점들이 연결되어 있어야 하고, 사이클을 포함해서는 안됩니다.
    - 따라서 Spanning Tree는 그래프에 있는 n개의 정점을 정확히 (n-1)개의 간선으로 연결합니다.
    
    **최소 신장 트리(Minimum Spanning Tree)**
    
    - Spanning Tree 중에서 사용된 간선들의 가중치 합이 최소인 트리입니다.
    - 각 간선의 가중치가 동일하지 않을 때 단순히 가장 적은 간선을 사용한다고 해서 최소 비용이 얻어지는 것은 아닙니다.
    - MST는 간선의 가중치를 고려하여 최소 비용의 Spanning Tree를 선택하는 것을 말합니다.
    
    최소 신장 트리의 특징
    
    - 간선의 가중치의 합이 최소여야 합니다.
    - n개의 정점을 가지는 그래프에 대해 반드시 (n-1)개의 간선만을 이용해야 합니다.
    - 사이클이 포함되어서는 안됩니다.
    

## Example

BFS는 그래프의 정점을 선택하는 것으로부터 시작합니다. 이 알고리즘은 그 정점의 모든 이웃에 대해 탐색한 후, 이웃의 이웃을 탐색하는 과정을 반복합니다. 이름에서 알 수 있듯이, 이 알고리즘은 너비를 우선으로 접근합니다.

무방향 그래프를 통해 BFS 예시를 확인해보겠습니다. (하이라이트 된 정점은 방문된 정점입니다.)

<img width="333" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/7fcc13b2-b5a4-4024-98d8-72afec6ed289">

큐를 통해 다음에 방문할 정점에 대해 추적할 것입니다. 큐의 FIFO 접근법은 한 레벨을 들어가기 전에 정점의 이웃들의 방문이 보장됩니다.

<img width="484" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/a567b99c-0d95-4763-9b1e-f8cba8e83952">

1. 시작하기 위해, 시작 정점을 선택합니다. 여기선 A를 선택하였는데, 이는 큐에 추가됩니다.
2. 이 경우에는 큐에 비어있지 않는 한, dequeue를 하고 다음 정점을 방문합니다. 다음으론, A의 이웃 정점인 [B, D, C]를 큐에 추가합니다.

Note. 아직 방문되지 않거나 큐에 이미 있지 않은 정점들만 추가해야 합니다.

<img width="550" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/8d860710-7104-4af3-83ec-6fda56fd2ae3">

3. 큐가 비어있지 않기 때문에 dequeue를 한 뒤 다음 정점인 B를 방문합니다. 그리고 B의 이웃인 E를 큐에 추가합니다. A는 이미 방문되었기 때문에 큐에 추가되지 않습니다. 이제 큐는 [D, C, E]가 됩니다.
4. 다음으로 dequeue될 정점은 D입니다. D는 아직 방문되지 않은 이웃이 없습니다. 
이제 큐는 [C, E]가 됩니다.

<img width="509" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/a6b915c1-62b1-42c1-9422-cf3ff6ce599d">

5. 다음으로, C를 dequeue하고 C의 이웃인 [F, G]를 큐에 추가합니다. 이제 큐는 [E, F, G]입니다.
이제 A의 이웃을 전부다 방문하였습니다. BFS는 2번째 수준의 이웃으로 이동합니다.
6. E를 dequeue하고 H를 큐에 추가합니다. 큐는 이제 [F, G, H]가 됩니다. 
B는 이미 방문되었고, F는 큐에 있기 때문에 큐에 추가하지 않습니다.

<img width="542" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/05ad0cf0-ab8a-4a0f-84ff-043188e06d4c">

7. F를 dequeue하고, 모든 이웃들이 방문되었거나 이미 큐에 있기 때문에 큐에 추가할 것이 없습니다.
8. 이전 단계와 같이 G를 dequeue하고 큐에 아무것도 추가하지 않습니다.

<img width="580" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5d58582b-09d1-4bfa-9c04-8aa8b3144dcd">

9. 마지막으로 H를 dequeue합니다. 큐가 비었기 때문에 BFS가 완료되었습니다.
10. 정점들을 탐험하면서, 정점들의 각 레벨을 보여주는 트리 모양의 구조를 생성할 수 있습니다. 먼저 시작한 정점부터 그 이웃들, 그리고 이웃의 이웃들로 만들어집니다.

## Implementation

playround 파일에 해당 코드를 추가합니다.

```swift
extension Graph where Element: Hashable {

  func breadthFirstSearch(from source: Vertex<Element>)
      -> [Vertex<Element>] {
    var queue = QueueStack<Vertex<Element>>()
    var enqueued: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []

    // more to come

    return visited
  }
}
```

시작 정점을 포함하고 있는 `breadthFirstSearch(from:)` 메소드를 정의하였습니다. 여기서는 세 가지의 자료 구조를 사용합니다.

1. queue는 다음에 방문할 이웃 정점들을 추적합니다.
2. enqueued는 이전에 enqueue가 되었던 정점들을 기억하여 같은 정점을 두 번 enqueue하지 않도록 합니다. 여기서 Set 타입을 사용함으로써 탐색이 O(1)만 소요되게 합니다.
3. visited는 정점들이 탐색된 순서를 저장하는 배열입니다.

다음으로 주석 대신에 메소드를 추가해줍니다.

```swift
extension Graph where Element: Hashable {

  func breadthFirstSearch(from source: Vertex<Element>)
      -> [Vertex<Element>] {
    var queue = QueueStack<Vertex<Element>>()
    var enqueued: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []

    // more to come
		queue.enqueue(source) // 1
		enqueued.insert(source)
		
		while let vertex = queue.dequeue() { // 2
		  visited.append(vertex) // 3
		  let neighborEdges = edges(from: vertex) // 4
		  neighborEdges.forEach { edge in
		    if !enqueued.contains(edge.destination) { // 5
		      queue.enqueue(edge.destination)
		      enqueued.insert(edge.destination)
		    }
		  }
		}

    return visited
  }
}
```

1. 출발 정점(source vertex)를 enqueue하면서 BFS 알고리즘을 시작합니다.
2. 큐가 비어있을 때까지 큐에서 정점들을 dequeue합니다.
3. 큐에서 정점을 dequeue할 때마다 해당 정점을 방문된(visited) 정점의 리스트에 추가합니다.
4. 그리고, 현재 정점으로 시작되는 모든 엣지를 찾고 이를 반복합니다.
5. 각각의 엣지에서 목표 정점이 이전에 enqueue되었나 확인하고, 만약 아니라면 코드에 추가합니다.

BFS를 실행하기 위해서는 이와 같으면 됩니다.

```swift
let vertices = graph.breadthFirstSearch(from: a)
vertices.forEach { vertex in
  print(vertex)
}

0: A
1: B
2: C
3: D
4: E
5: F
6: G
7: H
```

이웃 정점에 있어서 생각해야 될 것은 그래프가 어떻게 만들어졌냐에 따라 방문의 순서가 결정됩니다. 
A와 B 사이에 엣지를 추가하기 전에 A와 C 사이에 엣지를 더할 수 도 있었습니다. 

## Performance

BFS를 통해 그래프를 횡된할 때에, 각각의 정점은 한 번만 enqueue됩니다. 이 프로세스는 O(V)의 시간 복잡도를 가집니다. 이 횡단 동안, 모든 엣지들 또한 방문해야 합니다. 모든 엣지를 방문하는 것은 O(E)의 시간 복잡도를 가집니다. 두 가지를 함께 더하는 것은 BFS의 전체적인 시간 복잡도가 O(V + E)임을 의미합니다.

queue, enqueued, visited의 세 가지 구조의 정점들을 저장해야 하기 때문에 BFS의 공간 복잡도는 O(V)가 됩니다.

## Key points

- BFS는 그래프를 순회하거나 탐색하기 위한 알고리즘입니다.
- BFS는 다음 레벨의 정점들을 순회하기 전에 현재 정점의 이웃들을 순회합니다.
- 그래프 구조가 이웃 정점들이 매우 많거나 모든 경우의 수를 찾아야 할 때 이 알고리즘은 일반적으로 좋습니다.
- 큐 자료 구조는 정점의 간선을 우선적으로 탐색하고 더 깊은 수준으로 이동하기 전에 사용됩니다.
