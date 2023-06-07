# Chap11. Priority Queue

큐는 단순히 선입선출(FIFO) 순서를 사용하여 요소의 순서를 유지하는 목록입니다. 우선 순위 큐는 FIFO 순서를 사용하는 대신 요소가 우선 순위 순서로 줄어드는 큐의 또 다른 버전입니다. 예를 들어, 우선 순위 큐는 다음과 같습니다:

1. 전면의 요소가 항상 가장 큰 Max 우선 순위.
2. 전면의 요소가 항상 가장 작은 Min 우선순위.

우선 순위 큐는 요소 목록이 주어진 최대 또는 최소 값을 식별할 때 특히 유용합니다. 우선 순위 큐의 이점을 배우고 이전 장에서 연구한 기존의 큐와 힙 데이터 구조를 활용하여 구축할 것입니다.

## 응용

우선 순위 큐의 몇 가지 실용적인 응용 

- 최소 비용을 계산하기 위해 우선 순위 대기열을 사용하는 **다익스트라의 알고리즘**
- 우선 순위 대기열을 사용하여 가장 짧은 길이의 경로를 생성하는 탐험되지 않은 경로를 추적하는 **A* 경로 찾기 알고리즘**
- 우선 순위 대기열을 사용하여 구현할 수 있는 **힙 정렬**
- 압축 트리를 만드는 **허프만 코딩**. 최소 우선 순위 대기열은 아직 부모 노드가 없는 가장 작은 주파수를 가진 두 개의 노드를 반복적으로 찾는 데 사용

## Common operations

이전 챕터의 큐에서 다음 프로토콜을 설정했습니다:

```swift
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
```

우선 순위 큐는 일반 큐와 동일한 작업을 수행하므로 구현만 다를 수 있습니다.

우선 순위 큐는 큐 프로토콜을 준수하고 일반적인 작업을 구현할 것입니다:

- enqueue: 요소를 큐에 삽입합니다. 작업이 성공하면 true를 반환합니다.
- dequeue: 우선 순위가 가장 높은 요소를 제거하고 반환합니다. 큐가 비어 있으면 nil을 반환합니다.
- isEmpty: 큐가 비어 있는지 확인합니다.
- peek: 제거하지 않고 우선 순위가 가장 높은 요소를 반환합니다. 큐가 비어 있으면 nil을 반환합니다.

## Implementation

우선 순위 대기열을 구현하는 다양한 방법입니다.

1. **Sorted array 정렬된 배열:** O(1) 시간에 요소의 최대 또는 최소 값을 얻는 데 유용합니다. 그러나, 삽입이 느리고 순서대로 삽입해야 하기 때문에 O(n)가 필요합니다.
2. **Balanced binary search tree 균형 잡힌 이진 검색 트리:** 이것은 O(log n) 시간에 최소값과 최대값을 모두 얻는 이중 우선 순위 큐를 만드는 데 유용합니다. 삽입은 O(log n)에서도 정렬된 배열보다 낫다.
3. **Heap 힙:** 힙은 부분적으로만 정렬해야 하기 때문에 정렬된 배열보다 더 효율적이다. 모든 힙 작업은 O(log n)이지만 최소 우선 순위 힙에서 최소 값을 추출하는 것은 번개처럼 빠른 O(1)입니다. 마찬가지로, 최대 우선 순위 힙에서 최대 값을 추출하는 것도 O(1)이다.

힙을 사용하여 우선 순위 대기열을 만드는 방법을 살펴보겠습니다. 

```swift
struct PriorityQueue<Element: Equatable>: Queue { // 1

  private var heap: Heap<Element> // 2

  init(sort: @escaping (Element, Element) -> Bool,
       elements: [Element] = []) { // 3
    heap = Heap(sort: sort, elements: elements)
  }

	//큐 프로토콜을 준수하기 위한 코드
	var isEmpty: Bool {
	  heap.isEmpty
	}
	
	var peek: Element? {
	  heap.peek()
	}
	
	mutating func enqueue(_ element: Element) -> Bool { // 4
	  heap.insert(element)
	  return true
	}
	
	mutating func dequeue() -> Element? { // 5
	  heap.remove()
	}
}
```

1. PriorityQueue는 큐 프로토콜을 준수할 것이다. 일반 매개 변수 요소는 요소를 비교해야 하기 때문에 Equatable을 준수해야 합니다.
2. 이 힙을 사용하여 우선 순위 큐를 구현할 것입니다.
3. 이니셜라이저에 적절한 기능을 전달함으로써, PriorityQueue를 사용하여 최소 및 최대 우선 순위 큐를 모두 만들 수 있습니다.
4. 당신은 enqueue()를 호출하여 힙에 삽입하고, 힙이 자체를 검증하기 위해 sift up된다는 것을 이해해야 합니다. Enqueue(:)의 전반적인 복잡성은 O(log n)이다.
5. Dequeue(_:)를 호출하면 힙의 마지막 요소로 대체하여 힙에서 루트 요소를 제거한 다음 힙의 유효성을 검사하기 위해 sift down합니다. Dequeue()의 전반적인 복잡성은 O(log n)이다.

## 🗝️ Key points

- 우선 순위 큐는 종종 우선 순위 순서로 요소를 찾는 데 사용됩니다.
- 우선 순위 큐는 큐의 주요 작업에 초점을 맞추고 힙 데이터 구조에서 제공하는 추가 기능을 생략함으로써 추상화 계층을 만듭니다.
- 이는 우선 순위 대기열의 의도를 명확하고 간결하게 만든다. 그것의 유일한 일은 요소를 대기열에 넣고 대기열에서 분리하는 것이지, 다른 것은 없다!
