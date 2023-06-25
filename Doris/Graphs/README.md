# Graphs

그래프는 객체 간의 관계를 나타내는 데이터 구조입니다. </br>
이는 정점들이 간선으로 연결된 형태로 구성됩니다. </br>
</br>

## Weighted graphs
> 가중 그래프 </br>

**가중 그래프**에선 각 간선에 연결된 **가중치**가 있습니다. </br>
이 가중치는 해당 간선을 사용하는 비용을 나타냅니다. </br>
이러한 가중치는 두 개의 정점 사이에서 `가장 저렴하거나 최단 경로`를 선택할 수 있게 해줍니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/b75b7c51-d78b-417a-9024-32ecb3d63524">

</br>


이 예시에서 정점은 **한 나라나 주**를 나타내고, 간선은 한 장소에서 다른 장소로의 **경로**를 나타냅니다. 각 간선에 연결된 가중치는 그 두 지점 사이의 항공 요금을 나타냅니다. 이 네트워크를 사용하여 예산을 고려하는 디지털 노마드들을 위해 샌프란시스코에서 싱가포르로 가는 가장 저렴한 항공편을 결정할 수 있습니다! 

</br>

### Directed graphs

간선에 가중치를 할당하는 것 외에도, 그래프에는 **방향**을 지정할 수도 있습니다. 방향 그래프는 간선이 한 방향으로만 이동을 허용하기 때문에 탐색이 더 제한적입니다. 아래 다이어그램은 방향 그래프를 나타냅니다.

</br>

<imgwidth="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/867e6ec2-5063-4ea2-be1f-79298e50aee8">

</br>

그래프를 통해 알 수 있는 것 </br>

* 홍콩에서 도쿄로 가는 항공평이 있습니다.
* 샌프란시스코에서 도쿄로 바로 가는 항공편은 없습니다.
* 싱가포르와 도쿄 사이에 왕복 티켓을 구매할 수 있습니다.
* 도쿄에서 샌프란시스코로 가는 방법은 없습니다.

</br>

### Undirected graphs

무방향 그래프는 양방향으로 이동하는 모든 엣지가 있는 방향 그래프로 생각할 수 있습니다. </br>

* 연결된 두 개의 정점은 양방향 엣지를 가지고 있습니다.
* 엣지의 가중치는 양쪽 방향에 적용됩니다.

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/400e1c61-8bf4-47db-8916-a5f4624905c3">

</br></br>

## Common operations

```swift
public enum EdgeType {

  case directed
  case undirected
}

public protocol Graph {

  associatedtype Element

  func createVertex(data: Element) -> Vertex<Element>
  func addDirectedEdge(from source: Vertex<Element>,
                       to destination: Vertex<Element>,
                       weight: Double?)
  func addUndirectedEdge(between source: Vertex<Element>,
                         and destination: Vertex<Element>,
                         weight: Double?)
  func add(_ edge: EdgeType, from source: Vertex<Element>,
                             to destination: Vertex<Element>,
                             weight: Double?)
  func edges(from source: Vertex<Element>) -> [Edge<Element>]
  func weight(from source: Vertex<Element>,
              to destination: Vertex<Element>) -> Double?
}
```
</br>

* creatVertex(data: ) : 정점을 생성하고 그래프에 추가
* addDirectedEdge(from: to: weight: ) : 두 정점 사이에 방향이 있는 엣지를 추가
* addUndirectedEdge(between: and: weight: ) : 두 정점 사이에 무방향(양방향)엣지 추가
* add(from: to: ) : Edge Type을 사용하여 두 정점 사이에 방향이 있는지 또는 무방향인지에 따라 엣지를 추가
* edges(from: ) : 특정 정점에서 나가는 엣지의 목록을 반환
* weight(from: to: ) : 두 정점 사이의 엣지의 가중치를 반환

</br>

다은 섹션에서는 이 프로토콜을 두 가지 방식으로 구현합니다. </br>
* 인접 리스트(Adjacency List)를 사용
* 인접 행렬 (Adjacenecy Matrix)를 사용
</br>

