# Graph

그래프는 다양한 것들을 모델링할 수 있는 중요한 데이터 구조이다. 예를 들어 인터넷의 웹페이지, 조류의 이동 패턴, 원자 핵 내의 양성자 등을 그래프로 나타낼 수 있다.

그래프는 객체 간의 관계를 포착하는 데이터 구조이다. 이는 정점을 연결하는 에지로 구성됩니다.

아래 그래프에서 원은 정점을 나타내며, 에지는 정점을 연결하는 선을 지칭한다.

![](https://hackmd.io/_uploads/H1RPrfNu2.png)

## Weighted graphs

가중 그래프에서는 각각의 에지마다 가중치가 존재한다. 이 가중치는 해당 에지를 사용하는 데 필요한 비용을 나타낸다. 이 가중치를 사용하여 두 정점 사이의 가장 저렴하거나 최단 경로를 선택할 수 있다.

![](https://hackmd.io/_uploads/HJUPufVOn.png)

## Directed graphs

에지에 가중치를 할당하는 것 외에도 그래프는 방향을 가질 수 있다. 방향 그래프는 에지를 한 방향으로만 탐색할 수 있도록 제한한다.

![](https://hackmd.io/_uploads/BkSqqzVu2.png)

## Undirected graphs

무방향 그래프는 모든 에지가 양방향인 방향 그래프로 생각할 수 있다.

정점은 양방향으로 에지가 가지고 있다. 에지의 가중치는 양 방향으로 모두 적용된다.

![](https://hackmd.io/_uploads/HJaaTf4O2.png)

## Common Operation

```swift
// Graph.swift
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
- createVertex(data:): 정점을 만들고 그래프에 추가합니다.
- addDirectedEdge(from:to:weight:): 두 정점 사이에 방향성 에지를 추가합니다.
- addUndirectedEdge(between:and:weight:): 두 정점 사이에 비방향(또는 양방향) 에지를 추가합니다.
- add(from:to:): EdgeType을 사용하여 두 정점 사이에 방향 또는 비방향 에지를 추가합니다.
- edges(from:): 특정 정점에서 나가는 에지 목록을 반환합니다.
- weight(from:to:): 두 정점 사이의 에지의 가중치를 반환합니다.

### Defining a vertex

```swift
// Vertex.swift
public struct Vertex<T> {
  public let index: Int
  public let data: T
}
```
정점은 그래프 내에 고유한 인덱스를 가졌으며 데이터를 보유하고 있다.

```swift
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
```

Hashble을 채택하려면 상위프로토콜인 Equatable 또한 채택해주어야 한다.

### Defining an edge

```swift
// Edge.swift
public struct Edge<T> {
  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}
```

두 정점을 연결하려면, 그들 사이에 에지가 있어야 한다.

### Adjacency list

![](https://hackmd.io/_uploads/HJcK7VNOn.png)

#### 구현

```swift
// AdjacencyList.swift
public class AdjacencyList<T: Hashable>: Graph {
  private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
  public init() {}
  // more to come ...
}
```
여기서, 당신은 딕셔너리를 사용하여 가장자리를 저장하는 AdjacencyList를 정의했다. 일반 매개 변수 T는 딕셔너리의 키로 사용되기 때문에 Hashable이어야 한다.

#### 정점 만들기

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: adjacencies.count, data: data)
  adjacencies[vertex] = []
  return vertex
}
```

#### Directed edge 만들기

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

#### Undirected edge 만들기

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

#### 정점에서 나가는 에지를 검색하기

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  adjacencies[source] ?? []
}
```

#### 에지의 가중치 확인

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  edges(from: source)
     .first { $0.destination == destination }?
     .weight
}
```
![](https://hackmd.io/_uploads/H1z-vrVun.png)

### Adjacency matrix

![](https://hackmd.io/_uploads/SJyhZSVuh.png)

그래프의 노드를 2차원 Int형 배열로 만들어서, 이동할 수 있으면 1, 없으면 0으로 표기하는 것임

#### 구현
```swift
// AdjacencyMatrix.swift
public class AdjacencyMatrix<T>: Graph {

  private var vertices: [Vertex<T>] = []
  private var weights: [[Double?]] = []

  public init() {}
  // more to come ...
}
```
#### Creating a Vertex

```swift
// AdjacencyMatrix
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

1. 배열에 새 정점을 추가하세요.
2. 현재 정점 중 어느 것도 새로운 정점에 가장자리가 있지 않기 때문에 행렬의 모든 행에 nil 가중치를 추가하십시오

#### edge 만들기

```swift
public func addDirectedEdge(from source: Vertex<T>,
                            to destination: Vertex<T>, weight: Double?) {
  weights[source.index][destination.index] = weight
}
```

addUndirectedEdge와 add는 프로토콜 확장에 기본 구현이 있다.

#### 정점에서 나가는 에지를 검색하기

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

#### 에지의 가중치 확인

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  weights[source.index][destination.index]
}
```

![](https://hackmd.io/_uploads/SycfvrEd3.png)

![](https://hackmd.io/_uploads/B1DrvHVdn.png)
