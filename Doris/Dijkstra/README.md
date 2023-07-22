# Dijkstra's Algorithm

Dijkstra 알고리즘은 **탐욕 알고리즘**의 한 종류입니다. 탐욕 알고리즘은 솔루션을 한 단계씩 구성하며, **각 단계에서 단독으로 가장 최적의 경로**를 선택합니다. 이는 일부 단계에서 비용이 더 많이 드는 해결책을 놓치지만, 전체적으로는 비용이 낮은 좋은 해결책에 도달하는 경우가 많습니다. 그러므로 일반적으로 빠르게 꽤 좋은 해결책을 찾을 수 있습니다.
</br>

Dijkstra 알고리즘은 방향성이 있는 그래프 또는 무방향 그래프에서 정점 사이의 최단 경로를 찾습니다. 그래프의 한 정점이 주어지면, 알고리즘은 시작 정점으로부터 모든 최단 경로를 찾아냅니다.
</br>

Dijkstra 알고리즘의 응용 분야 </br>

* 전염병 전파 : 생물학적 질병이 가장 빠르게 퍼지는 지역을 파악합니다.
* 전화 네트워크 : 네트워크에서 가장 높은 대역폭 경로로 통화를 라우팅합니다.
* 지도 : 여행자들에게 가장 짧고 빠른 경로를 찾습니다.

</br>

## Example 

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/edd28174-c03a-4f9c-868c-f0bb1ac85f6c">

> 다음 그림은 GPS 네트워크를 나타내는 방향 그래프입니다. </br>

정점은 실제 위치를 나타내며, 간선은 위치 간의 한 방향 경로를 나타내는 비용을 나타냅니다. </br>
다익스트라 알고리즘에서는 먼저 시작 정점을 선택합니다. 알고리즘은 그래프의 다른 노드들로의 경로를 찾기 위해 시작지점이 필요합니다. 선택한 시작 정점을 `정점 A`라고 가정합니다. </br>

### First pass

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/1579784b-5939-4c52-9a00-e5f17acdf841">


`정점 A`에서 갈 수 있는 다른 노드들은 다음과 같이 3개입니다. </br>
* A -> B : 8 (비용)
* A -> F : 9
* A -> G : 1

나머지 정점들은 A로부터 직접적인 경로가 없기 때문에 nil로 표시됩니다. </br>

이 예시를 따라가면서 그래프 오른쪽의 테이블은 각 단계별 Dijkstra 알고리즘의 기록을 나타냅니다. 알고리즘의 각 단계마다 테이블에 한 행씩 추가됩니다. 테이블의 마지막 행은 알고리즘의 최종 결과가 됩니다. </br>

### Second pass

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/ba569eda-6225-4761-bd34-1a223935bc74">

다음 단계에서 Dijkstra 알고리즘은 지금까지 가장 낮은 비용의 경로를 살펴봅니다. A에서 G까지의 비용이 1로 가장 작고, G에 도달하는 최단 경로입니다. 이 경로는 출력 테이블에서 진한 채움으로 표시됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/6a2a0372-d510-4c74-982c-2e4106826a2c">

이제 가장 낮은 비용의 경로인 `정점 G`에서 모든 출발하는 간선들을 살펴봅니다. G에서 C로 가는 간선은 하나뿐이며, 총 비용은 4입니다. 이는 A에서 G를 거쳐 C로 가는 비용이 1 + 3 = 4임을 의미합니다.
</br>

출력 테이블의 각 값은 두 부분으로 구성됩니다: 해당 정점에 도달하기 위한 총 비용과 해당 정점까지의 경로에서 마지막 이웃 정점입니다. 예를 들어, 정점 C의 열에서 값이 4 G라는 것은 C에 도달하는 비용이 4이고, C로 가는 경로가 G를 거쳐간다는 것을 의미합니다. **nil 값은 해당 정점까지의 경로가 아직 발견되지 않았음**을 나타냅니다. </br>

