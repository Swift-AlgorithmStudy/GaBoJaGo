소셜 네트워크는 전 세계의 저렴한 항공편을 예약하는 것과 어떤 공통점이 있을까? 이 두 실제 모델을 **그래프**로 나타낼 수 있다!

그래프는 물체 간의 관계를 캡쳐하는 데이터 구조이다. 그것은 가장자리와 연결된 정점들로 구성되어 있다.

아래 그래프의 원은 정점을 나타내며, 가장자리는 정점들을 연결하는 선이다.

![스크린샷 2023-06-22 오후 10.51.33.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2a16b20d-69b0-4b96-9f13-6a7cfb06c186/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.51.33.png)

## Weighted graphs

가중 그래프에서, 모든 가장자리에는 이 가장자리를 사용하는 비용을 나타내는 가중치가 있다. 이 가중치를 사용하면 두 정점 사이에서 가장 저렴하거나 가장 짧은 경로를 선택할 수 있습니다.

항공 산업을 예로 들어 다양한 비행 경로를 가진 네트워크를 생각해 보자:

![스크린샷 2023-06-22 오후 10.53.02.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/796eb374-4157-484d-a87f-e958aa6f9f93/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.53.02.png)

이 예에서, **정점은 주나 국가**를 나타내는 반면, **가장자리는 한 곳에서 다른 곳으로 가는 경로**를 나타낸다. 각 가장자리와 관련된 가중치는 그 두 지점 사이의 항공료를 나타낸다. 이 네트워크를 사용하면, 예산을 고려한 모든 디지털 노마드들을 위해 샌프란시스코에서 싱가포르까지 가장 저렴한 항공편을 결정할 수 있다!

### Directed graphs

가장자리에 가중치를 할당할 뿐만 아니라, 그래프는 방향을 가질 수도 있습니다.

방향 그래프는 가장자리가 한 방향으로만 이동할 수 있기 때문에 더 제한적이다. 아래 다이어그램은 방향 그래프를 나타낸다.

![스크린샷 2023-06-22 오후 10.58.17.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5b6e6284-7dd3-4790-82ef-fdfd053b077e/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.58.17.png)

이 다이어그램에서 많은 것을 알 수 있다:

- 홍콩에서 도쿄로 가는 비행기가 있다.
- 샌프란시스코에서 도쿄로 가는 직항편은 없다.
- 싱가포르와 도쿄 간 왕복 티켓을 살 수 있다.
- 도쿄에서 샌프란시스코로 가는 방법은 없다.

### Undirected graphs

무방향 그래프를 모든 모서리가 양방향인 방향 그래프로 생각할 수 있다.

방향이 없는 그래프에서:

- 연결된 두 정점은 앞뒤로 가는 엣지를 가지고 있다.
- 엣지의 가중치는 양방향에 적용된다.
    
    ![스크린샷 2023-06-22 오후 10.59.16.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1bc57a7c-7f11-40eb-a953-18b747d764fc/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.59.16.png)
    

## Common operations

그래프를 위한 프로토콜을 수립해보자.

Graph.swift라는 새 파일을 만들고 파일 안에 다음을 추가:

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

이 프로토콜은 그래프의 일반적인 작업을 설명한다:

- `createVertex(data:)`: 정점을 만들고 그래프에 추가
- `addDirectedEdge(from:to:weight:)`: 두 정점 사이에 지시된 엣지를 추가
- `addUndirectedEdge(between:and:weight:):` 두 정점 사이에 비방향(또는 양방향) 엣지를 추가
- `add(from:to:)`: EdgeType을 사용하여 두 정점 사이에 방향 또는 비방향 엣지를 추가
- `edges(from:)`: 특정 정점에서 나가는 엣지 목록을 반환
- `weight(from:to:)`: 두 정점 사이의 엣지의 가중치를 반환

다음 섹션에서, 두 가지 방법으로 이 프로토콜을 구현해보자:

- 인접 목록 사용하기
- 인접 행렬 사용하.

