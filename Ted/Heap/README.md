# Heaps

Heap은 트리를 기반으로 한 자료구조로써, 가장 크거나 작은 요소를 찾는 데에 좋은 성능을 보인다는 특징이 있습니다.

이번 장에서는 힙을 만들고 조작하는 법에 대해 배울 것입니다. 

## What is heap?

Heap은 이진 힙(binary heap)이라고도 알려져 있는 완전 이진 트리(complete binary tree)로써, 배열을 통해 생성할 수 있습니다. 

*Heap과 memory heap은 다른 것이니 주의하십시오.

Heap에는 두 가지의 특징이 있습니다.

1. Max heap : 더 높은 값을 가진 요소가 더 높은 우선순위를 가지는 힙입니다.
2. Min heap : 더 낮은 값을 가진 요소가 더 높은 우선순위를 가지는 힙입니다.

## The heap property

Heap에는 항상 만족해야 하는 중요한 특징이 있습니다.

이는 heap invariant와 heap property라는 특징입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7ae00e19-cf3f-4851-9e8d-51b96918856d/Untitled.png)

Max heap에서는 부모 노드가 자식 노드보다 항상 크거나 같은 값을 가지고 있어야 합니다. 루트 노드가 가장 큰 값을 가지고 있습니다.

Min heap에서는 부모 노드가 자식 노드보다 항상 작거나 같은 값을 가지고 있어야 합니다. 루트 노드가 가장 작은 값을 가지고 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/680f2afb-46e4-4954-9ffc-f76e5cacab74/Untitled.png)

Heap의 다른 특징은 거의 완전한 이진트리(nearly complete binary tree)라는 것입니다. 이는 바닥을 제외한 모든 층은 채워져있어야 한다는 것입니다. 

## Heap applications

Heap의 실제 적용 방법은 다음과 같습니다.

- 컬렉션의 최대값이나 최소값을 계산할 때 사용합니다.
- Heapsort
- 우선순위 큐를 생성할 때 사용합니다.
- Dijkstra나 Prim과 같이 우선 순위 큐를 통해 그래프 알고리즘을 생성할 때 사용합니다.

## Common heap operations

```swift
struct Heap<Element: Equatable> {

  var elements: [Element] = []
  let sort: (Element, Element) -> Bool

  init(sort: @escaping (Element, Element) -> Bool) {
    self.sort = sort
  }
}
```

위 식에는 heap에 요소들을 가지고 있기 위한 배열과 heap이 어떻게 정렬될 지에 대한 함수가 있습니다. 

## How do you represent a heap?

트리는 자식에 대해 참조하고 있는 노드를 가지고 있습니다. 이진 트리의 경우에는 왼쪽, 오른쪽 자식에 대한 참조입니다. Heap 또한 이진 트리이지만, 간단한 배열로 표현할 수 있습니다. 이는 트리를 만드는 방식에 있어서 좀 다르지만, 요소들이 메모리에 함께 저장되어 있다는 점에서 효유적인 시간과 공간 복잡도를 가지고 있습니다.  
힙 연산을 하는 데에 있어서 swapping은 매우 중요한 역할을 할 것입니다. 이 연산은 이진 트리 구조보다 배열로 조작하는 것이 훨씬 쉬울 것입니다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/46fec1dd-2693-4d6a-9b11-23c42e567b6f/Untitled.png)

힙을 배열로 표현하기 위해서, 각각의 요소를 왼쪽에서 오른쪽으로 층마다 순회합니다.

순회했을 때 다음과 같을 것입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d8cad8cf-42e2-4398-bae4-caa93fe33722/Untitled.png)

층이 올라갈 수록 이전의 층보다 2배의 노드를 가질 것입니다.

이제 힙 안에 있는 노드에 접근하기 쉬워졌습니다. 이제 배열과 비교해서 요소에 어떻게 접근할 지 비교할 수 있습니다.

왼쪽에서 오른쪽으로 순회하는 대신, 간단한 식을 통해 접근할 수 있습니다.

인덱스 i가 주어졌을 때

- 노드의 왼쪽 자식은 2i + 1의 인덱스에 있을 것입니다.
- 노드의 오른쪽 자식은 2i + 2의 인덱스에 있을 것입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/87b36cc6-fa19-46e7-bfa0-43000e7e5809/Untitled.png)

만약 자식 노드의 인덱스가 i일 때, 부모 노드는 (i - 1) / 2의 층에서 찾을 수 있습니다.

```swift
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
```

## Removing from a heap

기본적인 제거 연산은 힙의 루트 노드를 제거합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/788d9092-9050-4064-af0f-9a10c60320f9/Untitled.png)