이를 위해 먼저 정점과 엣지를 표현하는 타입을 구현해야 합니다. </br>
</br>

## Defining a vertex

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/1e9da739-314a-4f68-8f90-5d7b3fd54f95">
</br>

```swift
public struct Vertex<T> {

  public let index: Int
  public let data: T
}
```
</br>

여기에서는 제네릭한 Vertex 구조체를 정의했습니다. 정점은 그래프 내에서 고유한 인덱스를 가지며 데이터를 보유합니다. </br>

Vertex를 딕셔너리의 키 타입으로 사용할 것이므로 `Hashable`을 준수해야 합니다. 다음 확장(extension)을 추가하여 Hashable의 요구사항을 구현합니다.
</br>

```swift
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
```
</br>

Hashable 프로토콜은 `Equatable`을 상속하므로 이 프로토콜의 요구사항도 충족해야 합니다. 컴파일러는 두 프로토콜 모두에 대한 일치를 자동으로 생성할 수 있으므로 위의 확장(extension)은 비어있습니다.

마지막으로, Vertex의 사용자 정의 문자열 표현을 제공하고자 합니다. 아래의 코드를 추가하세요.
 
</br>

```swift
extension Vertex: CustomStringConvertible {

  public var description: String {
    "\(index): \(data)"
  }
}
```
</br>
</br>

## Definning an edge

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/1745b71b-d3f2-4c38-a2df-4d3de4aef931">

</br>

```swift
public struct Edge<T> {

  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}
```
</br>
</br>

## Adjacency list

`adjacency list`를 사용한 첫 번째 그래프 구현에 대해 설명하고 있습니다. 이 구현 방식에서는 그래프의 각 정점마다 나가는 간선의 목록을 저장합니다.
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/a5d26bc4-6fde-4ed0-9520-7407af878d74">
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/18edc588-0e8e-4323-ae21-8225caf07c5f">

</br>

`adjacency list`를 통해 얻을 수 있는 정보들 </br>

* 싱가포르(Singapore)의 정점은 두 개의 나가는 간선을 가지고 있습니다. 싱가포르에서 도쿄(Tokyo)와 홍콩(Hong Kong)으로 비행기가 출발합니다.
* 디트로이트(Detroit)는 나가는 트래픽이 가장 적습니다.
* 도쿄는 가장 바쁜 공항으로, 가장 많은 나가는 비행기를 가지고 있습니다.

</br>

## Implementation

```swift
public class AdjacencyList<T: Hashable>: Graph {

  private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]

  public init() {}

  // more to come ...
}
```
</br>

여기에서는 엣지를 저장하기 위해 딕셔너리를 사용하는 `AdjacencyList`를 정의했습니다. </br>
제네릭 매개변수 T는 딕셔너리의 키로 사용되므로 Hashable 프로토콜을 따라야 함에 유의하십시오. </br>

### Creating a vertex

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: adjacencies.count, data: data)
  adjacencies[vertex] = []
  return vertex
}
```

</br>

### Creating a directed edge

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/6af88c50-c0fa-4b0d-8052-7b27496c6459">
</br>

```swift
public func addDirectedEdge(from source: Vertex<T>,
                            to destination: Vertex<T>,
                            weight: Double?) {
  let edge = Edge(source: source,
                  destination: destination,
                  weight: weight)
  adjacencies[source]?.append(edge)
}
```

### Creating an undirected edge

> 두 개의 정점 간에 무방향 엣지를 생성하는 방법은 어떻게 될까요? </br>
</br>

무방향 그래프는 양방향 그래프로 볼 수 있습니다. 무방향 그래프의 각 엣지는 양방향으로 탐색할 수 있습니다. 이러한 이유로 addUndirectedEdge를 addDirectedEdge의 상단에 구현할 것입니다. 이 구현은 재사용 가능하므로 Graph의 프로토콜 확장으로 추가할 것입니다.

</br>
</br>

```swift
extension Graph {

