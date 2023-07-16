# Chap20. Dijkstra’s Algorithm

## 다익스트라 알고리즘

구글 또는 애플 맵 앱을 사용하여 한 장소에서 다른 장소까지의 최단 거리나 최단 시간을 찾은 적이 있나요? Dijkstra의 알고리즘은 GPS 네트워크에서 두 장소 사이의 최단 경로를 찾는 데 특히 유용합니다.

Dijkstra의 알고리즘은 그리디 알고리즘입니다. 그리디 알고리즘은 솔루션을 단계별로 구성하며, 각 단계에서 가장 최적의 경로를 독립적으로 선택합니다. 그 결과로 일부 단계가 더 비용이 많이 들지만 전체 비용이 낮은 솔루션을 놓치게 될 수 있습니다. 그러나 일반적으로 매우 빠른 시간 내에 꽤 좋은 솔루션에 도달합니다.

Dijkstra의 알고리즘은 **방향 그래프 또는 무방향 그래프에서 정점 간의 최단 경로를 찾습니다**. 그래프에서 주어진 정점에서 알고리즘은 시작 정점으로부터 모든 최단 경로를 찾습니다.

### Dijkstra 알고리즘의 응용 분야

- 전염성 질병 전파: 생물학적 질병이 가장 빠르게 전파되는 위치를 발견합니다.
- 전화 네트워크: 네트워크에서 가장 대역폭이 높은 경로로 통화를 라우팅합니다.
- 지도: 여행자들을 위한 최단 경로와 가장 빠른 경로를 찾습니다.

## 예시

지금까지 당신이 본 모든 그래프는 방향이 없었습니다. 하지만 이번애는 방향 그래프로 작업해볼까요?! 

정점은 물리적 위치를 나타내고, 가장자리는 위치 간의 주어진 비용의 단방향 경로를 나타낸다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/9096378a-76bb-4e35-96cb-478a160fcb16" width="400">


다익스트라의 알고리즘에서, 알고리즘은 그래프의 나머지 노드에 대한 경로를 찾기 위해 시작점이 필요하기 때문에 먼저 시작 정점을 선택합니다. 당신이 선택한 시작 정점이 정점 A라고 가정하세요.

### 첫번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/6a452ec1-51d9-47f8-980e-c4d188b345ce" width="400">

정점 A에서 나가는 모든 가장자리를 보면 세 가지 가장자리를 가지고 있습니다:

- A에서 B의 비용은 8이다.
- A에서 F의 비용은 9이다.
- A에서 G의 비용은 1이다.

나머지 정점은 A에서 직접적인 경로가 없기 때문에 nil로 표시됩니다.

이 예시를 작업하는 동안, 그래프 오른쪽의 테이블은 Dijkstra의 알고리즘의 각 단계에서의 기록 또는 히스토리를 나타냅니다. 알고리즘의 각 단계마다 테이블에 한 행이 추가됩니다. 테이블의 마지막 행은 알고리즘의 최종 출력이 됩니다.

### 두번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/feda29f1-49d3-4a7e-92cc-ddee4cd47175" width="400">

다음 사이클에서 Dijkstra의 알고리즘은 지금까지 가장 낮은 비용의 경로를 살펴봅니다. A에서 G로 가는 경로는 비용이 1로 가장 작으며 G에 도달하기 위한 가장 짧은 경로입니다. 이 경로는 출력 테이블에서 진한 색상으로 표시됩니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/47a4c4dd-77c0-42c0-ac2c-f966baaf850b" width="400">

이제 가장 낮은 비용 경로인 정점 G에서 나가는 모든 간선을 살펴봅니다. G에서 C로 가는 간선은 단 하나이며, 총 비용은 4입니다. 이는 A에서 G를 거쳐 C에 도달하는 비용이 1 + 3 = 4임을 나타냅니다.

출력 테이블의 각 값은 두 부분으로 구성됩니다. 해당 정점에 도달하기까지의 총 비용과 해당 정점으로의 경로에서의 마지막 이웃입니다. 예를 들어, 정점 C의 열에서 값이 "4 G"인 경우, C에 도달하기까지의 비용은 4이고, C로의 경로는 G를 거칩니다. nil 값은 해당 정점까지의 경로가 발견되지 않았음을 나타냅니다.

### 세 번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/6b17fc83-93ed-4892-8d00-32061ab67ef3" width="400">

