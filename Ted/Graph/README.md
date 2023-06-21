# Graphs

그래프는 물체 사이의 관계를 정의해주는 자료 구조입니다. 
그래프는 모서리(edge)로 연결된 꼭짓점(vertices)들로 만들어져있습니다.

<img width="234" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/98204ead-15c9-49a2-bb11-701c51a00797">

## Weighted graphs

가중치가 부여된 그래프에서 모든 엣지는 이 엣지를 사용하는 비용을 나타내는 가중치를 가집니다. 

이러한 가중치는 꼭짓점 사이에 있어서 가장 저렴하거나 가장 짧은 경로를 선택할 수 있도록 해줍니다.

항공의 예시를 통해 비행 경로를 다양하게 하는 네트워크의 예시를 생각해봅시다. 

<img width="447" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/f4f2402b-32e8-4fea-8f8e-b8fe476eda4b">

위의 예시에서 꼭짓점은 주나 나라를 나타내고, 모서리는 지점 간의 경로를 나타냅니다. 각각의 엣지에 있는 가중치는 두 지점 간의 항공료를 나타냅니다. 
이 네트워크를 통해 샌프란시스코에서 싱가폴로의 가장 싼 항공권을 결정할 수 있습니다.

## Directed graphs

그래프는 엣지의 가중치를 부여하는 것 뿐만 아니라 방향(directions)을 가질 수 있습니다.

유방향 그래프(directed graph)는 엣지가 한 방향의 횡단만을 허용할 수 있기 때문에 
횡단하는 데에 더욱 제한적입니다.

<img width="341" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3ed2c6c6-fb3d-491a-b0ad-22e5e403f6da">

위 다이어그램을 통해 많은 것을 알 수 있습니다.

- 홍콩에서 도쿄를 가는 비행편이 있습니다.
- 샌프란시스코에서 도쿄로 바로 가는 비행편은 없습니다.
- 싱가폴과 도쿄의 왕복 티켓을 살 수 있습니다.
- 도쿄에서 샌프란시스코로 갈 수 있는 수단은 없습니다.

## Undirected graphs

모든 엣지가 양방향인 유방향 그래프를 무방향 그래프(undirected graph)라고 볼 수 있습니다.

- 연결된 두 개의 꼭짓점은 앞뒤로 갈 수 있는 엣지를 가지고 있습니다.
- 엣지의 가중치는 두 방향에 적용됩니다.

<img width="379" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/be73aba3-d664-49ae-b747-d812d308cc15">

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

이 프로토콜은 그래프를 위한 연산에 대해 설명해줍니다.

- createVertex(data:) : 꼭짓점을 만들고 그래프에 추가합니다.
- addDirectedEdge(from:to:weight:) : 두 꼭짓점 간의 유방향 엣지를 추가합니다.
- addUndirectedEdge(between:and:weight:) : 두 꼭짓점 간의 무방향(양방향) 엣지를 추가합니다.
- add(from:to:) : 두 꼭짓점 간의 유방향이나 무방향 엣지를 추가하기 위해 EdgeType을 사용합니다.
- edges(from:) : 특정 꼭짓점에서 출발하는 엣지 목록을 반환합니다.
- weight(from:to:) : 두 꼭짓점 간의 엣지의 가중치를 반환합니다.

다가오는 섹션에서, 이 프로토콜을 두 가지의 방법으로 실행할 것입니다.

- 인접 리스트를 사용
- 인접 행렬을 사용

## Defining a vertex

<img width="324" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/0071f924-4283-4ae1-a7a4-7fd23b80f17f">

```swift
public struct Vertex<T> {

  public let index: Int
  public let data: T
}
```

여기서 제네릭 Vertex 구조체를 정의합니다. vertex는 고유한 인덱스를 가지고 있으며 데이터의 일부를 보유합니다.

Vertex를 딕셔너리의 키 타입으로 사용할 것이기 때문에, Hashable 타입을 준수해야 합니다. 
Hashable을 준수하기 위해 extension을 추가합니다.

