# DFS(Depth-First Search)

이전 장에서는 다음 레벨로 가기 전에 모든 이웃 정점을 방문하는 너비우선탐색(BFS)에 대해서 살펴보았습니다. 
이번 장에서는 그래프를 탐색하는 다른 알고리즘인 깊이우선탐색(DFS)에 대해 살펴보겠습니다.

DFS는 다양한 곳에서 활용할 수 있습니다.

- 위상 정렬(Topological sorting)
- 사이클 탐지(Detecting a cycle)
- 미로 퍼즐과 같은 경로 찾기(Pathfinding)
- 희소 그래프(sparse graph)에서 연결된 컴포넌트 찾기

DFS를 수행하기 위해선, 주어진 출발 정점에서 시작하여 가능한 한 멀리까지 분기를 탐색하려고 합니다. 그리고 해당 지점에서는 백트래킹(한 단계 뒤로 이동)을 하고, 찾고자 하는 대상을 찾거나 모든 정점을 방문할 때까지 다음 가능한 분기를 탐색합니다.

- 위상 정렬
    
    위상 : 어떤 사물이 다른 사물과의 관계 속에서 가지는 위치나 상태
    
    각 정점들이 가지는 위상(다른 정점과의 관계, 즉 간선)에 따라서, 그래프를 구성하는 정점들을 순서대로 정렬해서 결과값으로 출력하는 것입니다.
    
    위상 정렬의 조건
    
    - 그래프는 간선이 방향성을 가지는 유향 그래프여야 합니다.
    - 그래프 내부에 순환(cycle)이 있으면 안됩니다.

## Example

예시 그래프는 이전 장의 예시와 같은 것입니다. 이를 통해 BFS와 DFS의 차이를 볼 수 있습니다.

<img width="294" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/833b5502-030f-4844-a0fa-bcd7e5b2dbdd">

스택을 사용해서 이동한 곳을 추적할 것입니다. 스택의 후입선출(last-in-first-out) 접근은 백트래킹에 도움이 됩니다. 스택에 push하는 것은 한 레벨 더 깊게 들어가는 것을 의미합니다. 만약 끝에 도달했으면 pop을 통해서 이전 레벨을 반환할 수 있습니다.

<img width="496" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/a4caa774-e553-44f5-9c55-3cd59536ffda">

1. 지난 장에서와 같이, A를 시작 정점으로 선택하고 스택에 추가합니다.
2. 스택이 비어있지 않는 한, 스택의 맨 위 정점을 방문하고 아직 방문하지 않은 첫 번째 인접 정점을 푸쉬합니다. 이 경우에는 A를 방문하고 B를 푸쉬합니다.
    - 지난 장을 기억해보면 간선을 추가하는 순서가 탐색의 결과에 영향을 미칠 수 있음을 알 수 있습니다.
    이 경우에는 A가 추가된 첫 번째 간선을 B라고 하여 B가 먼저 푸쉬된 것입니다.

<img width="494" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/6c1989f5-80fd-4a77-9649-8d981740fc74">

3. B를 방문하고 A는 이미 방문했기 때문에 E를 푸쉬합니다.
4. E를 방문하고 F를 푸쉬합니다.

스택을 푸쉬할 때마다 더 깊은 분기로 진행하게 됩니다. 인접한 모든 정점을 방문하는 대신, 끝까지 진행한 후에 되돌아가기 전까지 경로를 따라 진행합니다.

<img width="543" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/816016cd-e0ad-48b3-ae10-03914f3422c6">

5. F를 방문하고 G를 푸쉬합니다.
6. G를 방문하고 C를 푸쉬합니다.

<img width="537" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/62957b6e-9e9e-4461-9f90-b1bbdf6e0a45">

7. 다음으로 방문해야 할 정점은 C입니다. 이는 [A, F, G]를 이웃으로 갖지만 이들은 모두 방문되었습니다.
끝까지 방문했기 때문에, C를 스택에서 빼냄(popping)으로써 백트래킹을 진행할 차례입니다.
8. 이는 G로 돌아오게 합니다. 이는 [F, C]를 이웃으로 갖지만 이들은 모두 방문되었습니다. 
막다른 길(dead end)이기 때문에 G를 팝합니다.

<img width="538" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5ec1f721-2dab-46b7-af0a-899ab4ab19a7">

9. F 또한 방문되지 않은 이웃이 없기 때문에 팝합니다.
10. 이제 E로 왔습니다. E의 이웃인 H가 아직 방문되지 않았기 때문에 H를 스택에 푸쉬합니다.

<img width="485" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/891a652f-c787-4618-b45d-0af98c746f0a">