다음 사이클에서는 다음으로 낮은 비용을 살펴봅니다. 테이블에 따르면 C로 가는 경로가 가장 작은 비용이므로, 탐색은 C에서 계속됩니다. C에 도달하기 위한 최단 경로를 찾았으므로 C 열을 채웁니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/689485f0-9c93-4dec-8379-a28dbc58dda6" width="400">

C에서 나가는 모든 간선을 살펴보겠습니다:

- C에서 E로 가는 총 비용은 4 + 1 = 5입니다.
- C에서 B로 가는 총 비용은 4 + 3 = 7입니다.

B로 가는 더 낮은 비용의 경로를 찾았으므로 이전 값이 B에 대해 대체됩니다.

### 네번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/b65f9e41-f048-458c-aa77-99dab8d58efc" width="400">

이제 다음 사이클에서 다음으로 낮은 비용 경로가 무엇인지 생각해보세요. 테이블에 따르면 C에서 E로 가는 최소 총 비용은 5이므로, 탐색은 E에서 계속됩니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/59c28de4-6649-42d5-9d99-689cc84a75b4" width="400">

최단 경로를 찾았으므로 E 열을 채웁니다. 정점 E는 다음과 같은 나가는 간선을 가지고 있습니다:

- E에서 C로 가는 총 비용은 5 + 8 = 13입니다. 이미 C로 가는 최단 경로를 찾았으므로 이 경로를 무시합니다.
- E에서 D로 가는 총 비용은 5 + 2 = 7입니다.
- E에서 B로 가는 총 비용은 5 + 1 = 6입니다. 테이블에 따르면 B로 가는 현재 최단 경로의 총 비용은 7입니다. 비용이 더 작은 6으로 인해 E에서 B로 가는 최단 경로를 업데이트합니다.

### 다섯 번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/7231dd84-8d41-4ea9-bb1e-56122295cfa1" width="400">

다음으로, B에서 탐색을 계속합니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/858cffe0-9f4a-484a-85e6-deb27a6d7d5b" width="400">

B에서 나가는 간선은 다음과 같습니다:

- B에서 E로 가는 총 비용은 6 + 1 = 7입니다. 그러나 이미 E로 가는 최단 경로를 찾았으므로 이 경로를 무시합니다.
- B에서 F로 가는 총 비용은 6 + 3 = 9입니다. 테이블에서 알 수 있듯이, A에서 F로 가는 현재 경로도 9의 비용이 소요됩니다. 더 짧은 경로가 아니므로 이 경로를 무시할 수 있습니다.

### 여섯 번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/8863d8b9-c75b-4fc9-a7ac-42db1b6c449f" width="400">

다음 사이클에서는 D에서 탐색을 계속합니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/b91d23a0-ae09-43e1-8ef1-891837b31a77" width="400">

하지만 D에는 나가는 간선이 없으므로 막다른 길입니다. D까지의 최단 경로를 기록하고 계속 진행합니다.

### 일곱 번째 사이클

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d6d494cd-ea41-4088-865b-772177edda21" width="400">

다음은 F입니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/f794f25b-383b-4fe6-a3cb-294897ef0466" width="400">

F는 A로 가는 하나의 나가는 간선이 있으며 총 비용은 9 + 2 = 11입니다. 그러나 A는 시작 정점이므로 이 간선을 무시할 수 있습니다.

### 여덟 번째 사이클

H를 제외한 모든 정점을 다루었습니다. H는 G와 F로 가는 두 개의 나가는 간선이 있습니다. 그러나 A에서 H로 가는 경로가 없습니다. 경로가 없으므로 H의 전체 열은 nil로 표시됩니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/5de8dea4-9c43-4325-8379-9f4cf7f9f864" width="400">

이 단계에서 Dijkstra의 알고리즘이 완료되었습니다. 모든 정점을 방문했습니다!

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/a7f51894-2b1d-4971-b532-495189219fe4" width="400">

최단 경로와 해당 경로의 비용을 확인할 수 있습니다. 예를 들어, 출력 결과에서 D까지의 비용은 7이라고 나와 있습니다. 경로를 찾기 위해서는 역추적(backtrack)을 수행해야 합니다. 각 열은 현재 정점이 연결된 이전 정점을 기록합니다. 따라서 D에서 E로, E에서 C로, C에서 G로, 그리고 마지막으로 G에서 A로 이동해야 합니다. 이제 코드에서 이를 구현하는 방법을 살펴보겠습니다.

## 구현

`인접 리스트 그래프`와 `우선순위 큐`를 사용하여 Dijkstra의 알고리즘을 구현할 것입니다.

