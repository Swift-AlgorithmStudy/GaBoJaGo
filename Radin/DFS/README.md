# Chap19. Depth-First Search

이전 장에서는 다음 단계로 가기 전에 정점의 모든 이웃을 탐험해야 하는 폭 우선 검색(BFS)을 살펴보았습니다. 이 장에서는 그래프를 가로지르거나 검색하는 또 다른 알고리즘인 깊이 우선 검색(DFS)을 살펴볼 것입니다.

DFS를 수행하려면, 주어진 소스 정점으로 시작하여 끝에 도달할 때까지 가능한 한 지점을 탐색하려고 시도합니다. 이 시점에서, 당신은 뒤로 물러서서 당신이 찾고 있는 것을 찾거나 모든 정점을 방문할 때까지 다음 사용 가능한 지점을 탐험할 것입니다.

DFS에는 많은 응용 프로그램이 있습니다:

- **위상 정렬(Topological sorting)**: 
그래프의 노드를 일련의 순서로 나열하는 작업입니다.
- **사이클 감지(Detecting a cycle)**: 
그래프에서 사이클을 감지하는 작업입니다.
- **경로 찾기(Pathfinding)**: 
미로 퍼즐과 같은 문제에서 경로를 찾는 작업입니다.
- **희소 그래프에서 연결 요소 찾기(Finding connected components in a sparse graph)**: 
희소 그래프에서 연결된 구성 요소를 찾는 작업입니다.

## 예시

DFS 예시를 살펴봅시다. 아래의 예시 그래프는 이전 장과 동일합니다. 
이것은 당신이 BFS와 DFS의 차이점을 볼 수 있도록 하기 위함입니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/cd80e5c7-5a6d-4fc8-9c08-2c5ad284f23a" width="500">

통과하는 레벨을 추적하기 위해 스택을 사용할 것입니다. **스택의 Lifo(Last In First Out)접근 방식은 역추적에 도움이 된다**. 스택의 모든 푸시는 당신이 한 단계 더 깊게 움직인다는 것을 의미합니다. 막다른 골목에 도달하면 이전 레벨로 돌아갈 수 있습니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/b23e85fb-7f8a-4483-9b64-9ee940dcef23" width="500">

1. A를 시작 정점으로 선택하고 스택에 추가합니다.
2. 스택이 비어 있지 않을 동안 스택의 상단 정점을 방문하고 아직 방문하지 않은 첫 번째 이웃 정점을 추가합니다. A를 방문하고 B를 추가하세요.

<aside>
👀 이전 장에서 가장자리를 추가하는 순서가 검색 결과에 영향을 미친다는 것을 기억하세요. 
이 경우, A에 추가된 첫 번째 가장자리는 B의 가장자리였기 때문에, B가 먼저 추가됩니다.

</aside>
<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/91b7949a-1f4a-4d5d-b256-a6af8c68f273" width="500">

3. A가 이미 방문되었기 때문에 B를 방문하고 E를 추가하세요.
4. E를 방문하고 F를 추가하세요.

스택을 누를 때마다 나뭇가지 아래로 더 멀리 나아간다는 점에 유의하세요. 

인접한 모든 정점을 방문하는 대신에, **끝에 도달한 다음 되돌아갈 때까지 길을 계속 따라가세요.**
<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/bf637c7e-c921-4dbc-b959-97a531f1e79e" width="500">

5. F를 방문하고 G를 추가하세요.
6. G를 방문하고 C를 추가하세요.

<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/44fdff37-a66a-401d-99a3-e02e28c46e24" width="500">

7. 다음으로 방문할 정점은 C이다. 이웃 [A, F, G]이 있지만, 이 모든 것이 방문되었다. **막다른 골목에 도달했으므로, 스택에서 C를 꺼내서 되돌아**갈 때입니다. 팝 C
8. 이것은 G로 다시 데려옵니다. 이웃 [F, C]이 있지만, 이 모든 것이 방문되었습니다. 또 다른 막다른 골목이라면, 팝 G

<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/c90aa31e-67bb-4bca-b7fe-6b9d762d28e0" width="500">

9. F는 또한 방문하지 않은 이웃이 남아 있지 않기 때문에, 팝 F
10. 이제, 너는 E로 돌아왔어. 이웃 H는 아직 방문하지 않았으므로, 스택에 H를 추가하세요.

<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/5c4dc6d7-1887-4348-89fa-42db1534f3af" width="500">

11. H를 방문하는 것은 또 다른 막다른 골목을 초래하므로, 팝 H
12. E는 또한 방문 가능한 이웃이 없으므로, 팝 E
   
<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/88602a75-ab17-4d90-a858-7ccc9c03c650" width="500">

13. B도 마찬가지로 방문 가능한 이웃이 없으므로, 팝 B
14. 이것은 A로 돌아가게 합니다. A의 이웃 D는 여전히 방문해야 합니다. 그래서 D를 스택에 추가합니다.
   
<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/6fe0b4b3-1e6a-43f6-ad4f-67078104826c" width="500">

