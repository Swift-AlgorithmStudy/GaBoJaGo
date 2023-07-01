# Chapter 38: Breadth-First Search

여러 알고리즘 중 하나인 너비 우선 탐색(BFS) 알고리즘을 사용하여 그래프의 정점을 탐색하거나 검색할 수 있으며 다음과 같은 문제를 해결하는데 사용될 수 있습니다.

1. 최소 신장 트리 생성(?)
2. 정점 사이의 가능한 경로 찾기
3. 두 정점 사이의 최단 경로 찾기

# 예시

BFS는 그래프에서 임의의 정점을 선택하여 시작합니다.
그런 다음 해당 정점의 모든 이웃을 탐색한 후, 그 이웃들의 이웃을 탐색하고 이어서 이와 같은 과정을 반복합니다.
이름에서 알 수 있듯이, 이 알고리즘은 너비 우선 접근을 취합니다.
다음 무방향 그래프를 사용하여 BFS 예시를 살펴보겠습니다:

<img width="400" alt="스크린샷 2023-07-01 오후 3 41 57" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/609e6203-bc95-48f1-8dc8-e3fce70f4205">

> 참고: 강조된 정점은 방문한 정점을 나타냅니다.

다음에 방문할 정점을 추적하기 위해 큐를 사용할 것입니다. 큐의 선입선출 접근 방식은 한 정점의 모든 이웃을 탐색한 후에 한 단계 더 깊이 탐색하기 전에 보장됩니다.

<img width="700" alt="스크린샷 2023-07-01 오후 3 43 15" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/279abe83-2a1b-46ab-93d3-0582f8a23b64">

1. 시작하기 위해 출발 정점을 선택합니다. 여기서는 A를 선택하고 큐에 추가합니다.
2. 큐가 비어 있지 않은 한, 다음으로 큐에서 정점을 꺼내어 방문합니다. 이 경우에는 A입니다. 그 다음으로 A의 모든 이웃 정점 [B, D, C]을 큐에 추가합니다.

> 참고: 방문한 적이 없고 이미 큐에 존재하지 않는 경우에만 정점을 큐에 추가해야 함을 주의해야 합니다.

<img width="700" alt="스크린샷 2023-07-01 오후 3 44 01" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/0e11e303-0860-4637-81aa-31d2b889e565">

1. 큐가 비어 있지 않으므로 다음으로 큐에서 정점을 꺼내어 방문합니다. 이번에는 B입니다.
그런 다음 B의 이웃인 E를 큐에 추가합니다. 이미 방문한 A는 추가되지 않습니다. 큐에는 이제 [D, C, E]가 있습니다.
2. 다음으로 큐에서 꺼내어 처리할 정점은 D입니다. D에는 방문하지 않은 이웃이 없습니다. 큐에는 이제 [C, E]가 남아 있습니다.
    
<img width="700" alt="스크린샷 2023-07-01 오후 3 46 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/4bd8fc74-79f8-457b-a27a-572433e362b4">
    
3. 그다음 C를 큐에서 꺼내고 이웃인 [F, G]를 큐에 추가합니다. 큐에는 이제 [E, F, G]가 있습니다.
주의할 점은 이제 A의 모든 이웃을 방문했다는 것입니다! BFS는 이제 이웃의 두 번째 레벨로 이동합니다.
4. E를 큐에서 꺼내고 H를 큐에 추가합니다. 큐에는 이제 [F, G, H]가 있습니다. 이미 방문한 B와 큐에 이미 있는 F는 추가하지 않습니다.
    
<img width="700" alt="스크린샷 2023-07-01 오후 3 46 30" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/814a17bf-465a-4c34-83f9-e6779cb0130b">
    
5. F를 큐에서 꺼내고, 모든 이웃이 이미 큐에 있거나 방문한 상태이므로 큐에 추가할 것이 없습니다.
6. 이전 단계와 마찬가지로 G를 큐에서 꺼내고, 큐에 추가할 것이 없습니다.
    
<img width="700" alt="스크린샷 2023-07-01 오후 3 46 44" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/f3c7d5a4-dfd6-4612-9516-420bca7dd835">
    
7. 마지막으로 H를 큐에서 꺼냅니다. 큐가 비어 있으므로 너비 우선 탐색이 완료됩니다!
8. 정점을 탐색하는 과정에서 각 레벨에서의 정점을 보여주는 트리 형태의 구조를 만들 수 있습니다. 처음에는 시작한 정점, 그 다음은 이웃 정점, 그 다음은 이웃의 이웃 정점들과 이어지는 식입니다.

# 구현
```swift
extension Graph where Element: Hashable {
	func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
		// 다음에 방문할 이웃 정점을 추가
		var queue = QueueStack<Vertex<Element>>()
		// 방문한 정점 기억
		var enqueued: Set<Vertex<Element>> = []
		// 정점을 탐색한 순서를 저장하는 배열
		var visited: [Vertex<Element>] = []

		// BFS 알고리즘을 시작하기 위해 먼저 출발 정점을 큐에 넣습니다.
		queue.enqueue(source)
		enqueued.insert(source)
		// 큐가 비어 있을 때까지 정점을 큐에서 꺼냅니다.
		while let vertex = queue.dequeue() {
			// 정점을 큐에서 꺼낸 후에는 방문한 정점 목록에 추가합니다.
			visited.append(vertex)
			// 그런 다음 현재 정점에서 시작하는 모든 간선을 찾아 순회합니다.
			let neighborEdges = edges(from: vertex)
			neighborEdges.forEach { edge in
				// 각각의 간선에 대해 목적지 정점이 이전에 큐에 추가되었는지 확인하고,
				// 그렇지 않은 경우 큐에 추가합니다.
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

# 성능
BFS를 사용하여 그래프를 탐색할 때 각 정점은 한 번씩 큐에 추가됩니다.
이 과정은 O(V)의 시간 복잡도를 가집니다.
이 탐색 중에는 모든 간선도 방문합니다.
모든 간선을 방문하는 데 걸리는 시간은 O(E)입니다.
이를 합산하면 너비 우선 탐색의 전체 시간 복잡도는 O(V + E)입니다.
BFS의 공간 복잡도는 큐, enqueued, visited와 같이 세 가지 별도의 구조에 정점을 저장해야 하므로 O(V)입니다.

# Key points
- 너비 우선 탐색은 현재 노드의 인접 노드를 우선적으로 탐색하는 알고리즘
- 현재 노드의 모든 인접 노드를 우선적으로 탐색하기 위해 ‘큐’ 자료구조(FIFO)를 사용함
- 모든 경로를 탐색하기에 여러 해가 있을 경우에도 최단 경로임을 보장함