제거 연산은 루트 노드에 있는 최대값을 제거할 것입니다. 
이를 위해서는, 루트 노드와 힙의 가장 마지막 요소를 스왑해야 합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/53beebf7-d157-4aaf-86b6-e06760ee392e/Untitled.png)

두 요소를 스왑한 후에, 마지막 요소를 제거할 수 있고, 나중에 반환하기 위해 값을 저장해놓습니다.

이제 최대힙(max heap)의 무결성을 확인해야 합니다. 하지만 확인하기 전에, “여전히 최대 힙인가?”에 대해 확인해야 합니다.

최대힙은 부모 노드가 자식 노드보다 크거나 같아야 하는 규칙을 준수합니다. 힙이 이 규칙에 부합하지 않는다면, sift down을 수행해야 합니다.

sift down을 수행하기 위해서, 현재 노드인 3과 왼쪽, 오른쪽 자식을 확인합니다. 만약 현재 값보다 큰 값이 있다면, 부모와 스왑합니다. 만약 두 자식 모두가 값이 더 크다면, 더 큰 값과 스왑합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b353e5dc-fa3e-436d-978b-5a741874e55c/Untitled.png)

자식의 값이 더 크지 않을 때까지 sift down을 진행합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0ce1d6e2-4c82-4d18-a409-8fb669f17bc8/Untitled.png)

만약 끝까지 도달했다면, 최대힙의 속성이 다시 저장될 것입니다.

## Implementation of remove

```swift
mutating func remove() -> Element? {
  guard !isEmpty else { // 1
    return nil
  }
  elements.swapAt(0, count - 1) // 2
  defer {
    siftDown(from: 0) // 4
  }
  return elements.removeLast() // 3
}
```

1. 힙이 비어있는지 확인하고, 비어있다면 nil을 반환합니다.
2. 힙의 루트와 마지막 요소를 스왑합니다.
3. 마지막 요소(가장 크거나 가장 작은 값)를 삭제하고 반환합니다.
4. 최대힙이나 최소힙이 아닐 수 있기 때문에, sift down을 진행합니다.

```swift
mutating func siftDown(from index: Int) {
  var parent = index // 1
  while true { // 2
    let left = leftChildIndex(ofParentAt: parent) // 3
    let right = rightChildIndex(ofParentAt: parent)
    var candidate = parent // 4
    if left < count && sort(elements[left], elements[candidate]) {
      candidate = left // 5
    }
    if right < count && sort(elements[right], elements[candidate]) {
      candidate = right // 6
    }
    if candidate == parent {
      return // 7
    }
    elements.swapAt(parent, candidate) // 8
    parent = candidate
  }
}
```

siftDown은 임의의 인덱스를 허용합니다. 해당 인덱스의 노드는 항상 부모노드로 취급됩니다.

1. 부모 인덱스를 저장합니다.
2. 반환하기 전까지 sifting을 진행합니다.
3. 부모의 왼쪽, 오른쪽 노드 인덱스를 가져옵니다.
4. candidate 변수는 부모와 스왑할 인덱스를 계속해서 추적합니다.
5. 만약 왼쪽 자식이 있고 그것이 부모보다 높은 운선순위를 가진다면, candidate로 선언합니다.
6. 만약 오른쪽 자식이 있고 그것이 부모보다 높은 우선순위를 가진다면, candidate로 선언합니다.
7. 만약 candidate이 부모라면, 끝까지 도달한 것이기 때문에 sifting을 할 필요가 없어집니다.
8. candidate와 부모를 스왑하고 새로운 부모를 가지고 sifting을 진행합니다.

Complexity 

remove()의 시간 복잡도는 O(log n)입니다. 
배열에서 요소를 스왑하는 것은 O(1)이지만 힙에서는 O(log n)의 시간 복잡도를 가집니다.

## Inserting into a heap

힙에 7을 삽입한다고 가정해봅시다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/6ab5e794-3937-4768-94aa-b64cc037844a/Untitled.png)

첫 번째로, 힙의 끝에 값을 추가합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/eacc9b02-40ba-4deb-b6e5-4b66704d283a/Untitled.png)

그 뒤, 최대힙의 값을 확인합니다. 
삽입한 값이 부모보다 높은 우선순위를 가질 수 있기 때문에 sift down을 하지 않고 sift up을 진행합니다. 
현재 노드와 부모를 (만약 필요하다면) 스왑하는 점에 있어서 sift down과 매우 유사합니다. 

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a64bde33-dba7-4288-9c0d-76dfab4298b0/Untitled.png)

이제 최대힙의 조건을 만족하게 되었습니다.

## Implementation of insert

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

보다싶이, 매우 직관적입니다.

- insert는 배열에 요소를 추가하고 sift up을 수행합니다.
- 노드가 부모보다 높은 우선순위를 갖기 전까지 siftUp은 부모와 현재 노드를 스왑합니다.

