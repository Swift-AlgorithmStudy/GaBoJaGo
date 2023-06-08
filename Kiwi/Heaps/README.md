# Heaps

힙은 데이터를 효율적으로 관리하기 위한 트리 기반의 자료구조이다. 힙은 주로 가장 큰 값 또는 가장 작은 값에 빠르게 접근해야 하는 경우에 사용된다.

힙은 완전 이진 트리이며, 배열을 사용하여 구현할 수 있다. 완전 이진 트리는 루트 노드부터 왼쪽에서 오른쪽으로 노드를 순서대로 채워나가는 형태를 갖는다.

힙은 크게 두 가지 종류가 있다. 최대 힙과 최소 힙이다.

**최대 힙(Max Heap)**: 부모 노드의 값은 자식 노드의 값보다 크거나 같아야 한다. 즉, 가장 큰 값이 루트 노드에 위치한다.

**최소 힙(Min Heap)**: 부모 노드의 값은 자식 노드의 값보다 작거나 같아야 한다. 즉, 가장 작은 값이 루트 노드에 위치한다.

힙은 주로 우선순위 큐나 정렬 알고리즘 등에서 사용된다. 힙을 효율적으로 구현하면 가장 큰 값이나 가장 작은 값을 빠르게 찾을 수 있다.

## How do you represent a heap?