```swift
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
```

Hashable 프로토콜은 Equatable로부터 상속을 받기 때문에, Equatable 프로토콜의 요구 사항 또한 충족시켜야 합니다. 
컴파일러는 두 프로토콜에 대한 일치를 합성할 수 있으며, 이것이 extension이 비어있는 이유입니다. 

마지막으로 Vertex의 표현해주는 자체 String을 제공할 것입니다. 

```swift
extension Vertex: CustomStringConvertible {

  public var description: String {
    "\(index): \(data)"
  }
}
```

## Defining an edge

두 꼭짓점을 연결하기 위해서는 그 사이에 엣지가 있어야 합니다.

<img width="435" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/0bb1e3f2-cf36-48ee-b838-7bf49dc44c72">

```swift
public struct Edge<T> {

  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}
```

엣지는 두 꼭짓점을 연결하고 옵셔널 가중치가 있습니다.

## Adjacency list

그래프를 실행하기 위해 처음으로 배울 것은 인접 리스트(adjacency list)입니다. 그래프의 모든 꼭짓점마다, 그래프는 지나가는 엣지들의 리스트를 저장합니다.

<img width="402" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3a63080c-5d85-4dd4-b159-f1dbe4c56305">

아래의 인접 리스트는 위의 항공편 네트워크를 설명해줍니다.

<img width="449" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/a37e9287-4cef-4309-9fbd-d597b1d6a6a4">

이 인접 리스트를 통해서 많은 것을 알 수 있습니다.

1. 싱가폴의 모서리는 두 개의 엣지를 지나갑니다. 싱가폴에서 도쿄와 홍콩으로 가는 비행편이 있습니다.
2. 디트로이트는 가장 적은 항공편을 가지고 있습니다.
3. 도쿄는 가장 많은 항공편을 가지고 있습니다.

다음 섹션에서는 배열의 딕셔너리를 저장함으로써 인접 리스트를 만드는 법을 배울 것입니다. 

딕셔너리에서의 각각의 키는 꼭짓점이고 모든 꼭짓점에서 딕셔너리는 상응하는 엣지의 배열을 가지고 있습니다. 

## Implementation

```swift
public class AdjacencyList<T: Hashable>: Graph {

  private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]

  public init() {}

  // more to come ...
}
```

엣지를 저장하기 위해 딕셔너리를 사용한 AdjacencyList를 정의하였습니다. 
제네릭 변수 T는 딕셔너리의 키이기 때문에 Hashable해야 합니다.

### Creating a vertex

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: adjacencies.count, data: data)
  adjacencies[vertex] = []
  return vertex
}
```

<img width="513" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/a8a879d6-6c64-4b05-9c73-a907fc5fd09a">

addDirectedEdge를 실행해봅시다.

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

이 메소드는 새로운 엣지를 만들고 인접 리스트에 저장합니다.

### Creating an undirected edge

두 꼭짓점 간의 방향성이 있는 엣지를 만들어주었습니다. 무방향성의 엣지는 어떻게 만들면 될까요?

무방향 그래프는 양방향 그래프처럼 보일 수 있음을 명심해야 합니다. 무방향 그래프의 모든 엣지는 모든 방향에서 횡단할 수 있습니다. 이 때문에 addDirectedEdge 위에 addUndirectedEdge를 실행합니다. 

이 식은 재사용할 수 있기 때문에, Graph의 프로토콜 extension으로 추가할 수 있습니다.

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

무방향 엣지를 추가하는 것은 두 개의 유방향 엣지를 추가하는 것과 같습니다.

addDirectedEdge와 addUndirectedEdge를 모두 구현했으므로 이 메소드 중 하나에 위임하여 add를 구현할 수 있습니다. 

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

add 메소드는 유방향이나 무방향 엣지를 편리하게 만들 수 있도록 도와주는 메소드입니다. 

Graph 프로토콜을 채택한 사람은 add와 addUndirectedEdge를 불러오기 위해서 addDirectedEdge을 실행하면 됩니다.

### Retrieving the outgoing edges from a vertex

뒤에 나타나는 메소드를 추가하여 Graph를 추가적으로 작업합니다.

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  adjacencies[source] ?? []
}
```