그렇게 하기 전에, 정점과 엣지를 나타내기 위해 먼저 유형을 구축해야 합니다.

## Defining a vertex

![스크린샷 2023-06-22 오후 11.06.07.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b7e44169-e489-45eb-8146-6277e563b2bd/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.06.07.png)

Vertex.swift라는 새 파일을 만들고 파일 안에 다음을 추가:

```swift
public struct Vertex<T> {

  public let index: Int
  public let data: T
}
```

여기서, 일반적인 정점 구조를 정의했다. 정점은 그래프 내에 고유한 인덱스를 가지고 있으며 데이터를 보유하고 있다.

Vertex를 사전의 키 유형으로 사용할 것이므로 Hashable을 준수해야 한다. Hashable에 대한 요구 사항을 구현하기 위해 다음 확장을 추가:

```swift
extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}
```

Hashable 프로토콜은 Equatable에서 상속되므로, 이 프로토콜의 요구 사항도 충족해야 한다. 컴파일러는 두 프로토콜 모두에 대한 적합성을 합성할 수 있으며, 이것이 위의 확장이 비어 있는 이유이다.

마지막으로, Vertex의 사용자 지정 문자열 표현을 제공하고 싶다면 바로 뒤에 다음을 추가

```swift
extension Vertex: CustomStringConvertible {

  public var description: String {
    "\(index): \(data)"
  }
}
```

## Defining ad edge

두 정점을 연결하려면, 그들 사이에 엣지가 있어야 한다!

![스크린샷 2023-06-22 오후 11.08.48.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/345c321e-8922-4314-8241-bd750addd6f6/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.08.48.png)

Edge.swift라는 새 파일을 만들고 파일 안에 다음을 추가:

```swift
public struct Edge<T> {

  public let source: Vertex<T>
  public let destination: Vertex<T>
  public let weight: Double?
}
```

엣지는 두 개의 정점을 연결하고 선택적인 가중치를 가지고 있다. 간단하쥬?

## Adjacency list

배우게 될 첫 번째 그래프 구현은 인접 목록을 사용한다. 그래프의 모든 정점에 대해, 그래프는 나가는 엣지 목록을 저장합니다.

다음 네트워크를 예로 들어 보자:

![스크린샷 2023-06-22 오후 11.15.52.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/955e4033-c62d-4e9c-9a83-03abc4f39c82/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.15.52.png)

아래의 인접 목록은 위에 묘사된 항공편 네트워크를 설명한다:

![스크린샷 2023-06-22 오후 11.16.11.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9c4a1071-1a3d-4a89-a870-a6012c6661b4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.16.11.png)

이 인접 목록에서 배울 수 있는 것이 많이 있다:

1. 싱가포르의 정점은 두 개의 나가는 가장자리를 가지고 있다. 싱가포르에서 도쿄와 홍콩으로 가는 비행기가 있다.
2. 디트로이트는 나가는 교통량이 가장 적다.
3. 도쿄는 가장 출항하는 항공편이 있는 가장 붐비는 공항이다.

다음 섹션에서는 딕셔너리 배열을 저장하여 인접 목록을 만들 것이다. 딕셔너리의 각 키는 정점이며, 모든 정점에서 딕셔너리은 해당 엣지에 대한 배열을 보유하고 있다.

## Implementation

AdjacencyList.swift라는 새 파일을 만들고 다음을 추가:

```swift
public class AdjacencyList<T: Hashable>: Graph {

  private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]

  public init() {}

  // more to come ...
}
```

여기서, 딕셔너리을 사용하여 엣지를 저장하는 AdjacencyList를 정의했다. 일반 매개 변수 T는 사전의 키로 사용되기 때문에 Hashable해야 한다.

이미 그래프 프로토콜을 채택했지만 여전히 요구 사항을 구현해야 한다. 다음 섹션에서 할 일이다.

## Creating a vertex

AdjacencyList에 다음 방법을 추가:

```swift
public func createVertex(data: T) -> Vertex<T> {
  let vertex = Vertex(index: adjacencies.count, data: data)
  adjacencies[vertex] = []
  return vertex
}
```

여기서, 새로운 정점을 만들고 그것을 반환한다. 인접 목록에, 이 새로운 정점에 대한 빈 엣지 배열을 저장한다.

### Creating a directed edge

방향이 있는 그래프와 방향이 없는 그래프가 있다는 것을 기억하기!

![스크린샷 2023-06-22 오후 11.23.13.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4c1da0b9-145c-46af-b23d-229bcf416239/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.23.13.png)

addDirectedEdge 요구 사항을 구현하는 것으로 시작해보자. 다음 방법을 추가:

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

이 방법은 새로운 엣지를 만들고 인접 목록에 저장한다.

### Creating an undirected edge

방금 두 정점 사이에 지시된 엣지를 추가하는 방법을 만들었다. 두 정점 사이에 방향이 없는엣지를 어떻게 만들 수 있을까요?

무방향 그래프는 양방향 그래프로 볼 수 있다는 것을 기억하자. 무방향 그래프의 모든 엣지는 양방향으로 횡단할 수 있다. 이것이 addDirectedEdge 위에 addUndirectedEdge를 구현하는 이유이다. 이 구현은 재사용할 수 있기 때문에, 그래프에 프로토콜 확장으로 추가할 것이다.

Graph.swift에서, 다음 확장자를 추가:

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

비방향 엣지를 추가하는 것은 두 개의 방향 엣지를 추가하는 것과 같다.

이제 addDirectedEdge와 addUndirectedEdge를 모두 구현했으므로, 이러한 방법 중 하나에 위임하여 add를 구현할 수 있다. 같은 프로토콜 확장에서, 다음을 추가:

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

추가 방법은 방향 또는 비방향 가장자리를 만드는 편리한 방법입니다. 프로토콜이 매우 강력해질 수 있다!

그래프 프로토콜을 채택한 사람은 누구나 addUndirectedEdge를 얻고 무료로 추가하기 위해 addDirectedEdge를 구현하기만 하면 된다!

### Retrieving the outgoing edges from a vertex

AdjacencyList.swift로 돌아가서, 다음 방법을 추가하여 그래프를 준수하는 작업을 계속해라:

```swift
public func edges(from source: Vertex<T>) -> [Edge<T>] {
  adjacencies[source] ?? []
}
```

이 코드는 간단한 구현이다: 소스 정점을 알 수 없는 경우 저장된 엣지 또는 빈 배열을 반환한다.

### Retrieving the weight of an edge

싱가포르에서 도쿄로 가는 비행기는 얼마인가?

![스크린샷 2023-06-22 오후 11.35.17.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/885aa822-0dae-4514-845b-55445c0cdae4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.35.17.png)

가장자리 바로 뒤에 다음을 추가`(from:)`:

```swift
public func weight(from source: Vertex<T>,
                   to destination: Vertex<T>) -> Double? {
  edges(from: source)
     .first { $0.destination == destination }?
     .weight
}
```

여기서, 출발지에서 목적지까지 첫 번째 엣지를 찾을 수 있습니다; 만약 있다면, 당신은 그 가중치를 돌려준다.

### Visualizing the adjacency list

그래프에 대한 좋은 설명을 인쇄할 수 있도록 AdjacencyList에 다음 확장자를 추가:

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

위의 코드에서 일어나는 일은 다음과 같다:

1. 인접의 모든 키-값 쌍을 반복한다.
2. 모든 정점에 대해, 당신은 모든 나가는 엣지를 반복하고 출력에 적절한 문자열을 추가한다.
3. 마지막으로, 모든 정점에 대해, 정점 자체와 나가는 엣지를 모두 출력한다.

마침내 첫 번째 그래프를 완성했다! 이제 네트워크를 구축하여 시도해 보장.

### Building a network