  public func addUndirectedEdge(between source: Vertex<Element>,
                                and destination: Vertex<Element>,
                                weight: Double?) {
    addDirectedEdge(from: source, to: destination, weight: weight)
    addDirectedEdge(from: destination, to: source, weight: weight)
  }
}
```

</br>

이제 addDirectedEdge와 addUndirectedEdge를 모두 구현했으므로, `add`를 구현하여 이러한 메서드 중 하나에 위임할 수 있습니다. 동일한 프로토콜 확장에서 `add`를 구현하세요.

</br>

```swift
public func add(_ edge: EdgeType, from source: Vertex<Element>,
                                  to destination: Vertex<Element>,
                                  weight: Double?) {
  switch edge {
  case .directed:
    addDirectedEdge(from: source, to: destination, weight: weight)
  case .undirected:
    addUndirectedEdge(between: source, and: destination, weight: weight)
  }
}
```
</br>

add 메서드는 방향성이 있는 엣지나 무방향 엣지를 생성하는 편리한 도우미 메서드입니다. 이것이 프로토콜이 매우 강력해지는 지점입니다! </br>

Graph 프로토콜을 채택하는 모든 객체는 addDirectedEdge를 구현하기만 하면 addUndirectedEdge와 add를 자동으로 사용할 수 있습니다!

</br>

### Retrieving the outgoing edges from a vertex

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  adjacencies[source] ?? []
}
```
</br>
소스 버텍스가 알려지지 않은 경우에는 저장된 엣지들을 반환하거나 빈 배열을 반환합니다. </br>
</br>

### Retrieving the weight of an edge

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/9890df0d-53df-49a2-816d-ba7466d9fb6c">

> 싱가폴에서 도쿄까지 얼마일까요? </br>

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  edges(from: source)
     .first { $0.destination == destination }?
     .weight
}
```
</br>

이 코드는 소스에서 목적지로 가는 첫 번째 엣지를 찾습니다. 만약 엣지가 있다면 해당 엣지의 가중치를 반환합니다. 
</br>

### Visualizing the adjacency list

```swift
extension AdjacencyList: CustomStringConvertible {

  public var description: String {
    var result = ""
    for (vertex, edges) in adjacencies { // 1
      var edgeString = ""
      for (index, edge) in edges.enumerated() { // 2
        if index != edges.count - 1 {
          edgeString.append("\(edge.destination), ")
        } else {
          edgeString.append("\(edge.destination)")
        }
      }
      result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
    }
    return result
  }
}
```
</br>

1. adjacencies의 모든 key-value 쌍을 순회합니다.
2. 각각의 정점에 대해, 해당 정점의 모든 출발 엣지를 순회하고 적절한 문자열을 출력합니다.
3. 마지막으로, 각 정점에 대해 정점 자체와 해당 정점의 출발 엣지를 출력합니다.

</br>

이제 첫 번째 그래프를 완성했습니다! 이제 네트워크를 구축하여 실제로 시도해 보겠습니다.
</br>

### Building a network

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/0ca3ad0f-5ec3-49cb-ab64-9ca020ff7633">

</br>

```swift
let graph = AdjacencyList<String>()

let singapore = graph.createVertex(data: "Singapore")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")

graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(graph)
```
</br>

## Adjacency matrix

`인접 행렬(Adjacency matrix)`은 그래프를 표현하기 위해 정사각형 행렬을 사용합니다. 이 행렬은 2차원 배열로, matrix[row][column]의 값은 row와 column에 해당하는 정점 사이의 엣지의 가중치를 나타냅니다. </br>

아래는 다양한 장소로 여행하는 비행 네트워크를 나타내는 방향 그래프의 예시입니다. 가중치는 항공료의 비용을 나타냅니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/a8e960e3-6265-45fc-9921-400186afbb30">
</br>

다음은 위에 그려진 비행 네트워크에 대한 인접 행렬을 설명합니다.

존재하지 않는 간선의 가중치는 0입니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/96c198f2-c7a9-45e2-99e3-1ba185f688c1">
</br>

* [0][1]은 300으로, 싱가포르에서 홍콩으로 가는 항공편이 $300입니다.
* [2][1]은 0으로, 도쿄에서 홍콩으로 가는 항공편은 없습니다.
* [1][2]는 250으로, 홍콩에서 도쿄로 가는 항공편이 $250입니다.
* [2][2]는 0으로, 도쿄에서 도쿄로 가는 항공편은 없습니다!

</br>

* 참고: 행과 열이 동일한 경우 행렬의 가운데에 분홍색 선이 있습니다. 이는 정점과 자기 자신 사이의 간선을 나타내며, 허용되지 않습니다.

</br>

## Implementation

```swift
public class AdjacencyMatrix<T>: Graph {

  private var vertices: [Vertex<T>] = []
  private var weights: [[Double?]] = []

  public init() {}

  // more to come ...
}
```
</br>

위 코드는 AdjacencyMatrix라는 구조체를 정의하고, 이 구조체는 Vertex의 배열과 간선과 가중치를 추적하기 위한 인접 행렬을 포함하고 있습니다.

</br>

### Creating a Vertex

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: vertices.count, data: data)
  vertices.append(vertex) // 1
  for i in 0..<weights.count { // 2
    weights[i].append(nil)
  }
  let row = [Double?](repeating: nil, count: vertices.count) // 3
  weights.append(row)
  return vertex
}
```
</br>

1. 새로운 정점을 배열에 추가합니다.
2. 현재 정점들은 새로운 정점과의 간선을 가지고 있지 않으므로, 매트릭스의 모든 행에 nil 가중치를 추가합니다. 

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/2b85c2df-2c9a-4628-846d-223c6e94abe6">
</br>

3. 새로운 행을 매트릭스에 추가합니다. 이 행은 새로운 정점의 나가는 간선을 저장합니다.

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/dab96781-a932-47d8-9e2c-79d8c763a8d9">
</br>

### Creating edges

```swift
public func addDirectedEdge(from source: Vertex<T>,
                            to destination: Vertex<T>, weight: Double?) {
  weights[source.index][destination.index] = weight
}
```
</br>

### Retrieving the outgoing edges from a vertex

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  var edges: [Edge<T>] = []
  for column in 0..<weights.count {
    if let weight = weights[source.index][column] {
      edges.append(Edge(source: source,
                        destination: vertices[column],
                        weight: weight))
    }
  }
  return edges
}
```
</br>

해당 정점의 행을 매트릭스에서 찾아서 nil이 아닌 가중치를 가지는 것들을 찾습니다.
</br>

각각의 nil이 아닌 가중치는 나가는 간선을 나타냅니다. 목적지는 해당 가중치가 발견된 열에 해당하는 정점입니다.
</br>

이 과정을 통해 AdjacencyMatrix 구조체에서 특정 정점의 나가는 간선을 검색할 수 있습니다.
</br>

### Retrieving the weight of an edge

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  weights[source.index][destination.index]
}
```

</br>

### Visualize an adjacency matirx

```swift
extension AdjacencyMatrix: CustomStringConvertible {

  public var description: String {
    // 1
    let verticesDescription = vertices.map { "\($0)" }
                                      .joined(separator: "\n")
    // 2
    var grid: [String] = []
    for i in 0..<weights.count {
      var row = ""
      for j in 0..<weights.count {
        if let value = weights[i][j] {
          row += "\(value)\t"
        } else {
          row += "ø\t\t"
        }
      }
      grid.append(row)
    }
    let edgesDescription = grid.joined(separator: "\n")
    // 3
    return "\(verticesDescription)\n\n\(edgesDescription)"
  }
}
```
</br>

1. 정점들의 리스트를 생성합니다.
2. 그런 다믕, 행마다 가중치 그리드를 구성합니다.
3. 마지막으로, 두 개의 설명을 함께 결합하고 반환합니다.