이 코드는 실행하기에 직관적입니다. 만약 source vertex를 모른다면 저장된 엣지나 비어있는 배열을 반환합니다.

### Retrieving the weight of an edge

싱가폴에서 도쿄로 가는데엔 얼마나 비용이 들까요?

<img width="230" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/52a1b90f-9f5e-4d2f-af39-4e6bd660b3a8">

edges(from:) 바로 다음에 추가해줍니다.

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  edges(from: source)
     .first { $0.destination == destination }?
     .weight
}
```

위 식에서 source에서 destination으로 가는 첫 번째 엣지를 볼 수 있습니다. 
만약 하나만 있다면, 그것의 가중치를 반환합니다.

### Visualizing the adjacency list

그래프에 대한 설명을 프린트할 수 있도록 AdjacencyList에 extension을 추가해줍니다.

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

1. adjacencies에 있는 모든 키-값 짝을 순회합니다.
2. 모든 꼭짓점마다, 지나간 모든 엣지를 순회하고 output에 적잘한 문자열을 추가합니다.
3. 마지막으로, 모든 꼭짓점마다 꼭짓점과 지나간 엣지들을 프린트합니다.

### Building a network

<img width="491" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/2778e77f-3907-455e-b6aa-7cbe209651ce">

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

2: Hong Kong ---> [ 0: Singapore, 1: Tokyo, 4: San Francisco ]
4: San Francisco ---> [ 2: Hong Kong, 5: Washington DC, 7: Seattle, 6: Austin Texas ]
5: Washington DC ---> [ 1: Tokyo, 6: Austin Texas, 4: San Francisco, 7: Seattle ]
6: Austin Texas ---> [ 3: Detroit, 5: Washington DC, 4: San Francisco ]
7: Seattle ---> [ 5: Washington DC, 4: San Francisco ]
0: Singapore ---> [ 2: Hong Kong, 1: Tokyo ]
1: Tokyo ---> [ 0: Singapore, 2: Hong Kong, 3: Detroit, 5: Washington DC ]
3: Detroit ---> [ 1: Tokyo, 6: Austin Texas ]
```

결과는 인접 리스트를 시각적으로 보여줍니다. 
모든 방향에 대한 항공편을 볼 수 있습니다.

다른 유용한 정보를 얻을 수도 있습니다.

- 싱가폴에서 도쿄로 가는 항공편의 값은 얼마인가요?

```swift
graph.weight(from: singapore, to: tokyo)
```

- 샌프란시스코에서 출발하는 항공편은 무엇이 있나요?

```swift
print("San Francisco Outgoing Flights:")
print("--------------------------------")
for edge in graph.edges(from: sanFrancisco) {
  print("from: \(edge.source) to: \(edge.destination)")
}
```

딕셔너리를 사용하여 모든 꼭짓점에 대한 엣지들을 저장하는 인접 리스트를 사용하여 그래프를 만들었습니다.

이젠 꼭짓점과 엣지를 저장하는 다른 방법에 대해 살펴봅시다.

## Adjacency matrix

인접 행렬(adjacency matrix)은 그래프를 나타내기 위해 정방행렬(square matrix)을 사용합니다. 
이 행렬은 matrix[row][column]의 값이 row와 column에 있는 꼭짓점 사이에 있는 엣지의 가중치 값입니다.

아래는 다음 장소로 이동하는 비행 네트워크를 나타내는 방향 그래프의 예시입니다. 가중치는 항공료를 나타냅니다.

<img width="389" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3d4ff39a-f50a-42b4-8571-86eb4078d281">

엣지가 없는 것은 0의 가중치를 가집니다.

<img width="489" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/074202d7-ecf3-4da2-8e39-4ee5fef546c1">

