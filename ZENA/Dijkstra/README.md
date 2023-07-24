# Dijkstra’s Algorithm

한 곳에서 다른 곳으로 가장 짧은 거리나 가장 빠른 시간을 찾기 위해 구글이나 애플 지도 앱을 사용해 본 적이 있는가? 다익스트라 알고리즘은 두 장소 사이의 최단 경로를 찾는 데 특히 유용하다.

다익스트라 알고리즘은 그리디 알고리즘이다. 그리디 알고리즘은 해결책을 단계별로 구성하며, 모든 각각의 단계에서 가장 최적의 경로를 선택한다. 그것은 일부 단계가 더 많은 비용이 들 수 있는 해결책을 놓치겠지만, 전체 비용은 더 낮다. 그럼에도 불구하고, 보통 꽤 좋은 해결책을 매우 빨리 찾는다.

다익스트라 알고리즘은 방향 또는 무방향 그래프에서 정점 사이의 최단 경로를 찾는다. 그래프의 정점을 감안할 때, 알고리즘은 시작 정점에서 가장 짧은 경로를 모두 찾을 것이다.

다익스트라 알고리즘의 다른 응용 프로그램은 다음과 같다:

1. 전염병 전염: 생물학적 질병이 가장 빠르게 퍼지고 있는 곳 찾기.
2. 전화 네트워크: 네트워크에서 사용할 수 있는 가장 높은 대역폭 경로로 통화를 라우팅.
3. 매핑: 여행자를 위한 가장 짧고 빠른 경로 찾기.

## Example

지금까지 본 모든 그래프는 방향이 없었다. 조금 바꾸어 방향 그래프로 작업해보자! 아래의 방향 그래프가 GPS 네트워크를 나타낸다고 상상해 보자:

정점은 물리적 위치를 나타내고, 엣지는 위치 간의 주어진 비용의 단방향 경로를 나타낸다.

<img width="487" alt="스크린샷 2023-07-15 오전 1 39 13" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/a0fc25de-3e39-43b3-8ce8-dd7dc6387b8d">

다익스트라에서, 알고리즘은 그래프의 나머지 노드에 대한 경로를 찾기 위해 시작점이 필요하기 때문에 먼저 시작 정점을 선택한다. 선택한 시작 정점이 정점 A라고 가정하자.

### First pass
<img width="649" alt="스크린샷 2023-07-15 오전 1 56 29" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/4cb58a53-19fa-43f7-afcf-e1c6c37b2029">

정점 A에서, 모든 나가는 엣지는 세가지이다:

- A →  B의 비용: 8
- A → F의 비용: 9
- A → G의 비용: 1

나머지 정점들은 A에서 나가는 경로가 없기 때문에 0으로 표시된다.

이 예제를 통해 작업할 때, 그래프의 오른쪽에 있는 표는 각 단계에서 다익스트라 알고리즘의 히스토리 또는 기록을 나타낸다. 알고리즘의 각 패스는 테이블에 행을 추가한다. 테이블의 마지막 행은 알고리즘의 최종 출력이 될 것이다.

### Second pass
<img width="649" alt="스크린샷 2023-07-15 오전 1 59 46" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/ff6eee12-847f-4637-b56b-5b571804bbea">

다음 사이클에서, 다익스트라 알고리즘은 지금까지 가지고 있는 가장 낮은 비용의 경로를 살펴본다. A에서 G는 1의 가장 작은 비용과 G에 도달하는 가장 짧은 경로를 가지고 있다. 이 경로는 출력 테이블에서 색깔이 채워져 표시된 부분이다.

<img width="650" alt="스크린샷 2023-07-15 오전 2 07 10" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/ab9e86a8-9fb5-459d-a64f-bc354d619200">

이제, 가장 저렴한 경로인 정점 G에서 모든 나가는 경로를 보자. G에서 C까지의 경로가 하나뿐이며, 총 비용은 4이다. 이것은 A에서 G에서 C까지의 비용이 1 + 3 = 4이기 때문이다.

출력 테이블의 모든 값에는 두 파트가 있다: **그 정점에 도달하는 총 비용**과 **그 정점으로 가는 경로의 마지막 이웃**. 예를 들어, 정점 C 열의 값 (4, G)는 C에 도달하는 비용이 4이고 C로 가는 경로가 G를 통과한다는 것을 의미한다. nil 값은 그 정점에 대한 경로가 없음을 나타낸다.

### Third pass
<img width="646" alt="스크린샷 2023-07-15 오전 2 07 35" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/c52f1196-c44b-4ab8-954e-a238b7b1c89a">

