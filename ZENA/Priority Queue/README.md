# Priority Queue

Queue는 단순히 선입선출(FIFO) 순서를 사용하여 요소의 순서를 유지하는 리스트이다. 우선 순위 큐는 FIFO 순서를 사용하는 대신, 요소가 우선 순위 순서로 dequeue되는 대기열의 또 다른 버전이다. 예를 들어, 우선 순위 큐는 다음과 같다:

1. front의 요소가 항상 가장 큰 **Max-priority**
2. front의 요소가 항상 가장 작은 **Min-priority**

우선 순위 큐는 요소 목록이 주어진 최대 또는 최소 값을 식별할 때 특히 유용하다. 이번 챕터에서는 우선 순위 큐의 이점을 배우고 이전 챕터의 기존 큐와 힙 데이터 구조를 활용하여 구축할 것이다.

## Applications

우선 순위 큐의 몇 가지 실용적인 응용 프로그램은 다음과 같다:

- 최소 비용을 계산하기 위해 우선 순위 대기열을 사용하는 **다익스트라 알고리즘**
- 우선 순위 큐를 사용해, 가장 짧은 길이의 경로를 생성하는 탐험되지 않은 루트를 찾는 **A* pathfinding 알고리즘**
- 우선 순위 큐를 사용하여 구현할 수 있는 **힙 정렬**
- 압축 트리를 만드는 **허프만 코딩**. min-priority queue는 아직 가장 작은 빈도를 가진 두 개의 노드를 반복적으로 찾는 데 사용된다.

이들은 사용 사례 중 일부일 뿐이지만, 우선 순위 큐에는 더 많은 응용 방식도 있다.

## Common operations

8장, Queue에서, 큐에 대한 다음 프로토콜을 설정했다:

```swift
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
```

우선 순위 큐는 일반 큐와 동일한 작업을 수행하므로 구현만 다를 수 있다.

우선 순위 큐는 `Queue` 프로토콜을 준수하고 일반적인 작업을 구현할 것이다:

- **enqueue**: 요소를 큐에 삽입한다. 작업이 성공하면 true를 반환한다.
- **dequeue**: 우선 순위가 가장 높은 요소를 제거하고 반환한다. 큐가 비어 있으면 `nil`을 반환한다.
- **isEmpty**: 큐가 비어 있는지 확인한다.
- **peek**: 제거하지 않고 우선 순위가 가장 높은 요소를 반환한다. 큐가 비어 있으면 `nil`을 반환한다.

우선 순위 큐를 구현하는 다양한 방법을 살펴보자.

## Implementation

다음과 같은 방법으로 우선 순위 대기열을 만들 수 있다:

1. **Sorted array**: 이것은 `O(1)` 시간에 요소의 최대 또는 최소 값을 얻는 데 유용하다. 그러나, 삽입은 느리고 순서대로 삽입해야 하기 때문에 `O(n)`의 시간복잡도가 필요하다.
2. **Balanced binary search tree**: 이는 `O(log n)` 시간에 최소값과 최대값을 모두 얻는 이중 우선 순위 큐를 만드는 데 유용하다. 삽입은 `O(log n)`인 점에서도 sorted array보다 낫다.
3. **Heap**: 이것이 우선 순위 큐 대한 자연스러운 선택이다. 힙은 부분적으로만 정렬해야 하기 때문에 정렬된 배열보다 더 효율적이다. 모든 힙 작업은 최소 우선 순위 힙에서 최소 값을 추출하는 것을 제외하고 `O(log n)`이다.

다음으로, 힙을 사용해 우선 순위 큐를 만드는 방법을 살펴보자.

1. **Heap.swift**: 우선 순위 대기열을 구현하는 데 사용할 힙 데이터 구조(이전 장에서)
2. **Queue.swift**: 대기열을 정의하는 프로토콜을 포함

다음을 추가해라:

```swift
struct PriorityQueue<Element: Equatable>: Queue { // 1

  private var heap: Heap<Element> // 2

  init(sort: @escaping (Element, Element) -> Bool,
       elements: [Element] = []) { // 3
    heap = Heap(sort: sort, elements: elements)
  }

    var isEmpty: Bool {
      heap.isEmpty
    }
    
    var peek: Element? {
      heap.peek()
    }
    
    mutating func enqueue(_ element: Element) -> Bool { // 1
      heap.insert(element)
      return true
    }
    
    mutating func dequeue() -> Element? { // 2
      heap.remove()
    }
}
```

이 코드를 살펴보자:

1. PriorityQueue는 `Queue` 프로토콜을 준수할 것이다. 일반 파라미터 요소는 요소를 비교해야 하기 때문에 Equatable을 준수해야 한다.
2. 이 힙을 사용하여 우선 순위 큐를 구현할 것이다.
3. 이 이니셜라이저에 적절한 기능을 전달함으로써, PriorityQueue를 사용하여 최소 및 최대 우선 순위 대기열을 모두 만들 수 있다.

init(sort:elements:) 이니셜라이저 바로 뒤에 다음 네 함수는 큐 프로토콜을 준수하기 위해 구현되어야 한다.

힙은 우선순위 큐를 위한 완벽한 후보이다. 우선 순위 큐의 작업을 구현하려면 힙의 다양한 방법을 호출해야 한다.

1. 이전 장에서, `enqueue(:)`를 호출하여 힙에 삽입하고, 힙을 검증하기 위해 sift up 된다는 것을 이해해야 한다. `enqueue(:)`의 전반적인 복잡성은 `O(log n)`이다.
2. `dequeue(_:)`를 호출하면 힙의 마지막 요소로 대체하여 힙에서 루트 요소를 제거한 다음 힙의 유효성을 검사하기 위해 sift down한다. `dequeue()`의 전반적인 복잡성은 `O(log n)`이다.

*~~Testing 생략~~*

## 🔑 Key points

- 우선 순위 큐는 종종 우선 순위 순서로 요소를 찾는 데 사용된다.
- 이는 큐의 주요 작업에 초점을 맞추고 힙 데이터 구조에서 제공하는 추가 기능을 생략함으로써 추상화 계층을 만든다.
- 이것은 우선 순위 큐의 의도를 명확하고 간결하게 만든다. 우선 순위 큐의 유일한 역할은 요소를 대기열에 넣고 대기열에서 분리하는 것이지, 다른 것은 없다!
- 승리를 위한 구성!