위의 과정을 통해 정점 리스트와 가중치 그리드를 결합하여 반환합니다. </br>

* 시각적인 아름다움 측면에서, 인접 리스트는 인접 행렬보다 추적하고 따라가기가 훨씬 쉽습니다. 
* 이제 이 두 가지 방식의 일반적인 작업을 분석하고 그들의 성능을 살펴보겠습니다.

</br>

## Graph analysis

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/c9b79fe2-d1be-4e4d-9c17-f520b066608c">

</br>

V는 정점(Vertices)을 나타내고, E는 간선(Edges)을 나타냅니다. </br>

</br>

인접 리스트는 인접 행렬보다 적은 저장 공간을 사용합니다. 인접 리스트는 필요한 정점과 간선의 수만 저장합니다. 반면, 인접 행렬은 행과 열의 수가 정점의 수와 동일하다는 것을 기억해야 합니다. 이로 인해 인접 행렬의 공간 복잡도는 O(V²)의 이차 시간 복잡도를 가집니다. </br>

</br>

인접 리스트에서 정점을 추가하는 것은 효율적입니다. 단순히 정점을 생성하고 사전에 해당 키-값 쌍을 설정하면 됩니다. 이는 평균 O(1)의 시간 복잡도를 가집니다. 반면, 인접 행렬에 정점을 추가할 때는 모든 행에 열을 추가하고 새로운 정점을 위한 새로운 행을 생성해야 합니다. 이는 최소한 O(V)의 시간이 소요되며, 메모리의 연속적인 블록으로 행렬을 표현하는 경우 O(V²)의 시간 복잡도가 될 수 있습니다. </br>

</br>

간선을 추가하는 것은 두 데이터 구조 모두 효율적입니다. 인접 리스트는 나가는 간선의 배열에 요소를 추가하기만 하면 됩니다. 인접 행렬은 단순히 이차원 배열에서 값을 설정하기만 하면 됩니다.
</br>
</br>
인접 리스트는 특정 간선이나 가중치를 찾을 때 불리합니다. 인접 리스트에서 간선을 찾으려면 나가는 간선의 목록을 얻고 일치하는 목적지를 찾기 위해 모든 간선을 순회해야 합니다. 이는 O(V)의 시간이 소요됩니다. 반면, 인접 행렬에서 간선이나 가중치를 찾는 것은 이차원 배열에서 값을 검색하는 상수 시간에 이루어집니다.</br></br>

그래프를 구성하기 위해 어떤 데이터 구조를 선택해야 할까요?

</br></br>

간선의 수가 적은 그래프는 희소 그래프로 간주되며, 인접 리스트가 적합한 선택입니다. 간선의 수가 적은 경우 인접 행렬은 많은 메모리가 낭비되므로 좋지 않은 선택입니다.
</br></br>

간선이 많은 그래프는 밀집 그래프로 간주되며, 인접 행렬이 더 적합합니다. 인접 행렬을 사용하면 가중치와 간선에 더 빠르게 접근할 수 있습니다.
</br>
</br>

## Key Points

* 정점과 간선을 통해 현실 세계의 관계를 나타낼 수 있습니다.

* 정점을 객체로, 간선을 객체 간의 관계로 생각할 수 있습니다.

* 가중 그래프는 각 간선에 가중치를 할당합니다.

* 유향 그래프는 한 방향으로 이동하는 간선을 가지고 있습니다.

* 무향 그래프는 양방향으로 이동하는 간선을 가지고 있습니다.

* 인접 리스트는 각 정점에 대한 나가는 간선의 목록을 저장합니다.

* 인접 행렬은 그래프를 나타내기 위해 정사각형 행렬을 사용합니다.

* 인접 리스트는 일반적으로 그래프의 간선이 가장 적은 희소 그래프에 적합합니다.

* 인접 행렬은 일반적으로 그래프의 간선이 많은 밀집 그래프에 적합합니다