항공편 예시로 돌아가서 가격이 가중치인 항공편 네트워크를 구축해 보장.

![스크린샷 2023-06-22 오후 11.38.07.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d87d6d68-ac10-430d-bfb6-fa8c6c750f8f/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.38.07.png)

플레이그라운드에서 다음 코드를 추가해보자:

```swift
‘let graph = AdjacencyList<String>()

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

다음과 같은 결과를 얻어야 한다:

```swift
2: Hong Kong ---> [ 0: Singapore, 1: Tokyo, 4: San Francisco ]
4: San Francisco ---> [ 2: Hong Kong, 5: Washington DC, 7: Seattle, 6: Austin Texas ]
5: Washington DC ---> [ 1: Tokyo, 6: Austin Texas, 4: San Francisco, 7: Seattle ]
6: Austin Texas ---> [ 3: Detroit, 5: Washington DC, 4: San Francisco ]
7: Seattle ---> [ 5: Washington DC, 4: San Francisco ]
0: Singapore ---> [ 2: Hong Kong, 1: Tokyo ]
1: Tokyo ---> [ 0: Singapore, 2: Hong Kong, 3: Detroit, 5: Washington DC ]
3: Detroit ---> [ 1: Tokyo, 6: Austin Texas ]
```

이 출력은 인접 목록에 대한 시각적 설명을 보여준다. 어느 곳에서나 모든 아웃바운드 항공편을 볼 수 있다! 꽤 멋지쥬

또한 다음과 같은 다른 유용한 정보를 얻을 수 있다:

- 싱가폴에서 도쿄까지 가는 비행기는 얼마인가?

```swift
graph.weight(from: singapore, to: tokyo)
```

- 샌프란시스코에서 출발하는 모든 항공편은 무엇인가?

```swift
print("San Francisco Outgoing Flights:")
print("--------------------------------")
for edge in graph.edges(from: sanFrancisco) {
  print("from: \(edge.source) to: \(edge.destination)")
}
```

방금까지 인접 목록을 사용하여 그래프를 만들었고, 딕셔너리를 사용하여 모든 정점의 나가는 엣지를 저장했다. 정점과 엣지를 저장하는 방법에 대한 다른 접근 방식을 살펴보자.

## Adjacency matrix

인접 행렬은 그래프를 나타내기 위해 정사각형 행렬을 사용한다. 이 행렬은 행렬[행][열]의 값이 행과 열의 정점 사이의 가장자리의 가중치인 2차원 배열이다.

아래는 다른 장소로 여행하는 비행 네트워크를 묘사한 방향 그래프의 예시이다. 무게는 항공료 비용을 나타낸다.

![스크린샷 2023-06-22 오후 11.51.34.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f1c20152-7add-41ce-8afc-325e7a43768c/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.51.34.png)

다음 인접 매트릭스는 위에 묘사된 항공편의 네트워크를 설명한다.

존재하지 않는 가장자리의 무게는 0이다.

![스크린샷 2023-06-22 오후 11.53.34.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0811b306-7325-426d-bc1e-40131042a92a/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-22_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.53.34.png)

인접 목록에 비해, 이 매트릭스는 읽기가 조금 더 어렵다. 왼쪽의 정점 배열을 사용하면 행렬에서 많은 것을 배울 수 있다. 예를 들어:

- [0][1]은 300이므로, 싱가포르에서 홍콩으로 가는 항공편이 300달러이다.
- [2][1]은 0이므로, 도쿄에서 홍콩으로 가는 항공편이 없다.
- [1][2]는 250달러이므로, 홍콩에서 도쿄로 가는 비행기는 250달러이다.
- [2][2]는 0이므로, 도쿄에서 도쿄로 가는 항공편이 없다!

```swift
참고: 행렬 중간에 분홍색 선이 있다. 
행과 열이 같을 때, 이것은 정점과 그 자체 사이의 가장자리를 나타내며, 이는 허용되지 않는다.
```

## Implementation

AdjacencyMatrix.swift라는 새 파일을 만들고 다음을 추가:

```swift
public class AdjacencyMatrix<T>: Graph {

