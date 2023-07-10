# Dijkstra’s Algorithm

구글 맵이나 애플 지도에서 다른 지역으로의 최소 거리나 최단 시간을 알려주는 것을 사용해보셨나요? 다익스트라 알고리즘(Dijkstra’s algorithm)은 GPS 네트워크 기반의 두 장소 간의 최단 거리를 찾는 데에 매우 유용합니다.

다익스트라 알고리즘은 그리디 알고리즘입니다. 그리디 알고리즘은 문제를 단계별로 해결하면서 해당 단계에서 가장 최선의 경로를 선택합니다. 이는 어떠한 경로에서는 비용이 더 많이 들 수도 있지만, 전체적인 비용은 더 낮습니다. 그럼에도 불구하고, 꽤 좋은 솔루션을 매우 빠르게 제시해줍니다.

다익스트라 알고리즘은 유방향 그래프나 무방향 그래프의 정점 사이에서 가장 짧은 경로를 제시해줍니다. 

그래프에 정점이 주어져있다면, 이 알고리즘은 시작 정점에서 가장 짧은 경로를 찾아줄 것입니다.

다익스트라 알고리즘은 다른 상황에서도 응용할 수 있습니다.

1. 전염성 질병 전파 : 생물학적 질병이 가장 빠르게 확산되는 곳을 찾아줍니다.
2. 전화 네트워크 : 네트워크에서 사용할 수 있는 가장 높은 대역폭 경로로 라우팅해줍니다.
3. 매핑 : 여행자들을 위해 가장 짧고 빠른 경로를 찾아줍니다.

## Example

지금까지 봤던 그래프는 무방향 그래프였습니다. 이를 조금 변형해서 유방향 그래프에서 적용해봅시다. 
GPS 네트워크로 표현될 수 있는 유방향 그래프를 상상해봅시다. 
정점은 물리적 위치를 나타내고 간선은 경로에 대한 비용을 나타냅니다. 

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ef19cf41-56c1-4140-bfdc-ae252e29d421)

다익스트라 알고리즘에서 그래프의 나머지 노드에 대한 경로를 찾기 위한 시작점이 필요하므로 먼저 시작 정점을 선택합니다. 선택한 시작 정점이 정점 A라고 가정합니다.

### First pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/d6a3bc27-9f06-42b0-9c71-65fc26a6db4a)

정점 A부터 지나가는 모든 간선을 살펴봅니다. 이 경우에는 3가지 간선이 있습니다.

- 8의 비용이 있는 A부터 B
- 9의 비용이 있는 A부터 F
- 1의 비용이 있는 A부터 G

나머지 정점들은 A에서 직접적으로 갈 수 있는 경로가 없기 때문에 nil로 표시됩니다.

이 예시를 통해 그래프 오른쪽의 표는 각 단계에서의 다익스트라 알고리즘의 기록을 나타냄을 알 수 있습니다. 
알고리즘이 각 단계를 지나갈 때마다 테이블에 행이 추가됩니다. 테이블의 마지막 행은 알고리즘의 최종 출력이 될 것입니다.

### Second pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/86ded502-41c5-4cfc-a8a3-bcb3194b7e82)

다음 사이클에서, 다익스트라 알고리즘은 지금까지의 경로 중 최저 비용의 경로를 탐색합니다. A에서 G가 가장 적은 비용인 1을 가지고 있으면서 G로 갈 수 있는 최단 경로입니다. 이 경로는 결과 테이블과 함께 표시합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/64f7bb46-cf18-4525-9294-32768124f370)

이제 최저 비용의 경로인 정점 G에서 간선을 살펴봅니다. G에서 C로 갈 수 있는 간선만이 존재하고, 총 비용은 4입니다. A에서 G에서 C까지의 비용이 1 + 3 = 4이기 때문입니다.

결과 테이블에 있는 모든 값들은 두가지 종류가 있는데, 해당 정점에 도달하는데에 있어서의 총 비용과 그 정점까지의 경로에서 마지막 이웃입니다. 예를 들어, 정점 C의 열에 있는 4G는 C에 도달하는 비용은 4이고, G를 통과하여 C로 가는 것을 의미합니다. nil값은 해당 정점에서 간선을 발견하지 못했다는 것을 의미합니다.