### Third pass
<img th="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/00fa7c5c-f0c3-4d8a-9eb2-0b93d6444e3c">

다음 단계에서는 다음으로 낮은 비용을 살펴봅니다. 테이블에 따르면 C로 가는 경로가 가장 낮은 비용을 가지므로, 검색은 C부터 계속됩니다. C에 도달하는 최단 경로를 찾았기 때문에 `C 열`을 채웁니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/156c5509-a7e2-4b47-841f-3e81eaa7d6b0">

C에서 다음 정점으로 갈 수 있는 경우를 살펴보면 다음과 같습니다. </br>
* C -> E : 4 + 1 = 5
* C -> B : 4 + 3 = 7
기존의 비용(8)보다 더 낮은 비용의 B로 가는 경로(7)를 찾았기 때문에, 이전의 B에 대한 값이 대체되었습니다. </br>


### Fourth pass
<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/40b5476f-3633-42be-802a-aa7620bc31e6">

다음으로 낮은 비용의 경로는 C -> E 경로(5)이므로, 검색은 E부터 계속됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/30bc6456-ba24-4fce-ac54-1db9b99bbaf8">

최단 경로를 찾았기 때문에 E 열을 채웁니다. 정점 E에는 다음과 같은 나가는 간선들이 있습니다. </br>
* E -> C : 5 + 8 = 13
* E -> D : 5 + 2 = 7
* E -> B : 5 + 1 = 6
B의 기존 최소비용(7)보다 더 낮은 비용(6)을 찾았으므로, 업데이트 해줍니다. </br>

### Fifth pass
<img width="60%" height="60%"  alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/6bf1c43a-4b41-438f-9126-74958b32de44">

다음 탐색은 B부터 계속됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/2b8261c0-8b74-40c1-9c51-5d69050f0114">

* B -> E : 6 + 1 = 7 
> 이미 E로 가는 최단 경로를 찾았으므로 무시 </br>
* B -> F : 6 + 3 = 9
> 최단 경로가 아니므로 무시 </br>

### Sixth pass
<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/407f08f6-3c7b-4725-a951-2dd9bf6d24d8">

다음 단계는 정점 D부터 시작합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/a5b2b5e7-d0cd-4696-908f-a2b5f7a4c0fd">

그러나 D는 나가는 간선이 없으므로 막다른 길입니다. D까지의 최단 경로를 찾았다는 것을 기록하고 다음으로 넘어갑니다. </br>

### Seventh pass
<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/8371d45a-3903-4aea-8cdd-ac2a0388b97e">

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/d5492495-2b22-47bf-9519-4ef620fb44a3">

</br>

F에는 A로 가는 나가는 간선이 하나 있으며, 총 비용은 9 + 2 = 11입니다. 시작 정점이 A이므로 이 간선은 무시할 수 있습니다. </br>

### Eight pass

H를 제외한 모든 정점을 확인했습니다. H는 G와 F로 가는 두 개의 나가는 간선이 있습니다. 그러나 A에서 H로 가는 경로가 없습니다. 따라서 H에 해당하는 열은 전부 nil입니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/50d0890c-8007-4581-99c2-35ca0c0fb4bf">

모든 정점이 방문되었기 때문에 이 단계에서 Dijkstra 알고리즘이 완료됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/b42b5eca-398b-4325-bb49-62dac7df46d9">

이제 최종 행을 확인하여 최단 경로와 해당 비용을 알 수 있습니다. 예를 들어, 출력 결과에서 D까지의 비용은 7입니다. 경로를 찾기 위해 역추적을 합니다. 각 열은 현재 정점이 연결된 이전 정점을 기록합니다. D에서 E로, 그리고 C로, 그리고 G를 거쳐 마지막으로 A까지 돌아가는 경로를 얻을 수 있습니다. 이제 코드로 이를 어떻게 구현하는지 살펴보겠습니다.

</br>

## Implementation