11. H는 끝(dead end)이기 때문에 팝합니다.
12. E 또한 이웃들을 모두 방문했기 때문에 팝합니다.

<img width="499" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/937da97d-ec01-4b6a-b1af-1da57747cb3a">

13. B 또한 같아, 팝합니다.
14. 이는 A로 다시 되돌아오게 하고, 아직 방문이 필요한 이웃인 D를 가지고 있으므로 D를 푸쉬합니다.

<img width="485" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/7359b414-c64f-443b-a52a-96a25a621f7e">

15. D는 끝이기 때문에 팝합니다,
16. 다시 A로 돌아왔지만 푸쉬할 이웃이 없기 때문에 A를 팝합니다. 스택은 비어있고 DFS는 완료됩니다.

<img width="428" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/4a5f076b-7a41-4e43-832d-e7c66fa40fae">

정점들을 방문할 때 방문한 분기들을 보여줄 수 있는 트리와 같은 구조를 만들 수 있습니다. 
BFS와 비교했을 때 DFS가 얼마나 깊게 들어갔는지 볼 수 있습니다.

## Implementation

playground 파일에 식을 추가합니다.

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

여기서 시작 정점을 가지고 방문한 순서에 대한 리스트를 반환하는  `depthFirstSearch` 메소드에 대해 정의하였습니다. 이는 세 가지 자료 구조를 사용합니다. 

1. `stack`은 그래프가 지나간 경로를 저장하기 위해 사용됩니다.
2. `pushed`는 이전에 푸쉬된 정점에 대해 저장하여 같은 정점을 두 번 반복하지 않게 합니다. 
Set으로 만들어져 탐색하는 데 O(1)을 보장합니다.
3. `visited`는 정점이 방문한 순서를 저장하는 배열입니다.

알고리즘을 시작하기 위해 3가지 전체에 시작 정점을 추가합니다. 

다음으로는, 해당 식을 추가하여 메소드를 완성시킵니다.

```swift
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
```

1. 스택이 비어있기 전까지 정점을 위해 스택의 상단을 확인합니다. 
이 반복문을 outer라고 이름을 만든 이유는 중첩된 루프 내에서도 다음 정점으로 계속 진행할 수 있는 방법을 갖기 위함입니다.
2. 현재 정점을 기준으로 모든 이웃 간선을 탐색합니다.
3. 만약 간선이 없다면, 정점을 스택에서 팝하고 다음 것을 진행합니다.
4. 여기서 현재 정점과 연결되어 있는 모든 간선을 탐색하면서 만약 이웃 정점이 방문되었는지 확인합니다. 만약 방문되지 않았다면 스택에 푸쉬하고 visited 배열에 추가합니다. 이 정점을 방문하는 것으로 표시하는 것은 조금 이른 것처럼 보일 수 있지만(아직 이 정점을 확인하지 않았으므로), 정점이 스택에 추가된 순서대로 방문되기 때문에 올바른 순서로 방문되게 됩니다.
5. 이제 방문할 인접 정점을 찾았으므로, outer 루프를 계속하고 방금 추가된 인접 정점으로 이동합니다.
6. 만약 현재 정점에 방문되지 않은 이웃이 없다면, 끝에 도달한 것이기 때문에 스택에서 팝합니다.

스택이 비어있다면 DFS 알고리즘이 완료됩니다! 방문한 정점을 순서대로 반환하면 끝납니다.

```swift
let vertices = graph.depthFirstSearch(from: a)
vertices.forEach { vertex in
  print(vertex)
}

0: A
1: B
4: E
5: F
6: G
2: C
7: H
3: D
```

## Performance

DFS는 모든 정점들을 최소 한 번 방문할 것입니다. 이 과정은 O(V)의 시간 복잡도를 가집니다.

DFS에서 그래프를 탐색할 때, 방문할 수 있는 모든 인접 정점을 확인해야 합니다. 
최악의 경우에 모든 간선을 탐색해야 하기 때문에 O(E)의 시간 복잡도를 가집니다.

전반적으로, DFS는 O(V + E)의 시간 복잡도를 가집니다.

DFS의 stack, pushed, visited라는 세 가지의 자료 구조를 가지고 있기 때문에, 공간 복잡도는 O(V)를 가집니다.

## Key points

- DFS는 그래프를 탐색하는 또 다른 알고리즘입니다.
- DFS는 분기의 끝까지 도달할 때까지 탐색합니다.
- 스택 자료 구조를 활용하여 그래프 탐색의 깊이를 추적합니다. 끝까지 도달했을 때에만 스택에서 값을 꺼냅니다.
