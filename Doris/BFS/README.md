# Breadth-First Search

BFS는 다양한 문제를 해결하는 데 사ㅇ될 수 있습니다. </br>

1. 최소 신장 트리 생성하기
2. 정점들 사이의 가능한 경로 찾기
3. 두 정점 사이의 최단 경로 찾기

</br>
</br>

## Example

BFS는 그래프에서 임의의 정점을 선택하여 시작합니다. 그런 다음 해당 정점의 모든 이웃을 탐색한 후, 해당 이웃들의 이웃을 탐색하고 이어서 진행합니다. </br>

다음은 무방향 그래프를 사용한 BFS입니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/1a019cf7-6e04-4766-9e13-780c86317d92">

</br>

> 색칠된 정점은 방문한 정점을 나타냅니다. </br>

</br>

다음 예제에서는 방문할 정점을 추적하기 위해 `큐`를 사용합니다. 큐의 **선입선출** 접근 방식은 한 정점의 모든 이웃을 탐색한 후에 해당 정점보다 한 레벨 더 깊이 탐색하기 위해 보장됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/634075a7-21eb-413b-becb-e3bb94a39bbb">

</br>

> 방문하지 않은 정점이며 이미 큐에 없는 경우에만 정점을 큐에 추가해야 합니다. </br>

1. 출발 정점을 선택합니다. 예제에서는 A를 선택하고 큐에 추가합니다. 
2. 큐가 비어 있지 않은 한, 다음 정점을 큐에서 추출하여 방문합니다. 이 경우에는 A가 선택되며, A의 모든 이웃 정점 (B, D, C)을 큐에 추가합니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/691b016b-84da-436d-81c1-031a7fdfd582">

</br>

3. 큐가 비어 있지 않으므로 다음 정점인 B를 추출하여 방문합니다. 그런 다음 B의 이웃인 E를 큐에 추가합니다. 이미 방문한 정점인 A는 큐에 추가되지 않습니다. 큐는 이제 [D, C, E]를 가지고 있습니다.

4. 다음으로 추출되는 정점은 D입니다. D에는 방문하지 않은 이웃이 없습니다. 큐는 이제 [C, E]를 가지고 있습니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/05aef497-4173-4c84-9d7d-e2591fcdce83">

</br>

5. 다음으로 큐에서 C를 추출하고 이웃인 [F, G]를 큐에 추가합니다. 큐는 이제 [E, F, G]를 가지고 있습니다.

> 이제 A의 모든 이웃을 방문했으므로, BFS는 이제 두 번째 레벨의 이웃으로 이동합니다. </br>

6. E를 추출하고 H를 큐에 추가합니다. 큐는 이제 [F, G, H]를 가지고 있습니다. 이미 방문한 B와 이미 큐에 있는 F는 큐에 추가하지 않습니다.

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/2c900aa2-b37e-411b-9c42-1bddd90c4f02">
</br>

7. F를 추출하고, 모든 이웃이 이미 큐에 있거나 방문한 상태이므로 큐에 아무것도 추가하지 않습니다.

8. 이전 단계와 마찬가지로 G를 추출하고 큐에 아무것도 추가하지 않습니다.

<img width="60%" height="60%" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/93391058/eb9b4b4a-cc83-490e-b9a1-63a91b1dffd6">

</br>

9. 마지막으로 H를 추출합니다. 큐가 비어 있으므로 너비 우선 탐색이 완료됩니다!

10. 정점을 탐색할 때, 각 레벨마다 정점들을 나타내는 트리 모양의 구조를 구성할 수 있습니다: 먼저 시작 정점, 그 다음 이웃들, 그리고 그 이웃들의 이웃들과 같은 식으로 계속됩니다.

</br>
</br>

## Implementation

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

> 여기에서는 시작 정점을 인자로 받는 breadthFirstSearch(from:) 메서드를 정의했습니다. 이 메서드는 세 가지 데이터 구조를 사용합니다. </br>

1. **queue**: 다음에 방문할 이웃 정점들을 추적합니다.
2. **enqueued**: 이전에 enqueued(큐에 추가된) 정점들을 기억하여 동일한 정점을 두 번 enqueue하지 않습니다. 여기에서 Set 타입을 사용하여 조회가 빠르고 O(1)의 시간 복잡도를 가지도록 합니다.
3. **visited**: 정점들이 탐색된 순서를 저장하는 배열입니다.

</br>

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
</br>

1. 먼저 출발 정점을 큐에 enqueuing하여 BFS 알고리즘을 시작합니다.

2. 큐에서 정점을 dequeue하고, 큐가 비어 있을 때까지 이를 반복합니다.

3. 각 정점을 dequeue할 때마다, 방문한 정점들의 목록에 해당 정점을 추가합니다.

4. 그런 다음 현재 정점에서 시작하는 모든 간선을 찾고 이를 반복합니다.

5. 각 간선에 대해, 목적지 정점이 이전에 enqueued(큐에 추가된)되지 않았는지 확인하고, 그렇지 않다면 코드에 해당 정점을 추가합니다.

</br>
</br>

## Performance

너비 우선 탐색(BFS)을 사용하여 그래프를 탐색할 때, 각 정점은 한 번 enqueue됩니다. 이 과정의 시간 복잡도는 `O(V)`입니다. 이 탐색 중에는 모든 간선을 방문합니다. 모든 간선을 방문하는 데 걸리는 시간 복잡도는 O(E)입니다. 이 둘을 합치면 너비 우선 탐색의 전체 시간 복잡도는 `O(V + E)`입니다.

</br>

BFS의 공간 복잡도는 `O(V)`입니다. 왜냐하면 큐(queue), enqueued, visited와 같이 세 개의 별도 구조에 정점들을 저장해야 하기 때문입니다

</br>
</br>

## Points

- 너비 우선 탐색(BFS)은 그래프를 탐색하거나 검색하기 위한 알고리즘입니다.
- BFS는 현재 정점의 이웃들을 탐색한 후 다음 수준의 정점들을 탐색합니다.
- 그래프 구조에 이웃 정점이 많거나 가능한 모든 결과를 찾아야 할 때 일반적으로 이 알고리즘을 사용하는 것이 좋습니다.
- 큐 데이터 구조는 한 수준 아래로 이동하기 전에 정점의 간선을 우선적으로 탐색하는 데 사용됩니다.