![](https://hackmd.io/_uploads/rywRTh6Un.png)

힙(heap)은 노드의 수가 이전 레벨보다 두 배씩 증가하는 구조이다.

힙에서는 어떤 노드든 간편하게 접근할 수 있다. 이는 배열에서 요소에 접근하는 방법과 유사하다. 왼쪽이나 오른쪽 가지를 따라 내려가는 대신, 간단한 공식을 사용하여 배열에서 노드에 접근할 수 있다.

인덱스 i에 위치한 노드를 기준으로 하면:

왼쪽 자식 노드는 인덱스 2i + 1에 있다.
오른쪽 자식 노드는 인덱스 2i + 2에 있다.
노드의 부모를 찾고 싶을 때는 i를 이용하여 계산할 수 있다. 자식 노드의 인덱스 i가 주어졌을 때, 해당 자식 노드의 부모 노드는 인덱스 floor((i - 1) / 2)에 위치한다.

참고: 실제 이진 트리에서는 노드의 왼쪽과 오른쪽 자식을 찾기 위해 이진 트리를 내려가야 하는데, 이 연산은 O(log n)의 시간이 걸린다. 그러나 배열과 같은 임의 접근 데이터 구조에서는 이러한 연산을 O(1)로 처리할 수 있다.

## 구현

```swift

struct Heap<Element: Equatable> {
    
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool) {
        self.sort = sort
    }

    var isEmpty: Bool {
        elements.isEmpty
    }

    var count: Int {
        elements.count
    }

    func peek() -> Element? {
        elements.first
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
}

//이 타입은 배열을 사용하여 힙에 요소들을 저장하고, 정렬 함수를 통해 힙이 어떻게 정렬되어야 하는지를 결정합니다. 초기화할 때 적절한 정렬 함수를 전달하면, 그에 맞는 최소 힙이나 최대 힙을 생성할 수 있습니다. 이렇게 생성된 힙은 효율적인 시간과 공간 복잡도를 가지며, 메모리 내에서 요소들이 함께 저장되어 있어 데이터 접근 및 조작이 용이합니다.
```

### Implementation of remove

삭제하기는 최대값 또는 최솟값을 꺼내는 것과 같은 말이다.

```swift

mutating func remove() -> Element? {
  
  // 1.
  // 힙이 비어 있는지 확인합니다. 비어 있다면 nil을 반환합니다.
  guard !isEmpty else { 
    return nil
  }

  // 2.
  //  루트와 힙의 마지막 요소를 교환합니다.
  elements.swapAt(0, count - 1) 

  // 4.
  // 힙이 더 이상 최대 힙 또는 최소 힙이 아닐 수 있으므로, 규칙을 따르도록 아래로 내려가는 작업을 수행해야 합니다.
  defer {
    siftDown(from: 0) // 4
  }

  // 3.
  // 마지막 요소(최대 또는 최소값)를 제거하고 반환합니다.
  return elements.removeLast() 
}


// siftDown(from:) 메서드는 임의의 인덱스를 받습니다. 이 인덱스에 있는 노드는 항상 부모 노드로 처리됩니다. 
mutating func siftDown(from index: Int) {

  var parent = index // 1. 부모 인덱스를 저장합니다.
  while true { // 2. 반환될 때까지 아래로 내려가는 작업을 계속합니다.

    // 3. 부모의 왼쪽과 오른쪽 자식 인덱스를 구합니다.
    let left = leftChildIndex(ofParentAt: parent) 
    let right = rightChildIndex(ofParentAt: parent)

    // 4. candidate 변수는 부모와 교환할 인덱스를 추적하는 데 사용됩니다.
    var candidate = parent 

    // 5. 왼쪽 자식이 있고 그 우선순위가 부모보다 높다면, candidate로 지정합니다.
    if left < count && sort(elements[left], elements[candidate]) {
      candidate = left 
    }

    // 6. 오른쪽 자식이 있고 그 우선순위가 더 높다면, 대신 candidate가 됩니다.
    if right < count && sort(elements[right], elements[candidate]) {
      candidate = right
    }

    // 7. candidate가 여전히 부모라면, 끝에 도달했으며 더 이상 아래로 내려갈 필요가 없습니다.
    if candidate == parent {
      return 
    }

    // 8. candidate와 부모를 교환하고 새로운 부모로 설정하여 계속해서 아래로 내려갑니다.
    elements.swapAt(parent, candidate) 
    parent = candidate
  }
}
```

### Implementation of insert

```swift

mutating func insert(_ element: Element) {
  elements.append(element)
  siftUp(from: elements.count - 1)
}

mutating func siftUp(from index: Int) {
  var child = index
  var parent = parentIndex(ofChildAt: child)
  while child > 0 && sort(elements[child], elements[parent]) {
    elements.swapAt(child, parent)
    child = parent
    parent = parentIndex(ofChildAt: child)
  }
}

```

### Removing from an arbitrary index

```swift

// 힙에서 임의의 요소를 제거하려면 인덱스가 필요합니다.
mutating func remove(at index: Int) -> Element? {

  // 1. 배열의 범위 내에 인덱스가 있는지 확인합니다. 그렇지 않으면 nil을 반환합니다.
  guard index < elements.count else {
    return nil 
  }

  // 2. 힙에서 마지막 요소를 제거하는 경우 특별한 처리가 필요하지 않습니다. 단순히 마지막 요소를 제거하고 반환합니다.
  if index == elements.count - 1 {
    return elements.removeLast() 
  } else {
    elements.swapAt(index, elements.count - 1)
    // 3. 마지막 요소가 아닌 경우, 해당 요소를 마지막 요소와 교환합니다.
    defer {

      // 5. 마지막으로, 힙을 조정하기 위해 sift down과 sift up을 수행합니다.
      siftDown(from: index) 
      siftUp(from: index)
    }

    // 4. 그런 다음 마지막 요소를 반환하고 제거합니다.
    return elements.removeLast()
  }
}

```

### Searching for an element in a heap

```swift

func index(of element: Element, startingAt i: Int) -> Int? {

  // 1. 
  // 인덱스가 배열의 요소 수보다 크거나 같으면 검색 실패로 간주하고 nil을 반환합니다.
  if i >= count {
    return nil 
  }

  // 2. 
  // 찾고자 하는 요소가 현재 인덱스 i의 요소보다 우선순위가 높다면, 찾고자 하는 요소는 힙에서 더 낮은 위치에 있을 수 없습니다. 따라서 nil을 반환합니다.
  if sort(element, elements[i]) {
    return nil 
  }

  // 3.
  // 요소가 인덱스 i의 요소와 동일하다면, i를 반환합니다.
  if element == elements[i] {
    return i 
  }

  // 4.
  // 왼쪽 자식 인덱스에서 시작하여 요소를 재귀적으로 검색합니다.
  if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
    return j 
  }

  // 5. 
  // 오른쪽 자식 인덱스에서 시작하여 요소를 재귀적으로 검색합니다.
  if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
    return j 
  }

  // 6.
  // 위의 두 검색이 모두 실패한 경우, 검색 실패로 간주하고 nil을 반환합니다.
  return nil
}

```

# Priority Queues

큐는 먼저 들어온 요소가 먼저 나가는(FIFO) 순서를 유지하는 리스트이다.
우선순위 큐는 FIFO 순서가 아닌 우선순위 요소가 디큐되는 큐의 다른 버전이다.
예를 들어, 우선순위 큐는 다음 중 하나일 수 있다.

**최대 우선순위 큐(Max-priority queue)** : 맨 앞의 요소가 항상 가장 큰 값

**최소 우선순위 큐(Min-priority queue)** : 맨 앞의 요소가 항상 가장 작은 값

우선순위 큐는 특히 요소 목록에서 최대값 또는 최소값을 식별하는 데 유용하다.

## 구현

```swift

/* 
PriorityQueue는 Queue 프로토콜을 준수합니다. 
Element라는 제네릭 매개변수는 Equatable 프로토콜을 준수해야 하며, 요소들을 비교할 수 있어야 합니다.
*/
struct PriorityQueue<Element: Equatable>: Queue {

    // 우선순위 큐를 구현하는 데 사용될 힙
    private var heap: Heap<Element> 
    
    // 초기화 매서드를 통해 알맞은 함수를 전달함으로써 최소 우선순위 큐와 최대 우선순위 큐를 모두 생성할 수 있습니다.
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) { 
        heap = Heap(sort: sort, elements: elements)
    }

    var isEmpty: Bool {
        heap.isEmpty
    }

    var peek: Element? {
        heap.peek()
    }

    // 1
    mutating func enqueue(_ element: Element) -> Bool { 
        heap.insert(element)
        return true
    }

    // 2
    mutating func dequeue() -> Element? {
        heap.remove()
    }
}

```
