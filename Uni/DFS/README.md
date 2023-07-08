# Chapter 40: Depth-First Search

이전 장에서는 너비 우선 탐색(BFS)을 살펴보았습니다. 이 알고리즘에서는 다음 레벨로 이동하기 전에 각 정점의 모든 이웃을 탐색해야 했습니다. 이 장에서는 깊이 우선 탐색(DFS)을 살펴보겠습니다. DFS는 그래프를 탐색하거나 검색하기 위한 다른 알고리즘입니다.

DFS에는 다양한 응용 분야가 있습니다:

- 위상 정렬
- 사이클 감지
- 미로 퍼즐과 같은 경로 탐색
- 희소 그래프에서 연결 요소 찾기

DFS를 수행하기 위해 주어진 시작 정점에서 출발하여 가능한 한 분기를 탐색하고 끝에 도달할 때까지 계속 진행합니다. 이 시점에서 되돌아가서(한 단계 뒤로 이동하여) 가능한 다음 분기를 탐색하고 원하는 결과를 찾거나 모든 정점을 방문할 때까지 계속합니다.

# 예제

DFS 예제를 진행해 봅시다. 아래의 예제 그래프는 이전 장과 동일합니다. 이를 통해 BFS와 DFS의 차이점을 확인할 수 있습니다.

<img width="400" alt="스크린샷 2023-07-01 오후 4 11 09" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/b8c244ba-6cae-42c5-aa99-cc7ba9bff45c">

레벨 이동을 추적하기 위해 스택을 사용합니다. 스택의 후입선출 접근 방식은 되돌아감(backtracking)에 도움이 됩니다. 스택에 푸시(push)하는 것은 한 단계 더 깊이 이동하는 것을 의미합니다. 만약 막다른 길에 도달하면 이전 단계로 돌아갈 수 있도록 팝(pop)할 수 있습니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 11 48" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/f996cf82-2b14-47b0-a824-7dd02694cba2">

1. 이전 장과 마찬가지로 시작 정점으로 A를 선택하고 스택에 추가합니다.
2. 스택이 비어 있지 않은 한, 스택의 맨 위 정점을 방문하고 아직 방문하지 않은 첫 번째 이웃 정점을 푸시(push)합니다. 이 경우, A를 방문하고 B를 푸시합니다.

> 이전 장에서 기억하시겠지만, 간선을 추가하는 순서는 탐색 결과에 영향을 줍니다. 이 경우에는 A에 추가된 첫 번째 간선이 B로의 간선이므로, B가 먼저 푸시됩니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 14 00" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/a389a145-77bb-4092-886b-aa48fed388d9">

1. B를 방문하고 A가 이미 방문되었으므로 E를 푸시합니다.
2. E를 방문하고 F를 푸시합니다.

주목해야 할 점은 스택에 푸시할 때마다 한 가지 분기로 더 깊이 이동한다는 것입니다. 인접한 모든 정점을 방문하는 대신에, 끝까지 경로를 따라 내려갔다가 되돌아갑니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 14 43" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/928ebee8-6d2f-492f-a379-3255ae14202b">

1. F를 방문하고 G를 푸시합니다.
2. G를 방문하고 C를 푸시합니다.

<img width="412" alt="스크린샷 2023-07-01 오후 4 15 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/5d518400-e00d-4337-affc-1bceaa61bfa4">

1. 방문할 다음 정점은 C입니다. 이웃 정점은 [A, F, G]인데, 이들 모두가 이미 방문되었습니다. 막다른 길에 도달했으므로 C를 스택에서 팝합니다.
2. 이로써 G로 돌아옵니다. G의 이웃은 [F, C]이지만, 이들도 모두 이미 방문되었습니다. 다시 막다른 길이므로 G를 팝합니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 15 17" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/efb1c8dd-f76a-4912-9253-13b0278565dc">

1. F도 더 이상 방문하지 않은 이웃이 없으므로 F를 팝합니다.
2. 이제 E에 돌아왔습니다. E의 이웃인 H는 아직 방문되지 않았으므로 H를 스택에 푸시합니다.

<img width="398" alt="스크린샷 2023-07-01 오후 4 15 37" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/b34963fb-5e7e-4bd2-b928-1643c3bd83fc">

1. H를 방문하면 다시 막다른 길이므로 H를 팝합니다.
2. E에도 더 이상 방문하지 않은 이웃이 없으므로 E를 팝합니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 15 53" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/2e6e76cd-ba08-43f4-98da-5a24a472fa4b">

