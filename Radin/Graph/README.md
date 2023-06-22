# Chap17. Graph

**Q. 소셜 네트워크는 전 세계의 저렴한 항공편을 예약하는 것과 어떤 공통점이 있을까요?** 

이 두 실제 모델을 그래프로 나타낼 수 있습니다!

**Q. 그래프란?**

인터넷의 웹 페이지, 새의 이동 패턴, 원자 핵의 양성자 등 다양한 것을 모델링할 수 있는 도구 데이터 구조이다.

그래프는 물체 간의 관계를 포착하는 데이터 구조로 가장자리로 연결된 정점으로 구성되어 있다.

아래 그래프의 원은 정점을 나타내며, 가장자리는 그것들을 연결하는 선이다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/23d3975e-5d84-49e5-8696-d3e346e806da)

## 1. Weighted graphs 가중 그래프

가중 그래프에서, 모든 가장자리에는 이 가장자리를 사용하는 비용을 나타내는 가중치가 있다. 이 가중치를 사용하면 두 정점 사이에서 가장 저렴하거나 가장 짧은 경로를 선택할 수 있습니다.

### 1) Directed graphs 방향 그래프

가장자리에 가중치를 할당할 뿐만 아니라, 당신의 그래프는 방향을 가질 수도 있습니다. 방향 그래프는 가장자리가 한 방향으로만 횡단을 허용할 수 있기 때문에 횡단에 더 제한적이다. 아래 다이어그램은 방향 그래프를 나타낸다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/35f4c875-aadc-4865-affb-16e87a1c5df0)

당신은 이 다이어그램에서 많은 것을 알 수 있습니다:

- 홍콩에서 도쿄로 가는 비행기가 있다.
- 샌프란시스코에서 도쿄로 가는 직항편은 없습니다.
- 싱가포르와 도쿄 간 왕복 티켓을 살 수 있습니다.
- 도쿄에서 샌프란시스코로 가는 방법은 없다.

### 2) Undirected graphs 무방향 그래프

무방향 그래프를 모든 모서리가 양방향인 방향 그래프로 생각할 수 있습니다.

방향이 없는 그래프에서:

- 연결된 두 정점은 앞뒤로 가는 가장자리를 가지고 있다.
- 가장자리의 무게는 양방향에 적용된다.

### 3) Common operations

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

이 프로토콜은 그래프의 일반적인 작업을 설명합니다:

- createVertex(data:): 정점을 만들고 그래프에 추가합니다.
- addDirectedEdge(from:to:weight:): 두 정점 사이에 지시된 가장자리를 추가합니다.
- addUndirectedEdge(between:and:weight:): 두 정점 사이에 비방향(또는 양방향) 가장자리를 추가합니다.
- add(from:to:): EdgeType을 사용하여 두 정점 사이에 방향 또는 비방향 가장자리를 추가합니다.
- edges(from:): 특정 정점에서 나가는 가장자리 목록을 반환합니다.
- weight(from:to:): 두 정점 사이의 가장자리의 무게를 반환합니다.

다음 섹션에서, 당신은 두 가지 방법으로 이 프로토콜을 구현할 것입니다:

- 인접 목록 사용하기.
- 인접 행렬 사용하기.

그렇게 하기 전에, 정점과 가장자리를 나타내기 위해 먼저 타입을 구축해야 합니다.

## 2. Defining a vertex 정점 정의하기

```swift
// Vertex.swift
public struct Vertex<T> {
  public let index: Int
  public let data: T
}
```

 일반적인 정점 구조를 정의했습니다. 정점은 그래프 내에 고유한 인덱스를 가졌으며 데이터를 보유하고 있다.

Vertex를 딕셔너리의 키 타입으로 사용할 것이므로 Hashable을 준수해야 합니다. 
Hashable에 대한 요구 사항을 구현하기 위해 다음 Extension을 추가하세요:

```swift
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
```

Hashable 프로토콜은 Equatable에서 상속되므로, 이 프로토콜의 요구 사항도 충족해야 합니다. 
컴파일러는 두 프로토콜 모두에 대한 적합성을 합성할 수 있으며, 이는 위의 Extension이 비어 있는 이유입니다.