다음 사이클에서는 이 다음으로 가장 낮은 비용을 살펴본다. 표에 따르면, C로 가는 경로의 비용이 가장 작기 때문에, 검색은 C에서 계속될 것이다. C로 가는 가장 짧은 길을 찾았기 때문에 C열을 채운다.

<img width="650" alt="스크린샷 2023-07-15 오전 2 24 49" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/64915116-eabe-4a30-a8ea-774e2a063992">

C의 모든 나가는 가장자리를 봐보자:

- C → E의 총 비용: 4 + 1 = 5
- C → B의 총 비용: 4 + 3 = 7

B로 가는 더 저렴한 경로를 찾았으므로, B의 이전 값을 대체한다.

### Fourth pass
<img width="583" alt="스크린샷 2023-07-15 오전 2 25 12" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/a28b2b5a-d2d6-4b04-8f29-3f3907b95195">

이제, 다음 사이클에서, 다음으로 가장 낮은 비용 경로가 무엇인지 스스로에게 생각해봐라 표에 따르면 C → E의 총 비용은 5로 가장 작기 때문에, 검색은 E에서 계속될 것이다.

<img width="649" alt="스크린샷 2023-07-15 오전 2 32 37" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/78103b02-e4f1-4d31-966e-8bac2f157aee">

가장 짧은 길을 찾았기 때문에 E열을 채운다. 정점 E는 다음과 같은 나가는 경로를 가진다:

- E → C의 총 비용: 5 + 8 = 13. 이미 C로 가는 가장 짧은 길을 찾았으니, 이 길은 무시.
- E → D의 총 비용: 5 + 2 = 7
- E → B의 총 비용은 5 + 1 = 6.
표에 따르면, 현재 B로 가는 최단 경로의 총 비용은 7이다. 비용이 6보다 적기 때문에 E에서 B로 가장 짧은 경로를 업데이트한다.

### Fifth pass

<img width="650" alt="스크린샷 2023-07-15 오전 2 33 01" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/a467fe6c-4181-4b5a-807f-106883d42d2c">

다음으로, B에서 검색을 계속한다.

<img width="648" alt="스크린샷 2023-07-15 오전 2 40 55" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/7b3db368-1680-4a7c-a814-047e54e24fd1">

그러나, D는 나가는 경로가 없기 때문에 막다른 골목이다. D로 가는 가장 짧은 길을 찾았다고 기록하고 계속 나아간다.

### Seventh pass

<img width="453" alt="스크린샷 2023-07-15 오전 2 46 44" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/79f8d583-8495-430f-81fe-cc5f151ca825">

다음은 F 차례이다.

<img width="520" alt="스크린샷 2023-07-15 오전 2 46 53" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/e153a3ae-2737-455f-aeda-21d145323c17">

F는 A로 나가는 경로를 가지며 총 비용은 9 + 2 = 11이다. A가 시작 정점이기 때문에 이 경로를 무시할 수 있다.

### Eighth pass

H를 제외한 모든 정점을 지났다. H는 G와 F로 나가는 두 개의 경로를 가진다. 그러나, A에서 H로 가는 경로는 없다. 경로가 없기 때문에, H의 전체 열은 nil이다.

<img width="516" alt="스크린샷 2023-07-15 오전 2 48 23" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/4a7a7dc4-ebea-42ff-b518-b1ba314e399b">

이 단계는 모든 정점이 방문되었기 때문에 Dijkstra의 알고리즘을 완성했따!

<img width="517" alt="스크린샷 2023-07-15 오전 2 48 33" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/183c28e1-a2cc-4f13-bb45-8bc0fc9a4da3">

이제 마지막 행에서 가장 짧은 경로와 비용을 확인할 수 있다. 예를 들어, 출력은 D에 도달하는 비용이 7이라고 알려준다. 길을 찾기 위해, 되돌아가라. 각 열은 현재 정점이 연결된 이전 정점을 기록한다. D → E → C → G, 그리고 마침내 A로 돌아가야 한다. 이것을 코드로 어떻게 만들 수 있는지 보자.

## Implementation

이 코드에는 인접 목록 그래프와 Dijkstra의 알고리즘을 구현하는 데 사용할 우선 순위 큐가 함께 제공된다.

우선 순위 큐는 방문하지 않은 정점을 저장하는 데 사용된다. 최소 우선 순위 큐이므로 정점을 대기열에서 꺼낼 때마다 현재 잠정 최단 경로를 가진 정점을 제공한다.

Dijkstra.swift를 열고 다음을 추가:

```swift
public enum Visit<T: Hashable> {
  case start // 1
  case edge(Edge<T>) // 2
}
```

여기서, 방문이라는 열거형을 정의했다. 이 유형은 두 가지 상태를 추적한다:

1. 정점은 시작 정점이다.
2. 정점은 시작 정점으로 돌아가는 경로로 이어지는 관련 가장자리를 가지고 있다.

이제, Dijkstra라는 클래스를 정의하자. 위에 추가한 코드 뒤에 다음을 추가:

```swift
public class Dijkstra<T: Hashable> {

  public typealias Graph = AdjacencyList<T>
  let graph: Graph

  public init(graph: Graph) {
    self.graph = graph
  }
}
```

이전 장과 마찬가지로, 그래프는 AdjacencyList의 유형 별칭으로 정의된다. 필요하다면 나중에 이것을 인접 매트릭스로 대체할 수 있다.

## Helper methods

다익스트라를 구축하기 전에, 알고리즘을 만드는 데 도움이 될 몇 가지 헬퍼 메소드를 만들어 보자.

### Tracing back to the starat
<img width="520" alt="스크린샷 2023-07-15 오전 3 04 53" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/d870f7ca-2751-4a95-9dc2-b317a3f9e1ea">

현재 정점에서 시작 정점까지 총 무게를 추적하는 메커니즘이 필요하다. 이를 위해, 모든 정점에 대한 방문 상태를 저장하는, `Visit`이라는 이름의 딕셔너리를 추적할 것이다.

Dijkstra 클래스에 다음 방법을 추가:

```swift
private func route(to destination: Vertex<T>,
                   with paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
  var vertex = destination // 1
  var path: [Edge<T>] = [] // 2

  while let visit = paths[vertex], case .edge(let edge) = visit { // 3
    path = [edge] + path // 4
    vertex = edge.source // 5
  }
  return path // 6
}
```

이 방법은 기존 경로의 딕셔너리와 함께 대상 정점을 취하고, 대상 정점으로 이어지는 경로를 구성한다. 코드 분석:

1. 목적지 정점에서 시작한다.
2. 경로를 저장하기 위해 가장자리 배열을 만든다.
3. 시작 케이스에 도달하지 않은 한, 다음 가장자리를 계속 추출한다.
4. 이 가장자리를 경로에 추가한다.
5. 현재 정점을 가장자리의 소스 정점으로 설정한다. 이는 시작 정점에 더 가깝게 만든다.
6. While 루프가 시작 케이스에 도달하면, 경로를 완료하고 반환한다.

### Calculating total distance

<img width="519" alt="스크린샷 2023-07-15 오전 3 06 40" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/cdf5c05a-df66-45a5-bc0c-01b2eb89949a">

목적지에서 시작 정점으로 돌아가는 경로를 구성할 수 있게 되면, 그 경로의 총 가중치를 계산하는 방법이 필요하다. Dijkstra 클래스에 다음 방법을 추가:

```swift
private func distance(to destination: Vertex<T>,
                      with paths: [Vertex<T> : Visit<T>]) -> Double {
  let path = route(to: destination, with: paths) // 1
  let distances = path.compactMap { $0.weight } // 2
  return distances.reduce(0.0, +) // 3
}
```

이 방법은 대상 정점과 기존 경로의 사전을 가져와 총 가중치를 반환한다. 코드 분석:

1. 목적지 정점으로 가는 경로를 구성한다.
2. compactMap은 경로에서 모든 nil 가중치 값을 제거한다.
3. 모든 가장자리의 무게를 줄인다.

이제 도우미 방법을 설정했으므로, 데이크스트라의 알고리즘을 구현할 수 있다.

## Generating the shortest paths

`distance` 메소드 다음에 아래를 추가:

```swift
public func shortestPath(from start: Vertex<T>) -> [Vertex<T> : Visit<T>] {
  var paths: [Vertex<T> : Visit<T>] = [start: .start] // 1

  // 2
  var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
    self.distance(to: $0, with: paths) <
    self.distance(to: $1, with: paths)
  })
  priorityQueue.enqueue(start) // 3

  // to be continued
}
```

이 방법은 시작 정점을 취하고 모든 경로의  딕셔너리를 반환한다. 코드 분석:

1. 경로를 정의하고 시작 정점으로 초기화한다.
2. 방문해야 하는 정점을 저장하기 위해 최소 우선순위 큐를 만든다. 정렬 클로저는 시작 정점으로부터의 거리로 정점을 정렬하기 위해 만든 거리 방법을 사용한다.
3. 방문할 첫 번째 정점으로 시작 정점을 대기열에 넣는다.

다음과 같이 shortestPath의 구현을 완료하자:

```swift
while let vertex = priorityQueue.dequeue() { // 1
  for edge in graph.edges(from: vertex) { // 2
    guard let weight = edge.weight else { // 3
      continue
    }
    if paths[edge.destination] == nil ||
       distance(to: vertex, with: paths) + weight <
       distance(to: edge.destination, with: paths) { // 4
      paths[edge.destination] = .edge(edge)
      priorityQueue.enqueue(edge.destination)
    }
  }
}

return paths
```

코드를 분석:

모든 정점이 방문될 때까지 가장 짧은 경로를 찾기 위해 데이크스트라의 알고리즘을 계속합니다. 우선 순위 대기열이 비어 있을 때 완료된다는 것을 알고 있습니다.

현재 정점의 경우, 당신은 모든 이웃 가장자리를 통과합니다.

가장자리에 무게가 있는지 확인하세요. 그렇지 않다면, 당신은 다음 가장자리로 넘어갑니다.

대상 정점을 이전에 방문한 적이 없거나 더 저렴한 경로를 찾은 경우, 경로를 업데이트하고 이웃 정점을 우선 순위 대기열에 추가합니다.

모든 정점을 방문하고 우선 순위 대기열이 비어 있으면, 가장 짧은 경로의 사전을 시작 정점으로 반환합니다.

### Finding a specific path

Dijkstra 클래스에 다음 방법을 추가하세요:

```swift
public func shortestPath(to destination: Vertex<T>,
                         paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
  return route(to: destination, with: paths)
}
```

## Trying out your code

<img width="486" alt="스크린샷 2023-07-15 오전 3 12 41" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/ebe06220-f617-4278-ab4c-b68bbe5a5193">

메인 놀이터로 이동하면, 위의 그래프가 이미 인접 목록을 사용하여 구성되었다는 것을 알 수 있습니다. Dijkstra의 알고리즘이 작동하는 것을 볼 수 있는 시간입니다.

놀이터 페이지에 다음 코드를 추가하세요:

```swift
let dijkstra = Dijkstra(graph: graph)
let pathsFromA = dijkstra.shortestPath(from: a) // 1
let path = dijkstra.shortestPath(to: d, paths: pathsFromA) // 2
for edge in path { // 3
  print("\(edge.source) --|\(edge.weight ?? 0.0)|--> \(edge.destination)")
}
```

여기서, 당신은 그래프 네트워크를 통과하여 데이크스트라의 인스턴스를 만들고 다음을 수행합니다:

1. 시작 정점 A에서 모든 정점까지의 최단 경로를 계산하세요.
2. D로 가는 가장 짧은 길을 가다.
3. 이 경로를 출력한다.
    
    <img width="518" alt="스크린샷 2023-07-15 오전 3 13 55" src="https://github.com/dayo2n/Human-Interface-Guidelines/assets/57654681/d93564fc-5acc-4a9d-a70a-017e5ae844bf">


출력은 다음과 같다:

```swift
A --|1.0|--> G
G --|3.0|--> C
C --|1.0|--> E
E --|2.0|--> D
```

## Performance

데이크스트라의 알고리즘에서, 당신은 인접 목록을 사용하여 그래프를 구성했습니다. 최소 우선 순위 대기열을 사용하여 정점을 저장하고 최소 경로로 정점을 추출했습니다. 이 과정은 O(log V)의 전반적인 시간 복잡성을 가지고 있다. 최소 요소를 추출하거나 요소를 삽입하는 힙 작업은 각각 O(log V)를 취한다.

폭 우선 검색 장에서 기억한다면, 모든 정점과 가장자리를 가로지르는 데 O(V + E)가 필요합니다. 데이크스트라의 알고리즘은 모든 이웃 가장자리를 탐색해야 하기 때문에 폭 우선 검색과 다소 유사합니다. 이번에는 다음 단계로 내려가는 대신 최소 우선 순위 대기열을 사용하여 가장 짧은 거리를 가진 단일 정점을 선택합니다. 그것은 O(1 + E) 또는 단순히 O(E)라는 것을 의미한다. 그래서, 횡단과 최소 우선순위 대기열의 작업을 결합하여, 데이크스트라의 알고리즘을 수행하려면 O(E log V)가 필요하다.

## Key points

- 데이크스트라의 알고리즘은 시작 정점이 주어진 나머지 노드에 대한 경로를 찾는다.
- 이 알고리즘은 다른 끝점 사이의 최단 경로를 찾는 데 유용하다.
- 방문 상태는 가장자리를 시작 정점으로 다시 추적하는 데 사용된다.
- 우선 순위 대기열 데이터 구조는 최단 경로를 가진 정점을 반환하도록 한다.
- 그것은 각 단계에서 가장 짧은 길을 선택하기 때문에, 탐욕스럽다고 한다!