  private var vertices: [Vertex<T>] = []
  private var weights: [[Double?]] = []

  public init() {}

  // more to come ...
}
```

여기서, 엣지와 가중치를 추적하기 위해 정점 배열과 인접 행렬을 포함하는 AdjacencyMatrix를 정의했다.

이전과 마찬가지로, 이미 그래프에 대한 적합성을 선언했지만 여전히 요구 사항을 구현해야 한다.

### Creating a Vertex

AdjacencyMatrix에 다음 방법을 추가:

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

인접 행렬에 정점을 만들려면:

1. 배열에 새 정점을 추가한다.
2. 현재 정점 중 어느 것도 새로운 정점에 엣지가 있지 않기 때문에 행렬의 모든 행에 0 가중치를 추가한다.
    
    ![스크린샷 2023-06-23 오전 12.20.33.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fd7737a1-0360-451f-b726-6bfd24959f86/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-23_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_12.20.33.png)
    
    1. 행렬에 새 행을 추가하세요. 이 행은 새로운 정점의 나가는(outgoing) 가장자리를 유지한다.
    
    ![스크린샷 2023-06-23 오전 12.20.47.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f5c1b3ed-4fff-4859-b9bc-4dd20bfb6fd1/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-23_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_12.20.47.png)
    
    ### Creating edges
    
    가장자리를 만드는 것은 매트릭스를 채우는 것만큼 간단하다. 다음 방법을 추가:
    
    ```swift
    public func addDirectedEdge(from source: Vertex<T>,
                                to destination: Vertex<T>, weight: Double?) {
      weights[source.index][destination.index] = weight
    }
    ```
    
    addUndirectedEdge와 add는 프로토콜 확장에 기본 구현이 있다는 것을 기억하라, 그래서 이것이 해야 할 전부이다!
    
    ### Retrieving the outgoing edges from a vertex
    
    다음 방법을 추가:
    
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
    
    정점의 나가는 엣지를 검색하려면, 행렬에서 이 정점에 대한 행에서 nil이 아닌 가중치를 검색하라.
    
    모든 non-nil 무게는 나가는 엣지에 해당한다. 목적지는 가중치가 발견된 열에 해당하는 정점이다.
    
    ### Retrieving the weight of an edge
    
    엣지의 무게를 얻는 것은 매우 쉽다; 인접 행렬에서 값을 찾기만 하면 된다. 이 방법을 추가하:
    
    ```swift
    public func weight(from source: Vertex<T>,
                       to destination: Vertex<T>) -> Double? {
      weights[source.index][destination.index]
    }
    ```
    
    ### Visualize an adjacency matrix
    
    마지막으로, 그래프에 대한 멋지고 읽기 쉬운 설명을 출력할 수 있도록 다음 확장자를 추가하세요:
    
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
    
    단계는 다음과 같다:
    
    1. 먼저 정점 목록을 만든다.
    2. 그런 다음, 한 줄 한 줄로 가중치의 격자를 만든다.
    3. 마지막으로, 두 설명을 함께 결합하고 반환한다.
    
    ### Building a network
    
    당신은 AdjacencyList에서 같은 예를 재사용할 것이다:
    
    ![스크린샷 2023-06-23 오전 12.43.07.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c480b095-9392-493e-8811-61d60e4fc14f/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-23_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_12.43.07.png)
    
    메인 놀이터 페이지로 가서 바꿔, 이거를:
    
    ```swift
    let graph = AdjacencyList<String>()
    ```
    
    이걸로:
    
    ```swift
    let graph = AdjacencyMatrix<String>()
    ```
    
    AdjacencyMatrix와 AdjacencyList는 동일한 프로토콜 그래프를 준수하므로 나머지 코드는 동일하게 유지된다.
    
    다음과 같은 출력을 받아야 한다:
    
    ```swift
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
    
    시각적 아름다움의 관점에서, 인접 목록은 인접 매트릭스보다 따르고 추적하기가 훨씬 쉽다. 이 두 가지 접근 방식의 일반적인 작동을 분석하고, 어떻게 작동하는지 봐보자.
    
    ## Graph analysis
    
    이 차트는 인접 목록과 인접 행렬로 표시된 그래프의 다양한 작업 비용을 요약한다.
    
    ![스크린샷 2023-06-23 오전 12.48.33.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1bc0cadf-db34-4383-b15d-d57460bb5499/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-06-23_%E1%84%8B%E1%85%A9%E1%84%8C%E1%85%A5%E1%86%AB_12.48.33.png)
    
    V는 정점을 나타내고, E는 모서리를 나타낸다.
    
    인접 목록은 인접 행렬보다 저장 공간을 덜 차지한다. 인접 목록은 단순히 필요한 정점과 엣지의 수를 저장한다. 인접 행렬에 관해서는, 행과 열의 수가 정점의 수와 같다는 것을 기억하라. 이것은 O(V²)의 이차 공간 복잡성을 설명한다.
    
    정점을 추가하는 것은 인접 목록에서 효율적이다: 정점을 만들고 사전에서 키-값 쌍을 설정하기만 하면 된다. 그것은 O(1)로 생각된다. 인접 행렬에 정점을 추가할 때, 모든 행에 열을 추가하고 새 정점에 대한 새 행을 만들어야 한다. 이것은 적어도 O(V), 그리고 만약 매트릭스를 인접한 메모리 블록으로 나타내기로 선택한다면, 그것은 O(V²)가 될 수 있다.
    
    엣지를 추가하는 것은 둘 다 일정한 시간이기 때문에 두 데이터 구조 모두에서 효율적이다. 인접 목록은 나가는 엣지 배열에 추가됩니다. 인접 행렬은 단순히 2차원 배열의 값을 설정한다.
    
    인접 목록은 특정 엣지나 무게를 찾으려고 할 때 잃습니다. 인접 목록에서 엣지를 찾으려면, 나가는 엣지 리스트를 얻고 일치하는 목적지를 찾기 위해 모든 가장자리를 반복해야 한다. 이것은 O(V) 시간에 일어난다. 인접 행렬을 사용하면 가장자리나 가중치를 찾는 것은 2차원 배열에서 값을 검색하기 위한 일정한 시간 접근이다.
    
    그래프를 구성하려면 어떤 데이터 구조를 선택해야 할까?
    
    그래프에 가장자리가 거의 없다면, 희소 그래프로 간주되며, 인접 목록이 잘 맞을 것이다. 인접 매트릭스는 엣지가 많지 않기 때문에 많은 메모리가 낭비될 것이기 때문에 희소 그래프에 나쁜 선택이 될 것이다.
    
    그래프에 엣지가 많다면, 조밀도 그래프로 간주되며, 가중치와 엣지에 훨씬 더 빨리 접근할 수 있기 때문에 인접 매트릭스가 더 잘 맞을 것이다.
    
    ## 🔑 Key points
    
    - 정점과 가장자리를 통해 실제 관계를 나타낼 수 있다.
    - 정점을 물체로 생각하고 가장자리를 물체 사이의 관계로 생각해라.
    - 가중치가 있는 그래프는 가중치를 모든 가장자리와 연관시킨다.
    - 방향 그래프는 한 방향으로 가로지르는 모서리를 가지고 있다.
    - 무방향 그래프는 양방향을 가리키는 가장자리를 가지고 있다.
    - 인접 목록은 모든 정점에 대한 나가는 가장자리 목록을 저장한다.
    - 인접 행렬은 그래프를 나타내기 위해 정사각형 행렬을 사용한다.
    - 인접 목록은 일반적으로 그래프의 가장자리가 가장 적은 경우 희소 그래프에 좋다.
    - 인접 행렬은 일반적으로 그래프에 가장자리가 많을 때 고밀도 그래프에 적합하다.
