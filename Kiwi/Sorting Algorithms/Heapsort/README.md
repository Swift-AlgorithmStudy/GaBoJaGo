# Heapsort

간단하다. 힙을 이용한 정렬이다.

## 구현

```swift

extension Heap {
  func sorted() -> [Element] {
    var heap = Heap(sort: sort, elements: elements) // 1
    for index in heap.elements.indices.reversed() { // 2
      heap.elements.swapAt(0, index) // 3
      heap.siftDown(from: 0, upTo: index) // 4
    }
    return heap.elements
  }
}

// 가장 큰수(맨앞의 요소)를 맨뒤로 보낸다. 이후 siftDown을 통해 힙을 다시 정렬한다. 이걸 계속 반복하여 정렬
```
