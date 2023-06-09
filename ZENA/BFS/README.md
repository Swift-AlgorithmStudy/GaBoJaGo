# Breadth-First Search

이전 챕터에서는 오브젝트 간의 관계를 포착하기 위해 그래프를 사용하여 탐구했다. 오브젝트는 단지 정점일 뿐이며, 간선은 그들 사이의 관계를 나타낸다는 것을 기억하면 된다.

그래프의 정점을 가로지르거나 탐색하기 위한 몇 가지 알고리즘이 있다. 그러한 알고리즘 중 하나는 너비 우선 탐색(BFS) 알고리즘이다.

BFS는 다양한 문제를 해결하는 데 사용될 수 있다:

1. 최소 스팬 트리 생성하기.
2. 정점 사이의 잠재적인 경로 찾기.
3. 두 정점 사이의 최단 경로 찾기.

## Example

BFS는 그래프에서 정점을 선택하는 것으로 시작한다. 그런 다음 알고리즘은 해당 이웃의 이웃을 순회하기 전에 이 정점의 모든 이웃을 탐색한다. 이름에서 알 수 있듯이, 이 알고리즘은 너비 우선 접근 방식을 취한다.

다음 무방향 그래프를 사용하여 BFS 예제를 살펴보자:

<img width="389" alt="스크린샷 2023-07-02 오후 4 05 55" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/deaf5535-28aa-48b6-9778-5e13bc976716">

```swift
Note: 강조 표시된 정점은 방문한 정점을 나타낸다.
```

다음에 방문할 정점을 추적하기 위해 대기열을 사용할 것이다. 대기열의 선입선출 접근 방식은 한 단계 더 깊이를 통과하기 전에 모든 정점의 이웃을 방문하도록 보장한다.

<img width="587" alt="스크린샷 2023-07-02 오후 4 09 49" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/1e21e320-7cba-475b-84df-0943ad02e504">

1. 시작하려면, 시작할 정점을 선택한다. 이때 우리는 큐에 추가된 A를 선택했다.
2. 큐가 비어 있지 않은 한, 큐에서 꺼내고 다음 정점을 방문한다. 이 경우 A. 다음으로, A의 모든 인접 정점 [B, D, C]을 큐에 추가한다.

```swift
Note: 아직 방문되지 않았고 아직 큐에 있지 않을 때만 큐에 정점을 추가하는 것이 중요하다.
```

<img width="585" alt="스크린샷 2023-07-02 오후 4 10 30" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/f9134b46-5ff3-41a3-8e19-16f504c5e45e">

3. 큐가 비어 있지 않으므로, 큐에서 꺼내고 다음 정점인 B를 방문 visit한다. 그런 다음 B의 이웃 E를 큐에 추가한다. A는 이미 방문했기 때문에, 추가하지 않는다. 대기열에는 이제 [D, C, E]가 있다.
4. 다음 정점은 D이다. D는 방문하지 않은 이웃이 없다. 대기열에는 이제 [C, E]가 있다.

<img width="586" alt="스크린샷 2023-07-02 오후 4 10 42" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/10842c1d-0916-451e-a9a1-17157411c1a6">

5. 다음으로, C의 큐를 해제하고 이웃 [F, G]를 큐에 추가합니다. 대기열에는 이제 [E, F, G]가 있다.

이제 A의 모든 이웃을 방문했다는 것을 알아. BFS는 이제 이웃의 두 번째 단계로 이동한다.

6. E를 대기열에서 빼고 큐에 H를 추가한다. 큐에는 이제 [F, G, H]가 있다. B가 이미 방문되었고 F가 이미 큐에 있기 때문에 B 또는 F를 큐에 추가하지 않는다.

<img width="587" alt="스크린샷 2023-07-02 오후 4 16 04" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/28100a37-f1be-4a74-b0a3-5a94297893c8">

7. F를 대기열에서 제거했고, 모든 이웃이 이미 큐에 있거나 방문했기 때문에, 큐에 아무것도 추가하지 않는다.
8. 이전 단계와 마찬가지로, G를 큐에서 빼고 아무것도 추가하지 않는다.

<img width="587" alt="스크린샷 2023-07-02 오후 4 17 09" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/2f482dff-b0cb-4471-8110-e1e0431b4e70">

9. 마지막으로, H를 꺼낸다. 큐가 이제 비어 있기 때문에 너비 우선 탐색이 완료된 것임!
10. 정점을 탐색할 때, 각 레벨의 정점을 보여주는 트리와 같은 구조를 구성할 수 있다: 먼저 시작한 정점, 그 다음에는 이웃, 그 다음에는 이웃의 이웃 등.

## Implementation

```swift
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
```

코드 분석:

1. 먼저 소스 정점을 메우고 BFS 알고리즘을 시작한다.
2. 큐가 비어 있을 때까지 대기열에서 정점을 계속 제거한다.
3. 큐에서 정점을 제외할 때마다, 방문한 정점 목록에 추가한다.
4. 그런 다음, 현재 정점에서 시작하여 반복되는 모든 가장자리를 찾는다.
5. 각 가장자리에 대해, 대상 정점이 이전에 매겨졌는지 확인하고, 그렇지 않은 경우 코드에 추가한다.

이게 BFS를 구현하는 다임! 이 알고리즘을 한 번 시도해 보자. 다음 코드를 추가:

```swift
let vertices = graph.breadthFirstSearch(from: a)
vertices.forEach { vertex in
  print(vertex)
}
```

BFS를 사용하여 탐색한 정점의 순서를 기록한다.

```swift
0: A
1: B
2: C
3: D
4: E
5: F
6: G
7: H
```

이웃 정점에서 명심해야 할 한 가지는 그것들을 방문하는 순서가 그래프를 어떻게 구성하느냐에 따라 결정된다는 것이다. A와 B 사이에 하나를 추가하기 전에 A와 C 사이에 가장자리를 추가할 수 있었다. 이 경우, 출력은 B 앞에 C가 나올 것이다.

## Performance

BFS를 사용하여 그래프를 순회할 때, 각 정점은 한 번 큐에 넣어진다. 이 과정은 O(V)의 시간 복잡성을 가진다. 이 순회 동안, 모든 가장자리를 방문한다. 모든 가장자리를 방문하는 데 걸리는 시간은 O(E)이다. 이 둘을 함께 추가하면 너비 우선 탐색의 전체 시간 복잡성이 O(V + E)라는 것을 의미한다.

`queue`, `enqueue` 및 `visited` 세 가지 개별 구조에 정점을 저장해야 하기 때문에 BFS의 공간 복잡성은 O(V)이다.

## 🔑 Key points

- 너비 우선 탐색(BFS)은 그래프를 가로지르거나 검색하는 알고리즘이다.
- BFS는 다음 단계의 정점을 통과하기 전에 현재 정점의 모든 이웃을 탐구한다.
- 그래프 구조에 인접한 정점이 많거나 가능한 모든 결과를 찾아야 할 때 일반적으로 이 알고리즘을 사용하는 것이 좋다.
- 대기열 데이터 구조는 정점을 가로지르는 우선순위를 정하는 데 사용된다.