### Third pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/7057ee60-aa7a-4124-a2e6-a45ecdc8f66b)

다음 사이클에서, 그 다음으로 적은 비용을 찾습니다. 테이블에 의하면, C로 가는 경로가 가장 작은 비용이므로 C에서부터 탐색이 시작될 것입니다. C로 갈 수 있는 가장 짧은 경로를 찾았기 때문에 C열을 채울 것입니다. 

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/87b229fb-3007-429c-bca2-d59290d9e613)

C가 지나가는 간선들을 살펴봅시다.

- C에서 E는 총 4 + 1 = 5의 비용을 가집니다.
- C에서 B는 총 4 + 3 = 7의 비용을 가집니다.

더 적은 비용으로 B를 갈 수 있는 경로를 찾았으므로 B에 대한 이전 값을 교체합니다.

### Fourth pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/2e19eee8-6298-46f8-ac06-be5268b68524)

이제 다음 사이클에서는 어떤 경로가 다음으로 가장 낮은 비용을 가지는지 생각해보십시오. 표에 따르면, C에서 E가 가장 낮은 비용인 5이므로 탐색은 E부터 계속될 것입니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/99071f23-1fb4-489e-a32d-70f8d248e65f)

최단 경로를 찾았기 때문에 E열을 채웁니다. 정점 E는 다음과 같은 간선들을 가집니다.

- E에서 C는 총 비용 5 + 8 = 13을 가집니다. 하지만 이미 C로 가는 최단 경로를 찾았기 때문에, 이 경로는 버립니다.
- E에서 D는 총 5 + 2 = 7의 비용을 가집니다.
- E에서 B는 총 5 + 1 = 6의 비용을 가집니다. 표에 의하면, 현재 B로 갈 수 있는 최단 거리의 총 비용은 7입니다. E에서 B로 갈 수 있는 총 비용이 6인 경우로 최단 경로를 업데이트 해줍니다.

### Fifth pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5dbac366-345e-4629-9c70-7eb50889b189)

다음으론, B에서부터 탐색을 진행합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/924edbb0-d976-4e34-a7ca-85d4772f7027)

B가 가지는 간선들은 다음과 같습니다.

- B에서 E는 총 6 + 1 = 7의 비용이지만, E로 가는 최단 경로를 이미 찾았기 때문에 이 경로를 버립니다.
- B에서 F는 총 6 + 3 = 9입니다. 표로부터 A에서부터 F로 가는 현재 경로가 9만큼의 비용이 듦을 알 수 있습니다. 이 경로는 더 짧아질 수 없기 때문에 버려도 됩니다.

### Sixth pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/39ba693d-0895-4124-9c8f-9cc359be9610)

다음 사이클에서는 D에서부터 탐색을 시작합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/9073627c-7865-4ec8-9c03-64cdae2f9e42)

하지만, D는 간선이 없기 때문에 끝자락입니다. D까지의 최단 경로를 찾았으므로 이를 기록한 뒤 넘어갑니다. 

### Seventh pass

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/574210d0-bb4b-4c0f-aa8e-21ec7ee16628)

다음 차례는 F입니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/8f5ad5a3-3245-4a33-a43d-f447996d687d)

F는 A로 가는 간선만 있고 이는 9 + 2 = 11의 비용이 듭니다. A는 시작 정점이기 때문에 이 간선은 무시해도 됩니다.

### Eighth pass

H를 제외한 모든 정점을 다뤘습니다. H는 G와 F로 가는 두 간선이 있습니다. 하지만, A에서 H로 가는 경로는 없습니다. 왜냐하면 전체 H열은 nil이 때문입니다. 

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/fc1766df-3561-49c3-9f8f-6369561145b5)

이 단계에서 모든 정점이 방문되었기 때문에 다익스트라 알고리즘은 완료되었습니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/29b86bf4-946a-4ae2-98af-871b1bfea288)

이제 최단 경로와 그 비용에 대한 마지막 행을 확인할 수 있습니다. 예를 들어, 결과는 D로 가는 비용이 7이라는 것을 말해주고 있습니다. 길을 찾기 위해, 역추적을 합니다. 각 열은 현재 정점이 연결된 이전 정점을 기록합니다. D에서 E에서 C에서 G를 방문하고 마지막으로 A로 도달해야 합니다. 이를 코드로 어떻게 만들 수 있는지 확인해봅시다.