## 3. Defining an edge 가장자리 정의하기

두 정점을 연결하려면, 그들 사이에 가장자리(엣지)가 있어야 합니다!

```swift
// Edge.swift
public struct Edge<T> {
  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}
```

가장자리는 두 개의 정점을 연결하고 가중치를 옵셔널로 가지고 있다. 

## 4. Adjacency list 인접 목록

당신이 배우게 될 첫 번째 그래프 구현은 인접 목록을 사용합니다. 그래프의 모든 정점에 대해, 그래프는 나가는 가장자리 목록을 저장합니다.

다음 네트워크를 예로 들어 보세요:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/ef508639-4b3f-49f7-9aa2-caf74a7f64ad)

아래의 인접 목록은 위에 묘사된 항공편 네트워크를 설명합니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/ca3f0b28-0f7d-476f-b776-0dc39fd24135)

이 인접 목록에서 배울 수 있는 것이 많이 있습니다:

1. 싱가포르의 정점은 두 개의 나가는 가장자리를 가지고 있다. 싱가포르에서 도쿄와 홍콩으로 가는 비행기가 있다.
2. 디트로이트는 나가는 교통량이 가장 적다.
3. 도쿄는 가장 출항하는 항공편이 있는 가장 붐비는 공항이다.

다음에서는 배열 딕셔너리을 저장하여 인접 목록을 만들 것입니다. 딕셔너리의 각 키는 정점이며, 모든 정점에서 딕셔너리는 해당 가장자리 배열을 보유하고 있다.

### 구현

```swift
// AdjacencyList.swift
public class AdjacencyList<T: Hashable>: Graph {
  private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
  public init() {}
  // more to come ...
}
```

여기서, 당신은 딕셔너리를 사용하여 가장자리를 저장하는 AdjacencyList를 정의했습니다. 일반 매개 변수 T는 딕셔너리의 키로 사용되기 때문에 Hashable이어야 합니다.

이제 그래프 프로토콜의 요구 사항을 구현해볼까요?

### 정점 만들기

AdjacencyList에 다음 메서드를 추가하세요:

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: adjacencies.count, data: data)
  adjacencies[vertex] = []
  return vertex
}
```

새로운 정점을 만들고 그것을 반환합니다. 

인접 목록에 새로운 정점에 대한 빈 가장자리 배열을 저장합니다.

### 방향 가장자리 만들기 Directed edge

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/249a1736-7a44-46b6-8077-1c4cb78d4f16)

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

이 방법은 새로운 가장자리를 만들고 인접 목록에 저장합니다.

### 방향이 없는 가장자리 만들기 Undirected edge

무방향 그래프는 양방향 그래프로 볼 수 있다는 것을 기억하세요. 무방향 그래프의 모든 가장자리는 양방향으로 횡단할 수 있다. 이것이 당신이 addDirectedEdge 위에 addUndirectedEdge를 구현하는 이유입니다. 이 구현은 재사용할 수 있기 때문에, 그래프에 프로토콜 확장으로 추가할 것입니다.

Graph.swift에서, 다음 extension을 추가하세요:

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

비방향 가장자리를 추가하는 것은 두 개의 방향 가장자리를 추가하는 것과 같다.

이제 addDirectedEdge와 addUndirectedEdge를 모두 구현했으므로, 이러한 방법 중 하나에 위임하여 add를 구현할 수 있습니다. 같은 프로토콜 확장에서, 다음을 추가하세요:

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

add 메서드는 방향 또는 비방향 가장자리를 만드는 편리한 방법입니다. 

### 정점에서 나가는 가장자리를 검색하기

AdjacencyList.swift로 돌아가서, 다음 메서드를 추가하여 그래프 프로토콜을 준수하는 작업을 계속하세요:

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  adjacencies[source] ?? []
}
```

정점을 알 수 없는 경우 빈 배열을 반환합니다.

### 가장자리의 무게를 되찾기

싱가포르에서 도쿄로 가는 비행기는 얼마인가요?

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/08db2b2e-11a1-4dcd-a026-603d0b857e04)