인접 리스트와 비교했을 때, 이 행렬은 읽기에는 조금 더 어렵습니다. 
왼쪽에 배열의 꼭짓점을 사용함으로써, 행렬에 대해 많은 것을 알 수 있습니다.

- [0][1]은 300으로, 싱가폴에서 홍콩으로 가는 표는 300달러입니다.
- [2][1]은 0으로, 도쿄에서 홍콩으로 가는 비행편은 없습니다.
- [1][2]는 250으로, 홍콩에서 도쿄로 가는 표는 250달렁ㅂ니다.
- [2][2]는 0으로, 도쿄에서 도쿄로 가는 비행편은 없습니다.

Note: 행렬의 중앙에 빨간줄이 있습니다. 만약 열과 행의 개수가 같다면 꼭짓점 자신들 간의 엣지를 나타내기 때문에 허용되지 않습니다.

## Implementation

```swift
public class AdjacencyMatrix<T>: Graph {

  private var vertices: [Vertex<T>] = []
  private var weights: [[Double?]] = []

  public init() {}

  // more to come ...
}
```

엣지와 가중치를 추적하기 위해 모서리에 대한 배열과 인접 행렬을 포함하는 AdjacencyMatrix를 정의하였습니다. 

이전에서와 같이, 이미 Graph에 대한 준수를 선언했지만 여전히 요구 사항을 구현해야 합니다.

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

인접 행렬에 꼭짓점을 추가하기 위해서, 

1. 배열에 새로운 꼭짓점을 추가합니다.
2. 현재 꼭짓점 중 새로운 꼭짓점에 엣지가 있는 행이 없으므로 행렬의 모든 행에 가중치를 nil로 추가합니다.

<img width="486" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/b96e115c-9565-44ca-8246-e4d44a0e1d87">

1. 행렬에 새로운 행을 추가합니다. 이 행은 새 꼭짓점을 지나가는 엣지를 포함합니다.

<img width="481" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/051fc7f2-fe05-4b3a-a25d-4f1f96208720">

### Creating edges

엣지를 생성하는 것은 행렬을 채우는 것처럼 간단합니다. 

```swift
public func addDirectedEdge(from source: Vertex<T>,
                            to destination: Vertex<T>, weight: Double?) {
  weights[source.index][destination.index] = weight
}
```

addUndirectedEdge와 add는 프로토콜 extension에 기본적으로 있기 때문에 위의 식만 추가해주면 됩니다.

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

엣지에 대해 지나가는 꼭짓점을 얻기 위해서, 
행렬에서 이 꼭짓점에 대한 행을 검색하여 0이 아닌 가중치를 찾습니다.

nil이 아닌 모든 가중치는 지나가는 엣지와 일치합니다. 목적지는 가중치가 발견된 열에 해당하는 꼭짓점입니다.

### Retrieving the weight of an edge

인접 행렬의 값을 확인하면 엣지의 가중치를 얻을 수 있기 때문에 매우 쉽습니다.

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  weights[source.index][destination.index]
}
```

### Visualize an adjacency matrix

마지막으로 extension을 추가함으로써 그래프에 대한 설명을 프린트할 수 있습니다. 

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

1. 꼭짓점에 대한 리스트를 생성합니다.
2. 그리고, 한 줄 한 줄 가중치에 대한 격자를 만듭니다.
3. 마지막으로, 설명을 추가하여 반환합니다.

### Building a network

<img width="545" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/79e81773-7903-4a0d-b457-3d34fa4f232c">

```swift
let graph = AdjacencyList<String>()

let graph = AdjacencyMatrix<String>()