## Implementation

playground starter 파일을 열어보면 다익스트라 알고리즘에서 실행하기 위해 사용해야 할 인접 리스트 그래프와 우선순위 큐가 제공되어 있습니다. 

우선순위 큐는 방문하지 않은 정점들을 저장하기 위해 사용되었습니다. 이것은 최소 우선순위 큐로써, 정점을 dequeue할 때마다 현재 잠정적으로 가장 짧은 경로를 갖는 정점을 반환합니다.

```swift
public enum Visit<T: Hashable> {
  case start // 1
  case edge(Edge<T>) // 2
}
```

여기서 Visit이라는 enum을 정의합니다. 이 타입은 두 가지 상태를 추적합니다.

1. 해당 정점은 시작 정점입니다.
2. 정점은 시작 정점으로 돌아가는 경로로 이어지는 연결된 간선이 있습니다.

이제 Dijkstra라고 불리는 클래스를 정의합시다. 위에서 작성한 코드 다음에 따라 작성합니다.

```swift
public class Dijkstra<T: Hashable> {

  public typealias Graph = AdjacencyList<T>
  let graph: Graph

  public init(graph: Graph) {
    self.graph = graph
  }
}
```

이전 장에서와 같이, Graph는 AdjacencyList의 typealias입니다. 만약 필요하다면 미래에 인접 행렬로 변경할 수 있습니다.

### Helper methods

Dijkstra를 만들기 전에, 알고리즘을 만드는데 도와줄 helper 메소드를 생성해봅시다.

**Tracing back to the start**

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/00297c93-50ad-412c-8f5f-87f54410009c)

현재 정점에서 시작 정점까지의 총 가중치를 추적하기 위한 매커니즘이 필요합니다. 그러기 위해선, 모든 정점의 방문 여부를 저장하기 위한 paths라는 딕셔너리를 추적해야 합니다. Dijkstra 클래스에 다음 메소드를 추가합니다.

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

이 메소드는 목적지 정점과 기존 경로들의 딕셔너리를 입력받아 목적지 정점으로 이어지는 경로를 구성합니다. 

1. 목적지 정점에서 시작합니다.
2. 경로를 저장하기 위해 간선에 대한 배열을 생성합니다.
3. start 케이스에 도달하지 않는 한, 계속해서 다음 간선을 추출합니다.
4. 이 간선을 경로에 추가합니다.
5. 현재 정점을 간선의 source 정점으로 지정합니다. 이는 시작 정점으로 가까워지게 합니다.
6. while문이 start 케이스에 도달한다면, 경로가 완료되었으므로 이를 반환합니다.

**Calculating total distance**

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/683882aa-3d33-4db1-829f-f5e24ed7ef72)

목적지에서 시작 정점까지의 경로를 만들 수 있기 때문에, 그 경로에 대한 총 가중치를 계산하는 방법을 알아야 합니다. 해당 메소드를 Dijkstra 클래스에 추가하십시오.

```swift
private func distance(to destination: Vertex<T>,
                      with paths: [Vertex<T> : Visit<T>]) -> Double {
  let path = route(to: destination, with: paths) // 1
  let distances = path.compactMap { $0.weight } // 2
  return distances.reduce(0.0, +) // 3
}
```

이 메소드는 목적지 정점과 존재하는 경로의 딕셔너리를 가지고, 총 가중치를 반환합니다. 

1. 목적지 정점에 경로를 생성합니다.
2. `compactMap` 은 경로에서 nil 가중치 값을 모두 제거합니다.
3. `reduce` 는 모든 간선의 가중치를 더합니다.

이제 helper 메소드를 만들었으니 다익스트라 알고리즘을 실행할 수 있습니다.

### Generating the shortest paths

distance 메소드 이후 해당 식을 추가합니다.

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

해당 메소드는 시작 정점을 가지고, 모든 경로에 대한 딕셔너리를 반환합니다. 위 메소드에서 다음을 진행합니다.