우선순위 큐는 방문하지 않은 정점을 저장하는 데 사용됩니다. 이는 최소 우선순위 큐로 작동하여 정점을 디큐할 때마다 현재 잠정적인 최단 경로를 가진 정점을 반환합니다.

- Graph의 Vertex, Edge 구조체
    
    ```swift
    // Vertex.swift
    public struct Vertex<T> {
      public let index: Int
      public let data: T
    }
    
    // Edge.swift
    public struct Edge<T> {
      public let source: Vertex<T>
      public let destination: Vertex<T>
      public let weight: Double?
    }
    ```
    

### Visit 열거형 정의

Dijkstra.swift 파일에 다음 코드를 추가하세요:

```swift
public enum Visit<T: Hashable> {
  case start // 1
  case edge(Edge<T>) // 2
}
```

여기서는 `Visit`라는 이름의 열거형을 정의하고 있습니다. 이 유형은 다음 두 가지 상태를 추적합니다:

- 정점이 시작 정점인 경우
- 시작 정점으로 되돌아가는 경로를 가리키는 연결된 엣지를 가진 정점인 경우

### Dijkstra 클래스 정의

```swift
public class Dijkstra<T: Hashable> {
  public typealias Graph = AdjacencyList<T>
  let graph: Graph

  public init(graph: Graph) {
    self.graph = graph
  }
}
```

이전 장과 마찬가지로, Graph는 AdjacencyList에 대한 타입 별칭으로 정의됩니다.

필요에 따라 나중에 이를 인접 행렬로 대체할 수 있습니다.

### Helper 메서드

Dijkstra를 구축하기 전에, 알고리즘을 생성하는 데 도움이 되는 몇 가지 Helper 메서드를 만들어 보겠습니다.

1. **시작 지점으로 역추적하기**

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/7d21eb4b-6e74-417a-89d9-ad7f3787fc48" width="400">

현재 정점에서 시작 정점까지의 총 가중치를 추적하는 메커니즘이 필요합니다. 이를 위해 **모든 정점에 대한 Visit 상태를 저장하는 paths라는 딕셔너리를 추적**합니다.

다음 메서드를 Dijkstra 클래스에 추가하세요.

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

이 메서드는 목적지 정점과 기존 경로의 딕셔너리를 입력으로 받아, 목적지 정점으로 이어지는 경로를 구성합니다:

1. 목적지 정점에서 시작합니다.
2. 경로를 저장할 엣지 배열을 생성합니다.
3. 시작 정점에 도달할 때까지 다음 엣지를 추출하는 동안 반복합니다.
4. 이 엣지를 경로에 추가합니다.
5. 현재 정점을 엣지의 출발 정점으로 설정합니다. 이 할당은 시작 정점에 가까워지도록 합니다.
6. while 루프가 시작 정점에 도달하면 경로가 완성되고 반환됩니다.

<br></br>
2. **총 거리 계산하기**

이제 목적지에서 시작 정점까지 경로를 구성할 수 있으므로, 해당 경로의 총 가중치를 계산하는 방법이 필요합니다. 다음 메서드를 Dijkstra 클래스에 추가하세요.

```swift
private func distance(to destination: Vertex<T>,
                      with paths: [Vertex<T> : Visit<T>]) -> Double {
  let path = route(to: destination, with: paths) // 1
  let distances = path.compactMap { $0.weight } // 2
  return distances.reduce(0.0, +) // 3
}
```

이 메서드는 목적지 정점과 기존 경로의 딕셔너리를 입력으로 받아 총 가중치를 반환합니다:

- 목적지 정점까지 경로를 구성합니다.
- compactMap은 경로에서 모든 nil 가중치 값을 제거합니다.
- reduce는 모든 엣지의 가중치를 합산합니다.

helper 메서드를 구현했으므로 이제 Dijkstra의 알고리즘을 구현할 수 있습니다.

### 최단 경로 생성하기

Dijkstra클래스의`distance` 메서드 다음에 다음을 추가하세요.

```swift
public func shortestPath(from start: Vertex<T>) -> [Vertex<T> : Visit<T>] {
  var paths: [Vertex<T> : Visit<T>] = [start: .start] // 1

  // 2
  var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
    self.distance(to: $0, with: paths) < self.distance(to: $1, with: paths)
  })
  priorityQueue.enqueue(start) // 3

  // to be continued
}
```

이 메서드는 시작 정점을 입력받아 모든 경로의 딕셔너리를 반환합니다.