Add the following right after edges(from:):

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  edges(from: source)
     .first { $0.destination == destination }?
     .weight
}
```

여기서, 소스에서 목적지까지 첫 번째 가장자리를 찾을 수 있습니다. 만약 있다면, 당신은 그 무게를 돌려줍니다.

정점과 모서리를 저장하는 방법에 대한 다른 접근 방식을 살펴봅시다.

## 5. 인접 행렬

인접 행렬은 그래프를 나타내기 위해 정사각형 행렬을 사용한다. 이 행렬은 행렬[행][열]의 값이 행과 열의 정점 사이의 가장자리의 가중치인 2차원 배열이다.

아래는 다른 장소로 여행하는 비행 네트워크를 묘사한 방향 그래프의 예입니다. 무게는 항공료 비용을 나타낸다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d0851888-dc52-49e6-b476-80872fb9f074)

다음 인접 매트릭스는 위에 묘사된 항공편의 네트워크를 설명합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/2f3cec77-7d39-4ae0-90a1-311ca066c2ae)

인접 목록에 비해, 이 매트릭스는 읽기가 조금 더 어렵다. 왼쪽의 정점 배열을 사용하면 행렬에서 많은 것을 배울 수 있습니다. 예를 들어:

- [0][1]은 300이므로, 싱가포르에서 홍콩으로 가는 항공편이 300달러입니다.
- [2][1]은 0이므로, 도쿄에서 홍콩으로 가는 항공편이 없습니다.
- [1][2]는 250달러이므로, 홍콩에서 도쿄로 가는 비행기는 250달러이다.
- [2][2]는 0이므로, 도쿄에서 도쿄로 가는 항공편이 없습니다!

<aside>
💡 참고: 행렬 중간에 분홍색 선이 있습니다. 행과 열이 같을 때, 이것은 정점과 그 자체 사이의 가장자리를 나타내며, 이는 허용되지 않습니다.

</aside>

### 구현

```swift
// AdjacencyMatrix.swift
public class AdjacencyMatrix<T>: Graph {

  private var vertices: [Vertex<T>] = []
  private var weights: [[Double?]] = []

  public init() {}
  // more to come ...
}
```

이제 그래프 프로토콜의 요구 사항을 구현해야 합니다.

### 정점 만들기Creating a Vertex

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

인접 행렬에 정점을 만들려면:

1. 배열에 새 정점을 추가하세요.
2. 현재 정점 중 어느 것도 새로운 정점에 가장자리가 있지 않기 때문에 행렬의 모든 행에 nil 가중치를 추가하십시오.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/4f19e768-e586-4605-85dd-f3771e8a63a3)

1. 매트릭스에 새 행을 추가하세요. 이 행은 새로운 정점의 나가는 가장자리를 유지한다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/7878a93d-3931-4b8d-b38e-935e26b12413)

### 가장자리 만들기

가장자리를 만드는 것은 매트릭스를 채우는 것만큼 간단하다. 다음 방법을 추가하세요:

```swift
public func addDirectedEdge(from source: Vertex<T>,
                            to destination: Vertex<T>, weight: Double?) {
  weights[source.index][destination.index] = weight
}
```

addUndirectedEdge와 add는 프로토콜 확장에 기본 구현이 있다는 것을 기억하세요, 그래서 이것이 당신이 해야 할 전부입니다!

### 정점에서 나가는 가장자리를 검색하기

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

정점의 나가는 가장자리를 검색하려면, 행렬에서 이 정점에 대한 행에서 nil이 아닌 가중치를 검색하십시오.

모든 non-nil 무게는 나가는 가장자리에 해당한다. 목적지는 무게가 발견된 열에 해당하는 정점이다.

### 가장자리의 무게를 되찾기

가장자리의 무게를 얻는 것은 매우 쉽습니다; 인접 행렬에서 값을 찾기만 하면 됩니다. 이 메서드를 추가하세요:

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  weights[source.index][destination.index]
}
```

### 인접 행렬을 시각화하세요.

마지막으로, 그래프에 대한 멋지고 읽기 쉬운 설명을 인쇄할 수 있도록 다음 확장자를 추가하세요:

```swift
extension AdjacencyMatrix: CustomStringConvertible {

  public var description: String {
    // 1 먼저 정점 목록을 만듭니다.
    let verticesDescription = vertices.map { "\($0)" }
                                      .joined(separator: "\n")
    // 2 그런 다음, 한 줄 한 줄로 가중치의 격자를 만듭니다.
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
    // 3 마지막으로, 두 설명을 함께 결합하고 반환합니다.
    return "\(verticesDescription)\n\n\(edgesDescription)"
  }
}
```

## 6. 그래프 분석

이 차트는 인접 목록과 인접 행렬로 표시된 그래프의 다양한 작업 비용을 요약합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/c5a4ace4-4501-47f4-b647-014feb1a0708)

V는 정점을 나타내고, E는 모서리를 나타낸다.

인접 목록은 인접 행렬보다 저장 공간을 덜 차지한다. 인접 목록은 단순히 필요한 정점과 가장자리의 수를 저장한다. 인접 행렬에 관해서는, 행과 열의 수가 정점의 수와 같다는 것을 기억하세요. 이것은 O(V²)의 이차 공간 복잡성을 설명한다.

정점을 추가하는 것은 인접 목록에서 효율적입니다: 정점을 만들고 사전에서 키-값 쌍을 설정하기만 하면 됩니다. 그것은 O(1)로 상각된다. 인접 행렬에 정점을 추가할 때, 모든 행에 열을 추가하고 새 정점에 대한 새 행을 만들어야 합니다. 이것은 적어도 O(V), 그리고 만약 당신이 당신의 매트릭스를 인접한 메모리 블록으로 나타내기로 선택한다면, 그것은 O(V²)가 될 수 있습니다.

엣지를 추가하는 것은 둘 다 일정한 시간이기 때문에 두 데이터 구조 모두에서 효율적이다. 인접 목록은 나가는 가장자리 배열에 추가됩니다. 인접 행렬은 단순히 2차원 배열의 값을 설정합니다.

인접 목록은 특정 가장자리나 무게를 찾으려고 할 때 잃습니다. 인접 목록에서 가장자리를 찾으려면, 나가는 가장자리 목록을 얻고 일치하는 목적지를 찾기 위해 모든 가장자리를 반복해야 합니다. 이것은 O(V) 시간에 일어난다. 인접 행렬을 사용하면 가장자리나 가중치를 찾는 것은 2차원 배열에서 값을 검색하기 위한 일정한 시간 접근이다.

그래프를 구성하려면 어떤 데이터 구조를 선택해야 하나요?

**그래프에 가장자리가 거의 없다면**, 희소 그래프로 간주되며, **인접 목록**이 잘 맞을 것입니다. 인접 매트릭스는 가장자리가 많지 않기 때문에 많은 메모리가 낭비될 것이기 때문에 희소 그래프에 나쁜 선택이 될 것이다.

**그래프에 모서리가 많다면**, 조밀도 그래프로 간주되며, 가중치와 모서리에 훨씬 더 빨리 접근할 수 있기 때문에 **인접 행렬**이 더 잘 맞을 것입니다.

## 🗝️ Key points

- 정점과 가장자리를 통해 실제 관계를 나타낼 수 있습니다.
- 정점을 물체로 생각하고 가장자리를 물체 사이의 관계로 생각하세요.
- 가중치가 있는 그래프는 가중치를 모든 가장자리와 연관시킨다.
- 방향 그래프는 한 방향으로 가로지르는 모서리를 가지고 있다.
- 무방향 그래프는 양방향을 가리키는 가장자리를 가지고 있다.
- 인접 목록은 모든 정점에 대한 나가는 가장자리 목록을 저장합니다.
- 인접 행렬은 그래프를 나타내기 위해 정사각형 행렬을 사용한다.
- 인접 목록은 일반적으로 그래프의 가장자리가 가장 적은 경우 희소 그래프에 좋습니다.
- 인접 행렬은 일반적으로 그래프에 가장자리가 많을 때 고밀도 그래프에 적합합니다.