1. paths를 정의하고 시작 정점으로 초기화합니다.
2. 꼭 방문해야하는 정점들을 저장하기 위한 최소 우선 순위 큐를 생성합니다. sort 클로저는 시작 정점으로부터의 거리에 따라 정점들을 정렬하기 위해 만든 distance 메소드를 사용합니다. 
3. 시작 정점을 방문해야하는 첫 정점으로 enqueue합니다.

`shortestPath` 를 수행합니다.

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

1. 모든 정점들이 방문되기 전까지 최단 경로를 찾기 위해 다익스트라 알고리즘을 진행합니다. 우선순위 큐가 비어있을 때 완료됩니다.
2. 현재 정점에 대해 모든 이웃 간선들을 지납니다.
3. 간선들에 가중치가 있는지 확인합니다. 가중치가 없다면 다음 간선으로 이동합니다.
4. 만약 목적지 정점이 방문되지 않았거나 더 싼 경로를 찾았을 때, 경로를 업데이트하고 우선순위 큐에 ㅇ이웃 정점을 추가합니다.

모든 정점이 방문되었고 우선순위 큐가 비었을 때, 시작 정점에 최단경로의 딕셔너리를 반환합니다.

### Finding a specific path

Dijkstra 클래스에 메소드를 추가합니다.

```swift
public func shortestPath(to destination: Vertex<T>,
                         paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
  return route(to: destination, with: paths)
}
```

이 메소드는 목적지 정점과 최단 경로의 딕셔너리를 가지며 목적지 정점의 경로를 반환합니다.

## Trying out your code

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/85f6a4ca-de1c-44f2-b028-c5b1edb025c3)

위의 그래프는 이미 인접 리스트를 생성했음을 알 수 있습니다. 이제 다익스트라 알고리즘을 실행할 차례입니다.

```swift
let dijkstra = Dijkstra(graph: graph)
let pathsFromA = dijkstra.shortestPath(from: a) // 1
let path = dijkstra.shortestPath(to: d, paths: pathsFromA) // 2
for edge in path { // 3
  print("\(edge.source) --|\(edge.weight ?? 0.0)|--> \(edge.destination)")
}
```

여기서 그래프 네트워크를 통과하면서 Dijkstra 인스턴스를 생성하고 밑의 식을 수행합니다.

1. 시작 정점 A부터 모든 정점에 대해 최단 경로를 계산합니다.
2. D로 가는 최단 경로를 얻습니다.
3. 이 경로를 프린트합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3e6d82a8-b239-4a2f-ad56-4ac8f1f6fbc5)

```swift
A --|1.0|--> G
G --|3.0|--> C
C --|1.0|--> E
E --|2.0|--> D
```

## Performance

다익스트라 알고리즘에서 인접 리스트를 사용하여 그래프를 생성하였습니다. 정점을 저자아기 위해 최소 우선순위 큐를 사용하였고 최소 경로를 가지도록 정점을 추출하였습니다. 이 과정은 O(log V)의 시간 복잡도를 가집니다. 최소 값을 추출하는 것이나 삽입하는 힙 연산은 둘 다 O(log V)의 시간 복잡도를 가집니다.

만약 BFS를 되돌아본다면, 모든 정점과 간선을 탐색하는데 O(V + E)가 걸립니다. 다익스트라 알고리즘은 모든 이웃 간선들을 체험하는 것이기 때문에 BFS와 유사합니다. 하지만 이번에는 다음 레벨로 내려가는 대신, 최소 우선순위 큐를 사용하여 가장 짧은 거리를 가진 단일 정점을 선택하여 내려가게 됩니다. 이는 O(1 + E)나 그저 O(E)임을 의미합니다. 따라서 최소 우선순위 큐를 통해 탐색 연산을 진행하는 것은 다익스트라 알고리즘이 O(E log V)의 성능인 것입니다.

## Key points

- 다익스트라 알고리즘은 시작 정점을 기준으로 나머지 노드에 대한 최단 경로를 찾습니다.
- 이 알고리즘은 다른 끝점에 대해 최단 경로를 찾는데 유용합니다.
- Visit 상태는 시작 정점으로 돌아가는 경로를 추적하기 위해 사용됩니다.
- 우선순위 큐 자료 구조는 최단 경로와 함께 정점을 반환해줍니다.
- 각각의 단계에서 최단 경로를 선택하기 때문에, 그리디라고도 불립니다.