1. B도 마찬가지로 사용 가능한 이웃이 없으므로 B를 팝합니다.
2. 이렇게 하면 A까지 돌아옵니다. A의 이웃인 D는 아직 방문되지 않았으므로 D를 스택에 푸시합니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 16 10" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/91d1c213-3128-4354-aa1f-13cb38385009">


1. D를 방문하면 다시 막다른 길이므로 D를 팝합니다.
2. A로 돌아왔지만 이번에는 푸시할 수 있는 이웃이 없으므로 A를 팝합니다. 스택은 이제 비어 있고 DFS가 완료되었습니다.

정점을 탐색하면서 방문한 분기를 나타내는 트리 모양의 구조를 만들 수 있습니다. DFS가 BFS와 비교하여 얼마나 깊이 들어갔는지 확인할 수 있습니다.

<img width="700" alt="스크린샷 2023-07-01 오후 4 16 33" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/fd5bd924-fcb9-4da9-b05c-6806ce2918ba">

# 구현

```swift
extension Graph where Element: Hashable {
	func depthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
		// 그래프를 통해 경로를 저장하는 데 사용됩니다.
		var stack: Stack<Vertex<Element>> = []
		// 이전에 푸시된 정점을 기억하여 같은 정점을 두 번 방문하지 않도록 합니다.
		// O(1)의 빠른 조회를 위해 Set으로 구현되었습니다.
		var pushed: Set<Vertex<Element>> = []
		// 정점이 방문된 순서를 저장하는 배열입니다. 알고리즘을 시작하기 위해 소스 정점을 세 가지에 모두 추가합니다.
		var visited: [Vertex<Element>] = []
		stack.push(source)
		pushed.insert(source)
		visited.append(source)

		// 스택의 맨 위 정점을 확인하기 위해 스택이 비어 있을 때까지 계속합니다.
		// 중첩된 루프 내에서도 다음 정점으로 계속 진행할 수 있는 방법이 있도록 이 루프를 outer로 라벨링했습니다.
		outer: while let vertex = stack.peek() {
			// 현재 정점의 모든 이웃 간선을 찾습니다.
			let neighbors = edges(from: vertex)
			// 이웃 간선이 없는 경우, 정점을 스택에서 팝하고 다음 정점으로 계속합니다.
			guard !neighbors.isEmpty else {
				stack.pop()
				continue
			}
			// 여기에서는 현재 정점에 연결된 모든 간선을 순환하면서 이웃 정점이 이미 방문되었는지 확인합니다.
			// 방문되지 않은 경우, 스택에 푸시(push)하고 visited 배열에 추가합니다.
			// 이 정점을 이미 방문했다고 표시하는 것은 약간 이른 것처럼 보일 수 있지만, 정점이 스택에 추가된 순서대로 방문되므로 올바른 순서가 유지됩니다.
			for edge in neighbors {
				if !pushed.contains(edge.destination) {
					stack.push(edge.destination)
					pushed.insert(edge.destination)
					visited.append(edge.destination)
					// 방문할 이웃을 찾았으므로 outer 루프를 계속하고, 새로 푸시된 이웃으로 이동합니다.
					continue outer
				}
			}
			// 현재 정점에 방문하지 않은 이웃이 없다면, 막다른 길에 도달한 것이므로 정점을 스택에서 팝할 수 있습니다.
			stack.pop()
		}
		return visited
	}
}
```

# 성능
DFS는 최소한 한 번씩 모든 정점을 방문합니다. 이 과정의 시간 복잡도는 O(V)입니다.
DFS에서 그래프를 탐색할 때, 방문 가능한 이웃 정점을 찾기 위해 모든 이웃 정점을 확인해야 합니다.
이 작업의 시간 복잡도는 최악의 경우 그래프의 모든 간선을 방문해야 하므로 O(E)입니다.
따라서, 깊이 우선 탐색의 전체 시간 복잡도는 O(V + E)입니다.
깊이 우선 탐색의 공간 복잡도는 스택, pushed, visited와 같은 세 가지 별도의 데이터 구조에 정점을 저장해야하므로 O(V)입니다.

# Key Points
- 깊이 우선 탐색은 그래프를 탐색하거나 검색하기 위한 알고리즘
- 깊이 우선 탐색은 끝에 도달할 때까지 가능한 한 분기를 탐색
- 스택 데이터 구조를 활용하여 그래프의 깊이를 추적. 막다른 길에 도달할 때만 스택에서 pop하면 됨