Complexity

insert(:_)의 시간 복잡도는 O(log n)입니다. 
배열에 요소를 추가하는 것은 O(1)인 반면에, 힙에서의 sifting up은 O(log n)입니다.

## Removing from an arbitrary index

```swift
mutating func remove(at index: Int) -> Element? {
  guard index < elements.count else {
    return nil // 1
  }
  if index == elements.count - 1 {
    return elements.removeLast() // 2
  } else {
    elements.swapAt(index, elements.count - 1) // 3
    defer {
      siftDown(from: index) // 5
      siftUp(from: index)
    }
    return elements.removeLast() // 4
  }
}
```

힙에서 요소를 제거하기 위해선 인덱스가 필요합니다. 

1. 인덱스가 배열 범위에 포함되어 있는지 확인하고, 포함되어있지 않다면 nil을 반환합니다.
2. 힙에서 마지막 요소를 제거한다면 간단하게 제거를 한 뒤 요소를 반환합니다.
3. 만약 마지막 요소를 제거하는 것이 아니라면 마지막 요소와 스왑합니다.
4. 그리고 반환한 뒤에 마지막 요소를 제거합니다.
5. 마지막으로, sift down과 sift up으로 힙을 조정합니다.

여기서 왜 sift down과 sift up을 둘 다 실행해야 할까요?

5를 제거한다고 가정해봅시다. 5를 마지막 요소인 8과 스왑합니다. 
최대힙 특징을 만족하기 위해서 sift up을 수행합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/69f25c04-f412-453b-9139-733c7662eef8/Untitled.png)

이제 7을 제거해야합니다. 7과 마지막 요소인 1을 스왑합니다.
최대힙 특징을 만족하기 위해서 sift down을 수행합니다.

힙에서 임의의 요소를 제거하는 것은 O(log n)연산입니다. 

하지만 제거하고 싶은 요소의 인덱스를 어떻게 찾을 수 있을까요?

## Searching for an element in a heap

삭제하고 싶은 요소의 인덱스를 찾기 위해선, 힙에서의 탐색을 수행해야 합니다. 
하지만 힙은 빠른 탐색을 위해 설계되지 않았는데, 배열을 이용하기 때문에 이진 탐색 또한 적용할 수 없습니다. 

Complexity 

힙에서 요소를 찾는 것은 배열에서 모든 요소를 검색하는 것이기 때문에 최악의 경우에 O(n) 연산이 됩니다.

```swift
func index(of element: Element, startingAt i: Int) -> Int? {
  if i >= count {
    return nil // 1
  }
  if sort(element, elements[i]) {
    return nil // 2
  }
  if element == elements[i] {
    return i // 3
  }
  if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
    return j // 4
  }
  if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
    return j // 5
  }
  return nil // 6
}
```

1. 만약 인덱스가 배열의 개수보다 많거나 같다면, nil을 반환합니다.
2. 찾고 있는 요소가 현재 인덱스 i에 있는 값보다 큰 지 확인합니다. 만약 그렇다면, 찾고 있는 요소가 힙에서 더 밑에 있지 않을 것입니다.
3. 만약 찾고 있는 요소가 인덱스 i에 있는 요소와 같다면 i를 반환합니다.
4. i의 왼쪽 자식부터 재귀적으로 탐색합니다.
5. i의 오른쪽 자식부터 재귀적으로 탐색합니다.
6. 만약 실패한다면, nil을 반환합니다.

## Building a heap

```swift
init(sort: @escaping (Element, Element) -> Bool,
     elements: [Element] = []) {
  self.sort = sort
  self.elements = elements

  if !elements.isEmpty {
    for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
      siftDown(from: i)
    }
  }
}
```

이니셜라이저가 추가적인 변수를 가집니다. 만약 비어있지 않은 배열이 제공된다면, 힙을 위해 사용될 것입니다. 
힙을 만족하기 위해서 첫 리프도트가 아닌 곳부터 배열을 뒤로 순환하며 모든 부모 노드들을 sift down합니다,. 
부모 노드만 sifting down을 진행하면 되기 때문에 배열의 반만 순환하면 됩니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/790bd13f-8546-4509-a3ef-f2b6e3b19a65/Untitled.png)

## Testing

```swift
var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])

while !heap.isEmpty {
  print(heap.remove()!)
}

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f74aee9b-71cf-47ca-96b1-3dbe0f868702/Untitled.png)

- 힙은 우선 순위를 유지하기 좋은 자료구조입니다.
- 힙의 요소들은 간단한 식을 통해 연속된 메모리에 저장됩니다.
- 요소를 추가하거나 제거할 때마다 힙의 특징을 유지하도록 신경써야 합니다.