15. D를 방문하는 것은 또 다른 막다른 골목을 초래하므로, 팝 D
16. A로 돌아왔지만, 이번에는 푸시할 수있는 이웃이 없기 때문에 A를 팝하세요. 
스택은 이제 비어 있고 DFS는 완료되었다.

정점을 탐험할 때, 방문한 가지를 보여주는 나무와 같은 구조를 만들 수 있습니다. 
DFS가 BFS에 비해 얼마나 깊은지 알 수 있습니다.

<br></br>

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/5474f306-c0b7-4981-9edb-f67c35431525" width="500">


## 구현

플레이그라운드에는 그래프의 구현과 DFS를 구현하는 데 사용할 스택이 포함되어 있습니다.

```swift
extension Graph where Element: Hashable {
  func depthFirstSearch(from source: Vertex<Element>)
      -> [Vertex<Element>] {
    var stack: Stack<Vertex<Element>> = []
    var pushed: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []

    stack.push(source)
    pushed.insert(source)
    visited.append(source)

    // more to come ...

    return visited
  }
}
```

 시작 정점을 취하고 방문한 순서대로 정점 목록을 반환하는 방법 depthFirstSearch(from:)를 정의했습니다. 세 가지 데이터 구조를 사용한다:

1. `stack`은 그래프를 통해 경로를 저장하는 데 사용됩니다.
2. `push`는 이전에 어떤 정점이 밀렸는지 기억하므로 같은 정점을 두 번 방문하지 않습니다. 그것은 빠른 O(1) 조회를 보장하기 위한 세트이다.
3. `visited`은 정점이 방문한 순서를 저장하는 배열이다.

알고리즘을 시작하려면, **세 가지 모두에 소스 정점을 추가**하세요.

다음으로, 주석을 다음과 같이 대체하여 메서드를 완료하세요:

```swift
extension Graph where Element: Hashable {
  func depthFirstSearch(from source: Vertex<Element>)
      -> [Vertex<Element>] {
    var stack: Stack<Vertex<Element>> = []
    var pushed: Set<Vertex<Element>> = []
    var visited: [Vertex<Element>] = []

    stack.push(source)
    pushed.insert(source)
    visited.append(source)

    outer: while let vertex = stack.peek() { // 1
		  let neighbors = edges(from: vertex) // 2
		  guard !neighbors.isEmpty else { // 3
		    stack.pop()
		    continue
		  }
		  for edge in neighbors { // 4
		    if !pushed.contains(edge.destination) {
		      stack.push(edge.destination)
		      pushed.insert(edge.destination)
		      visited.append(edge.destination)
		      continue outer // 5
		    }
		  }
		  stack.pop() // 6
		}

    return visited
  }
}
```

1. 스택이 비어 있을 때까지 스택 상단의 정점을 계속 확인합니다. 중첩된 루프 내에서도 다음 정점으로 계속할 수 있도록 이 루프 외부에 레이블을 지정했습니다.
2. 현재 정점의 모든 이웃 가장자리를 찾을 수 있습니다.
3. 가장자리가 없다면, 스택에서 정점을 터뜨리고 다음 단계로 계속하세요.
4. 여기서, 현재 정점에 연결된 모든 가장자리를 반복하고 이웃 정점이 방문되었는지 확인합니다. 방문하지 않았다면, 그것을 스택에 푸시하고 방문한 배열에 추가합니다. 이 정점을 방문한 것으로 표시하는 것은 아직 들여다보지 않았기 때문에 이른 것처럼 보일 수 있지만, 정점이 스택에 추가되는 순서대로 (어짜피 !) 방문되기 때문에 올바른 순서로 표시됩니다.
5. 이제 방문할 이웃을 찾았으니, 외부 루프를 계속하고 새로 푸시된 이웃으로 이동합니다.
6. 현재 정점에 방문하지 않은 이웃이 없다면, 막다른 골목에 도달했고 스택에서 꺼낼 수 있다는 것을 알 수 있습니다.

스택이 비어 있으면, DFS 알고리즘이 완료됩니다! 당신이 해야 할 일은 방문한 정점을 방문한 순서대로 되돌리는 것뿐입니다.

## 성능 Performance

DFS는 적어도 한 번은 모든 정점을 방문할 것이다. 이 과정은 O(V)의 시간 복잡성을 가지고 있다.

DFS에서 그래프를 횡단할 때, 방문할 수 있는 모든 인접 정점을 확인해야 합니다. 이것의 시간 복잡성은 O(E)입니다. 왜냐하면 최악의 경우 그래프의 모든 가장자리를 방문해야 하기 때문입니다.

전반적으로, 깊이 우선 검색의 **시간 복잡성은 O(V + E)**이다.

세 가지 별도의 데이터 구조에 정점을 저장해야 하기 때문에 깊이 우선 검색의 **공간 복잡성은** **O(V)**입니다: stack, push, visited.

## 🗝️ Key points

- 깊이 우선 검색(DFS)은 그래프를 통과하거나 검색하는 또 다른 알고리즘이다.
- DFS는 끝에 도달할 때까지 가능한 한 지점을 탐구한다.
- 스택 데이터 구조를 활용하여 그래프에서 얼마나 깊은지 추적하세요. 막다른 골목에 도달했을 때만 스택에서 pop하세요.