1. `paths`를 정의하고 시작 정점으로 초기화합니다.
2. 방문해야 하는 정점을 저장하기 위해 최소 우선순위 큐를 생성합니다. 정렬 클로저는 시작 정점으로부터의 거리에 따라 정점을 정렬하기 위해 생성한 `distance` 메서드를 사용합니다.
3. 시작 정점을 첫 번째로 방문할 정점으로 enqueue합니다.

다음과 같이 shortestPath의 구현을 완료하세요:

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

1. 모든 정점이 방문될 때까지 최단 경로를 찾기 위해 Dijkstra의 알고리즘을 계속합니다. 우선순위 큐가 비어있을 때 완료되었음을 알 수 있습니다.
2. 현재 정점에 대해 모든 이웃하는 엣지를 확인합니다.
3. 엣지의 가중치가 있는지 확인합니다. 가중치가 없는 경우 다음 엣지로 넘어갑니다.
4. 목적지 정점이 이전에 방문되지 않았거나 더 저렴한 경로를 찾았을 경우, 경로를 업데이트하고 이웃하는 정점을 우선순위 큐에 추가합니다.

모든 정점이 방문되고 우선순위 큐가 비어있으면 시작 정점까지의 최단 경로의 딕셔너리를 반환합니다.

### 특정 경로 찾기

다음 메서드를 `Dijkstra` 클래스에 추가하세요.

```swift
public func shortestPath(to destination: Vertex<T>,
                         paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
  return route(to: destination, with: paths)
}
```

이 메서드는 대상 정점과 최단 경로의 딕셔너리를 취하고 목적지 정점으로의 경로를 반환합니다.

## 코드 실행

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/987d890c-8f5b-4771-a327-f9fe674dbcb4" width="400">

메인 플레이그라운드로 이동하면 위의 그래프가 이미 인접 리스트를 사용하여 구성되었음을 알 수 있습니다. 이제 Dijkstra의 알고리즘을 실행해 보겠습니다.

다음 코드를 플레이그라운드 페이지에 추가하세요:

```swift
let dijkstra = Dijkstra(graph: graph)
let pathsFromA = dijkstra.shortestPath(from: a) // 1
let path = dijkstra.shortestPath(to: d, paths: pathsFromA) // 2
for edge in path { // 3
  print("\(edge.source) --|\(edge.weight ?? 0.0)|--> \(edge.destination)")
}
```

여기서는 그래프 네트워크를 전달하여 Dijkstra의 인스턴스를 생성하고 다음 작업을 수행합니다:

1. 시작 정점 A에서 모든 정점까지의 최단 경로를 계산합니다.
2. D까지의 최단 경로를 가져옵니다.
3. 이 경로를 출력합니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/bbb9d696-db6e-4c25-ac2c-509b6c217243" width="400">

출력 결과:

```swift
A --|1.0|--> G
G --|3.0|--> C
C --|1.0|--> E
E --|2.0|--> D
```

## 성능

Dijkstra의 알고리즘에서는 인접 리스트를 사용하여 그래프를 구성했습니다. 최소 우선순위 큐를 사용하여 정점을 저장하고 최단 경로를 가진 정점을 추출했습니다. 이 과정은 전체적으로 O(log V)의 시간 복잡도를 가집니다. 최소 요소 추출 또는 요소 삽입과 같은 힙 연산은 각각 O(log V)의 시간이 소요됩니다.

너비 우선 탐색 장에서 기억한다면, 모든 정점과 간선을 탐색하는 데는 O(V + E)의 시간이 걸립니다. Dijkstra의 알고리즘은 인접한 간선을 탐색해야 하기 때문에 너비 우선 탐색과 다소 유사합니다. 이번에는 다음 레벨로 내려가는 대신 최단 거리를 가진 단일 정점을 선택하기 위해 최소 우선순위 큐를 사용합니다. 따라서 O(1 + E) 또는 단순히 O(E)입니다. 따라서 최소 우선순위 큐와의 연산을 결합하면 Dijkstra의 알고리즘을 수행하는 데 O(E log V)의 시간이 걸립니다.

## 🗝️ Key points

- Dijkstra의 알고리즘은 시작 정점을 기준으로 나머지 노드로의 경로를 찾습니다.
- 이 알고리즘은 서로 다른 끝점 간의 최단 경로를 찾는 데 유용합니다.
- Visit 상태는 경로를 시작 정점으로 되돌아가는 데 사용됩니다.
- 우선순위 큐 데이터 구조는 최단 경로를 가진 정점을 반환하는 것을 보장합니다.
- 각 단계에서 가장 짧은 경로를 선택하기 때문에, 이 알고리즘은 탐욕적(greedy)이라고 말합니다!
