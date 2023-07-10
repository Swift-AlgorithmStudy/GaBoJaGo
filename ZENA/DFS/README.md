# Depth-First Search

이전 챕터에서, 다음 단계로 가기 전에 정점의 모든 이웃을 탐험해야 하는 너비 우선 검색(BFS)을 살펴보았다. 이 챕터에서는 그래프를 가로지르거나 검색하는 또 다른 알고리즘인 깊이 우선 검색(DFS)을 살펴보자.

DFS에는 많은 응용 프로그램이 있다:

- 위상 분류
- 사이클 감지
- 미로 퍼즐과 같은 길 찾기
- 희소 그래프에서 연결된 구성 요소 찾기

DFS를 수행하려면, 주어진 소스 정점에서 시작해서 끝에 도달할 때까지 가능한 한 지점을 탐색한다. 이 시점에서, 뒤로 물러서서 타겟을 찾거나 모든 정점을 방문할 때까지 다음 사용 가능한 지점을 탐색할 것이다.

## Example

DFS 예시를 살펴보자. 아래의 예시 그래프는 이전 챕터와 동일하다. 이는 BFS와 DFS의 차이점을 볼 수 있도록 한다.

<img width="421" alt="스크린샷 2023-07-10 오전 11 28 09" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/1c2d32fa-1e52-4e27-bc8f-d8eac0af8a60">

통과하는 레벨을 추적하기 위해 스택을 사용할 거다. 스택의 선입후출 접근 방식은 역추적에 도움이 된다. 스택의 모든 푸시는 한 단계 더 깊게 움직인다는 것을 의미한다. 막다른 골목에 도달하면 이전 레벨로 돌아갈 수 있다.

<img width="552" alt="스크린샷 2023-07-10 오전 11 28 42" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/432284af-1f61-4677-9b01-2cbb2b42b01c">

1. 이전 챕터와 마찬가지로, A를 시작 정점으로 선택하고 스택에 추가한다.
2. 스택이 비어 있지 않은 한, 스택의 상단 정점을 방문하고 아직 방문하지 않은 첫 번째 이웃 정점을 담는다. 이 경우, A를 방문하고 B를 push한다.

```swift
이전 장에서 가장자리를 추가하는 순서가 검색 결과에 영향을 미친다는 것을 기억하라. 
이 경우, A에 추가된 첫 번째 엣지는 B의 엣지였기 때문에, B가 먼저 밀린다.
```

<img width="586" alt="스크린샷 2023-07-10 오전 11 29 22" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/04b80679-5dff-4b04-9679-5a2f531a5629">

3. A는 이미 방문했기 때문에 B를 방문하고 E를 push한다.
4. E를 방문하고 F를 push한다.

스택을 푸시할 때마다 더 멀리 나아간다는 점에 유의하라. 인접한 모든 정점을 방문하는 대신, 끝에 도달한 다음 되돌아갈 때까지 길을 계속 따라가라.

<img width="584" alt="스크린샷 2023-07-10 오전 11 30 18" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/7b52424c-47e5-447a-9f89-fa0e6da0b782">

5. F를 방문하고 G를 push.
6. G를 방문하고 C를 push.
    
    ![스크린샷 2023-07-10 오전 11.30.28.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/edd4aba2-14d7-4ba4-8e4b-6b812a1f9416/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-10_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.30.28.png)
    <img width="586" alt="스크린샷 2023-07-10 오전 11 30 28" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/1c46f7c7-4bfd-4b79-acc8-3ba750adce72">

7. 다음으로 방문할 정점은 C이다. 이웃 [A, F, G]이 있지만, 모두 이미 방문했다. 막다른 골목에 도달했으므로, 스택에서 C를 꺼내서 되돌아갈 때!
8. G로 다시 데려온다. 이웃 [F, C]이 있지만, 모두 방문했다. 또 다른 막다른 골목, pop G.
    
    ![스크린샷 2023-07-10 오전 11.31.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/24544c59-811f-4d50-bf1b-a73db5a1a73a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-10_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.31.04.png)
    <img width="586" alt="스크린샷 2023-07-10 오전 11 31 04" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/5f697d02-4821-4d98-95f1-87cb7a565c10">

9. F는 또한 방문하지 않은 이웃이 남아 있지 않기 때문에, pop F.
10. 이제 E로 돌아왔다. 이웃 H는 아직 방문하지 않았으므로, 스택에서 H를 push한다.
    
    ![스크린샷 2023-07-10 오전 11.31.12.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5c6710a8-f976-458c-be04-6b34a9f18fb8/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-10_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.31.12.png)
    <img width="587" alt="스크린샷 2023-07-10 오전 11 31 12" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/6748b7ec-384e-47f1-b331-1594604dcb58">

11. H를 방문하는 것은 또 다른 막다른 골목이므로, H를 pop.
12. E는 또한 이용 가능한 이웃이 없으므로, 팝.
    
    ![스크린샷 2023-07-10 오전 11.31.23.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2ec33e95-7345-487c-b329-02639e1a40f9/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-10_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.31.23.png)
    <img width="586" alt="스크린샷 2023-07-10 오전 11 31 23" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/e7e67027-37aa-44c2-bfac-3a05e08cde2b">