우선순위 큐는 방문되지 않은 정점을 저장하는 데 사용됩니다. 최소 우선순위 큐이므로, 정점을 dequeue할 때마다 현재 잠정적으로 최단 경로를 갖는 정점이 반환됩니다. </br>

```swift
public enum Visit<T: Hashable> {
  case start // 1
  case edge(Edge<T>) // 2
}
```
</br>

1. 이 정점은 시작 정점입니다.
2. 이 정점은 시작 정점으로 돌아가는 경로로 이어지는 연결된 간선이 있습니다. </br>

```swift
public class Dijkstra<T: Hashable> {

  public typealias Graph = AdjacencyList<T>
  let graph: Graph

  public init(graph: Graph) {
    self.graph = graph
  }
}
```
</br>

### Helper methods

* Tracing back to the start

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/7b452c2f-7f42-4fc7-b127-901898dc8137">

현재 정점에서 시작 정점까지의 총 가중치를 추적하는 메커니즘이 필요합니다. 이를 위해 모든 정점에 대해 방문 상태를 저장하는 paths라는 딕셔너리를 유지할 것입니다. </br>

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
</br>

> 이 메서드는 목표 정점과 기존 경로를 나타내는 딕셔너리를 입력으로 받아, 목표 정점으로 이어지는 경로를 구성합니다. </br>

1. 목표 정점에서 시작합니다.
2. 경로를 저장할 엣지 배열을 생성합니다.
3. 시작 정점에 도달할 때까지, 다음 엣지를 추출하는 동안 계속 진행합니다.
4. 이 엣지를 경로에 추가합니다.
5. 현재 정점을 엣지의 출발 정점으로 설정합니다. 이 할당은 시작 정점에 가까이 이동하는 것을 의미합니다. 
6. while 루프가 시작 정점에 도달하면, 경로가 완성되며 이를 반환합니다. </br>

* Calculating total distance
<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/b576404a-adcb-4549-87f9-41748831679a">

```swift
private func distance(to destination: Vertex<T>,
                      with paths: [Vertex<T> : Visit<T>]) -> Double {
  let path = route(to: destination, with: paths) // 1
  let distances = path.compactMap { $0.weight } // 2
  return distances.reduce(0.0, +) // 3
}
```
</br>

1. 목표 정점으로 가는 경로를 구성합니다.
2. compactMap은 경로에서 모든 nil 가중치 값을 제거합니다.
3. `reduce`는 모든 엣지의 가중치를 합산합니다.

</br>

### Generating the shortest paths
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

1. paths를 정의하고 시작 정점으로 초기화합니다.
2. 최소 우선순위 큐를 생성하여 방문해야 할 정점을 저장합니다. sort 클로저는 distance 메서드를 사용하여 시작 정점으로부터의 거리를 기준으로 정점들을 정렬합니다.
3. 시작 정점을 첫 번째로 방문해야 할 정점으로 enqueue 합니다.

</br>

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

1. 모든 정점이 방문되었을 때 우선순위 큐가 비어있는 상태로 알 수 있으므로, 우선순위 큐가 비어질 때까지 Dijkstra 알고리즘을 계속하여 최단 경로를 찾습니다.
2. 현재 정점에 대해 모든 인접한 엣지를 확인합니다.
3. 엣지에 가중치가 있는지 확인합니다. 가중치가 없다면 다음 엣지로 넘어갑니다.
4. 목표 정점이 이전에 방문되지 않았거나 더 저렴한 경로를 찾았다면, 경로를 업데이트하고 인접 정점을 우선순위 큐에 추가합니다.

</br>

### Finding a specific path

```swift
public func shortestPath(to destination: Vertex<T>,
                         paths: [Vertex<T> : Visit<T>]) -> [Edge<T>] {
  return route(to: destination, with: paths)
}
```
이 메서드는 목표 정점과 최단 경로 딕셔너리를 입력으로 받아 목표 정점으로의 경로를 반환합니다.
</br>

