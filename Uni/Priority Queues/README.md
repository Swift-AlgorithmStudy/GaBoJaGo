# Chapter 24: Priority Queues

우선순위 큐는 FIFO 순서 대로 dequeue()하는 큐와는 달리 우선순위 순서로 요소를 dequeue()를 실행합니다.

예를 들어, 우선순위 큐는 다음과 같을 수 있습니다:
1. 최대 우선순위: 맨 앞의 요소가 항상 가장 큰 값인 경우.
2. 최소 우선순위: 맨 앞의 요소가 항상 가장 작은 값인 경우.

우선순위 큐는 특히 요소 리스트가 주어졌을 때 최대 또는 최소 값을 파악하는 데에 유용합니다.

## 응용 분야

우선순위 큐의 실제 응용 분야에는 다음과 같은 것들이 있습니다:

- Dijkstra 알고리즘: 최소 비용을 계산하기 위해 우선순위 큐를 사용합니다.
- A* 경로 탐색 알고리즘: 최단 길이의 경로를 생성할 수 있는 탐색되지 않은 경로를 추적하기 위해 우선순위 큐를 사용합니다.
- 힙 정렬: 우선순위 큐를 사용하여 구현할 수 있습니다.
- 허프만 코딩: 압축 트리를 구축합니다. 최소 우선순위 큐는 부모 노드가 없는 가장 작은 빈도를 가진 두 개의 노드를 반복적으로 찾기 위해 사용됩니다.

이러한 것들은 일부 사용 사례에 불과하며, 우선순위 큐는 더 많은 응용 분야를 가지고 있습니다.

## 공통 동작

```swift
public protocol Queue {
	associatedtype Element
	mutating func enqueue(_ element: Element) -> Bool
	mutating func dequeue() -> Element?
	var isEmpty: Bool { get }
	var peek: Element? { get }
}
```

우선순위 큐는 일반 큐와 동일한 연산을 갖기 때문에 구현만 다릅니다.
우선순위 큐는 큐 프로토콜에 따르며 다음과 같은 일반적인 연산을 구현합니다:
- enqueue: 요소를 큐에 삽입합니다. 작업이 성공적으로 수행되면 true를 반환합니다.
- dequeue: 가장 높은 우선순위를 가진 요소를 제거하고 반환합니다. 큐가 비어있는 경우 nil을 반환합니다.
- isEmpty: 큐가 비어 있는지 확인합니다.
- peek: 가장 높은 우선순위를 가진 요소를 제거하지 않고 반환합니다. 큐가 비어있는 경우 nil을 반환합니다.

## 구현

다음과 같은 방법으로 우선순위 큐를 생성할 수 있습니다:

1. 정렬된 배열: 이 방법은 요소의 최대값 또는 최소값을 O(1) 시간에 얻는 데에 유용합니다.
그러나 삽입은 느리며 O(n)의 시간이 걸립니다. 왜냐하면 정렬된 순서에 맞게 삽입해야하기 때문입니다.
2. 균형 이진 검색 트리: 이 방법은 양방향 우선순위 큐를 만드는 데에 유용합니다.
이 방법은 최소값과 최대값을 모두 O(log n) 시간에 얻을 수 있습니다. 삽입은 정렬된 배열보다 좋으며 O(log n)의 시간이 걸립니다.
3. 힙: 힙은 우선순위 큐에 자연스럽게 사용되는 선택지입니다.
힙은 정렬된 배열보다 효율적이며 부분적으로만 정렬되어 있으면 됩니다.
모든 힙 연산은 O(log n)이며, 최소값을 추출하는 최소 우선순위 힙은 빠른 O(1)입니다. 마찬가지로, 최대값을 추출하는 최대 우선순위 힙도 O(1)입니다.

다음으로, 힙을 사용하여 우선순위 큐를 생성하는 방법을 살펴보겠습니다.

```swift
// PriorityQueue는 Queue 프로토콜을 따르게 됩니다.
// Element의 제네릭 매개변수는 요소를 비교해야 하므로 Equatable을 따라야 합니다.
struct PriorityQueue<Element: Equatable>: Queue {
	// 이 힙을 사용하여 우선순위 큐를 구현할 것입니다.
    private var heap: Heap<Element>
	// 이 초기화자에 적절한 함수를 전달함으로써 PriorityQueue를 사용하여 최소 우선순위 큐와 최대 우선순위 큐를 모두 만들 수 있습니다.
	init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
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

힙은 우선순위 큐를 구현하기에 이상적인 후보입니다. 우선순위 큐의 연산을 구현하기 위해 힙의 다양한 메서드를 호출해야 합니다!

1. 이전 장에서 배웠듯이, enqueue(:)를 호출하여 힙에 삽입하고, 힙은 자체를 유효성 검사하기 위해 위로 이동합니다.
enqueue(:)의 전체 복잡도는 O(log n)입니다.
1. dequeue(_:)를 호출하여 힙에서 루트 요소를 제거하고 힙의 마지막 요소와 교체한 다음, 힙의 유효성을 검사하기 위해 아래로 이동합니다.
dequeue()의 전체 복잡도는 O(log n)입니다.

## 테스트

```swift
var priorityQueue = PriorityQueue(sort: >, elements: [1,12,3,4,1,6,8,7])
while !priorityQueue.isEmpty {
	print(priorityQueue.dequeue()!)
}
```

우선순위 큐는 일반 큐와 동일한 인터페이스를 갖는 것을 알 수 있습니다.
위의 코드는 최대 우선순위 큐를 생성합니다.
주목할 점은 요소가 가장 큰 값부터 제거된다는 것입니다. 다음 숫자들이 콘솔에 출력됩니다.

```swift
12
8
7
6
4
3
1
1
```

## Key points

- 우선순위 큐는 우선순위 순서대로 요소를 찾기 위해 사용됩니다.
- 우선순위 큐는 큐의 주요 작업에 집중하고 힙 자료 구조가 제공하는 추가 기능을 제외하여 추상화 계층을 만듭니다.
- 이로써 우선순위 큐의 의도가 명확하고 간결해집니다. 요소 삽입 그리고 요소 삭제!