0: Singapore
1: Tokyo
2: Hong Kong
3: Detroit
4: San Francisco
5: Washington DC
6: Austin Texas
7: Seattle
ø   500.0 300.0 ø   ø   ø   ø   ø   
500.0 ø   250.0 450.0 ø   300.0 ø   ø   
300.0 250.0 ø   ø   600.0 ø   ø   ø   
ø   450.0 ø   ø   ø   ø   50.0  ø   
ø   ø   600.0 ø   ø   337.0 297.0 218.0
ø   300.0 ø   ø   337.0 ø   292.0 277.0
ø   ø   ø   50.0  297.0 292.0 ø   ø   
ø   ø   ø   ø   218.0 277.0 ø   ø   
San Francisco Outgoing Flights:
--------------------------------
from: 4: San Francisco to: 2: Hong Kong
from: 4: San Francisco to: 5: Washington DC
from: 4: San Francisco to: 6: Austin Texas
from: 4: San Francisco to: 7: Seattle
```

시각적으로 봤을 때, 인접 리스트가 인접행렬보다 보기 쉽습니다. 이제 두 가지의 연산 과정을 분석하고 어떻게 작동하는 지 확인해봅시다.

## Graph analysis

<img width="550" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/4ce3b93d-9f1b-43f1-a9d2-32acb4e42f07">

인접 리스트는 인접 행렬보다 적은 공간을 차지합니다. 인접 리스트는 꼭짓점과 엣지가 필요한 만큼만 저장합니다. 
인접 행렬의 경우 행과 열의 수가 꼭짓점의 수와 같다는 것을 기억하십시오. 이것은 O(V^2)의 2차 공간 복잡도를 설명합니다. 

꼭짓점을 추가하는 것은 인접 리스트에서 효율적입니다. 꼭짓점을 생성하고 딕셔너리에 키-값 쌍을 지정합니다. 
이는 평균 O(1)이 나옵니다. 꼭짓점을 인접 행렬에 추가할 때는 모든 행에 열을 추가하고 새로운 꼭짓점을 위해 새로운 행을 생성해야 합니다. 이는 적어도 O(V)이고, 연속적인 메모리 공간에 나타내도록 한다면 O(V^2)이 될 수 있습니다. 

엣지를 추가하는 것은 두 자료 구조에서 효율적인데, 이는 상수 시간을 갖기 때문입니다. 인접 리스트는 지나가는 엣지들을 배열에 추가합니다. 인접 행렬은 그저 2차원 배열의 값을 설정합니다. 

인접 리스트는 특정 엣지나 가중치를 찾을 때 손해를 봅니다. 인접 리스트에서 엣지를 찾기 위해, 지나가는 엣지의 목록을 가져와 모든 엣지를 순환하여 일치하는 대상을 찾아야 합니다. 이는 O(V) 시간 내에 발생합니다. 인접 행렬을 사용하는 경우 엣지 또는 가중치를 찾는 것은 2차원 배열에서 값을 검색하기 위해 상수 시간이 소모됩니다.

그래프를 만들기 위해 어떠한 자료구조를 선택하시겠습니까?

만약 그래프에 엣지가 적게 있다면, sparse graph라고 하고, 인접 리스트가 적합할 것입니다. 엣지가 많이 없다면 인접 행렬은 메모리 소모가 많이 일어날 것이기 때문에 sparse graph에는 나쁜 선택일 것입니다.

만약 엣지가 많다면, dense graph라고 하고. 가중치와 엣지에 더 빠르게 접근할 수 있기 때문에 인접 행렬이 적합할 것입니다.

## Key points

- 꼭짓점과 엣지를 통해 실세계의 관계를 표현할 수 있습니다.
- 꼭짓점을 물체라고 생각하고 엣지를 물체 간의 관계라고 생각하십시오.
- 가중치 그래프는 모든 엣지에 가중치가 있는 것입니다.
- 유방향 그래프는 한 방향으로 횡단하는 엣지를 가지고 있습니다.
- 무방향 그래픈느 두 방향으로 갈 수 있는 엣지입니다.
- 인접 리스트는 모든 꼭짓점마다 지나가는 엣지의 리스트를 저장합니다.
- 인접 행렬은 그래프를 나타내기 위해 정방 행렬을 사용합니다.
- 인접 리스트는 엣지가 적은 있는 sparse graph에서 일반적으로 유용합니다.
- 인접 행렬은 엣지가 많은 dense graph에서 일반적으로 유용합니다.