13. B도 마찬가지니까, 그러니까 B pop.
14. 이는 A로 돌아가게 한다. A의 이웃 D는 여전히 방문해야 한다. 그래서 D를 스택에 푸시한다.
    
    ![스크린샷 2023-07-10 오전 11.31.34.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/de1225a1-6f46-405a-bda0-c2d7e07d1e86/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-07-10_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_11.31.34.png)
    <img width="585" alt="스크린샷 2023-07-10 오전 11 31 34" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/2c3f2326-063b-4dc2-820b-73086a4a0455">

15. D를 방문하는 것은 또 다른 막다른 골목이므로, D를 팝한다.
16. 다시 A로 돌아왔지만, 이번에는 푸시할 수 있는 이웃이 없기 때문에 A를 팝한다. 스택은 이제 비어 있고 DFS가 완료됐다.

정점을 탐험할 때, 방문한 브랜치를 보여주는 트리와 같은 구조를 만들 수 있습니다. DFS가 BFS에 비해 얼마나 깊은지 알 수 있다.

<img width="486" alt="스크린샷 2023-07-10 오전 11 32 36" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/34b47df4-95ce-43ce-96df-0780149c65dd">

## Implementation

아래 코드에는 그래프의 구현과 DFS를 구현하는 데 사용할 스택이 포함되어 있다.

다음 코드를 추가:

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

여기서, 시작 정점을 취하고 방문한 순서대로 정점 목록을 반환하는 방법 `depthFirstSearch(from:)`를 정의했습니다. 그것은 세 가지 데이터 구조를 사용한다:

1. 스택은 그래프를 통해 경로를 저장하는 데 사용된다.
2. 푸시는 이전에 어떤 정점이 밀렸는지 기억하므로 같은 정점을 두 번 방문하지 않는다. 그것은 빠른 O(1) 조회를 보장하기 위한 세트다.
3. 방문한 것은 정점이 방문한 순서를 저장하는 배열이다.

알고리즘을 시작하려면, 세 가지 모두에 소스 정점을 추가한다.

다음으로, 주석을 다음과 같이 대체하여 방법을 완료하라:

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

코드 분석:

1. 스택이 비어 있을 때까지 스택 상단의 정점을 계속 확인한다. 중첩된 루프 내에서도 다음 정점으로 계속할 수 있도록 이 루프 외부에 레이블을 지정했다.
2. 현재 정점의 모든 이웃 가장자리를 찾을 수 있다.
3. 가장자리가 없다면, 스택에서 정점을 터뜨리고 다음 단계로 계속한다.
4. 여기서, 현재 정점에 연결된 모든 가장자리를 반복하고 이웃 정점이 보이는지 확인한다. 그렇지 않다면, 그것을 스택에 밀어 넣고 방문한 배열에 추가한다. 이 정점을 방문한 것으로 표시하는 것은 조금 시기상조처럼 보일 수 있지만 정점이 스택에 추가되는 순서대로 방문되기 때문에 올바른 순서로 표시된다.
5. 이제 방문할 이웃을 찾았으니, 외부 루프를 계속하고 새로 밀린 이웃으로 이동한다.
6. 현재 정점에 방문하지 않은 이웃이 없다면, 막다른 골목에 도달했고 스택에서 꺼낼 수 있다는 것을 알 수 있다.

스택이 비어 있으면, DFS 알고리즘이 완료된다! 해야 할 일은 방문한 정점을 방문한 순서대로 되돌리는 것뿐이다.

코드를 사용해 보려면, 다음 코드를 추가:

```swift
let vertices = graph.depthFirstSearch(from: a)
vertices.forEach { vertex in
  print(vertex)
}
```

DFS를 사용하여 방문한 노드의 순서:

```swift
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

DFS는 적어도 한 번은 모든 정점을 방문할 것이다. 이 과정은 O(V)의 시간 복잡성을 가지고 있다.

DFS에서 그래프를 횡단할 때, 방문할 수 있는 모든 인접 정점을 확인해야 한다. 이것의 시간 복잡성은 O(E)이다. 왜냐하면 최악의 경우 그래프의 모든 가장자리를 방문해야 하기 때문이다.

전반적으로, 깊이 우선 탐색의 시간 복잡성은 O(V + E)이다.

세 가지 별도의 데이터 구조에 정점을 저장해야 하기 때문에 깊이 우선 탐색의 공간 복잡성은 O(V)이다: stack, push 및 visit.

## 🔑 Key points

- 깊이 우선 탐색(DFS)은 그래프를 통과하거나 검색하는 또 다른 알고리즘이다.
- DFS는 끝에 도달할 때까지 가능한 한 지점을 탐구한다.
- 스택 데이터 구조를 활용하여 그래프에서 얼마나 깊은지 추적하라. 막다른 골목에 도달했을 때만 스택에서 팝한다.
