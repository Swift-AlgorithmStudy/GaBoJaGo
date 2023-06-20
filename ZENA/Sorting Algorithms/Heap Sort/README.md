# Heapsort

힙 정렬은 힙을 사용하여 배열을 오름차순으로 정렬하는 또 다른 비교 기반 알고리즘이다. 이 장은 22장 "힙"에 제시된 힙 개념을 기반으로 한다.

힙소스트는 정의상 다음과 같은 특성을 가진 부분적으로 정렬된 이진 트리인 힙을 이용한다:

1. 최대 힙에서, 모든 부모 노드는 자식보다 크다.
2. 최소 힙에서, 모든 부모 노드는 자식보다 작다.

아래 다이어그램은 부모 노드 값에 밑줄이 있는 힙을 보여준다:

<img width="522" alt="스크린샷 2023-06-20 오전 4 33 32" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/fced2b24-1aa4-4795-a92a-30ec6308ccc5">

## Getting Started

이미 최대 힙의 구현이 포함되어 있다고 한다. 목표는 힙을 확장하여 정렬할 수 있도록 하는 것이다. 시작하기 전에, 힙 정렬이 어떻게 작동하는지에 대한 시각적 예를 살펴보자.

## Example

주어진 정렬되지 않은 배열의 경우, 가장 낮은 것에서 가장 높은 것까지 정렬하려면, 힙 정렬은 먼저 이 배열을 최대 힙으로 변환해야 한다.

이 변환은 모든 부모 노드를 선별하여 올바른 지점에서 끝내는 것으로 이루어진다. 결과 최대 힙은 다음과 같다:

<img width="557" alt="스크린샷 2023-06-20 오전 4 34 27" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/3a8849b3-b161-402b-9ab2-10884f45d61f">

이것은 다음 배열에 해당한다:

<img width="627" alt="스크린샷 2023-06-20 오전 4 34 45" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/522bb8bd-d014-45c4-858c-a6388d6b5845">

단일 선별 작업의 시간 복잡성은 O(log n)이기 때문에, 힙을 구축하는 총 시간 복잡성은 O(n log n)이다.

이 배열을 오름차순으로 정렬하는 방법을 살펴보자.

최대 힙에서 가장 큰 요소는 항상 루트에 있기 때문에, 인덱스 0의 첫 번째 요소를 인덱스 n - 1의 마지막 요소와 교환하는 것으로 시작한다. 스왑 후, 배열의 마지막 요소는 올바른 위치에 있지만 힙을 무효화한다. 따라서 다음 단계는 새로운 루트 노트 5가 올바른 위치에 도착할 때까지 선별하는 것이다.

<img width="626" alt="스크린샷 2023-06-20 오전 4 34 59" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/44ec618d-72b8-40a7-b5ae-c46dbbef88d4">

더 이상 힙의 일부가 아니라 정렬된 배열의 일부로 간주하기 때문에 힙의 마지막 요소를 제외한다는 점에 유의하세여.

5를 선별한 결과, 두 번째로 큰 요소 21이 새로운 뿌리가 된다. 이제 이전 단계를 반복하여 21을 마지막 요소 6과 교환하고, 힙을 축소하고 6을 걸터링할 수 있다.

<img width="626" alt="스크린샷 2023-06-20 오전 4 35 25" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/6cb8a372-0edb-4e0b-a170-aebb1dfec887">

패턴이 보일거다. 힙소트는 매우 간단하다. 첫 번째와 마지막 요소를 바꿀 때, 더 큰 요소는 올바른 순서로 배열의 뒤쪽으로 향한다. 크기 1의 힙에 도달할 때까지 스와핑 및 선별 단계를 반복한다.

그러면 배열이 완전히 정렬된다.

<img width="372" alt="스크린샷 2023-06-20 오전 4 35 43" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/a4898628-1d26-4dfa-af2b-992b2308887a">

```swift
Note: This sorting process is very similar to selection sort from Chapter 26.
```

## Implementation

다음으로, 이 정렬 알고리즘을 구현할 것이다. 무거운 리프팅이 이미 siftDown 방법으로 수행되기 때문에 실제 구현은 매우 간단하다.

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
```

코드 분석:

1. 먼저 힙의 복사본을 만든다. 힙 정렬이 요소 배열을 정렬한 후, 더 이상 유효한 힙이 아니다. 힙의 복사본을 작업함으로써, 당신은 힙이 유효한지 확인한다.
2. 마지막 요소부터 시작하여 배열을 반복한다.
3. 첫 번째 요소와 마지막 요소를 바꾼다. 이 스왑은 가장 큰 정렬되지 않은 요소를 올바른 지점으로 이동한다.
4. 힙이 이제 유효하지 않기 때문에, 새 루트 노드를 선별해야 한다. 결과적으로, 다음으로 큰 요소는 새로운 뿌리가 될 것이다.

```swift
Note: To support heap sort, you’ve added the upTo parameter to the siftDown method. This way, the sift down only uses the unsorted part of the array, which shrinks with every loop iteration.
```

Finally, give your new method a try:

```swift
let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
print(heap.sorted())
```

이 코드는 다음과 같이 출력되어야 한다:

```swift
[2, 5, 6, 8, 9, 12, 18, 21, 26]
```

## Performance

인메모리 정렬의 이점을 누릴 수 있지만, 힙 정렬의 성능은 최고, 최악 및 평균의 경우 O(n log n)이다. 이러한 성능의 균일성은 전체 목록을 한 번 통과해야 하고 요소를 바꿀 때마다 O(log n) 작업인 선별을 수행해야 하기 때문이다.

힙소트는 또한 요소가 어떻게 배치되고 힙에 들어가는지에 달려 있기 때문에 안정적인 정렬이 아니다. 예를 들어, 카드 덱을 순위별로 정렬하는 경우, 원래 덱에 비해 스위트 변경 순서를 볼 수 있다.

## 🔑 Key points

- 힙 정렬은 최대 힙 데이터 구조를 활용하여 배열의 요소를 정렬한다.
- 힙소트는 간단한 패턴에 따라 요소를 정렬한다:
    1. 첫 번째와 마지막 요소를 바꾼다.
    2. 힙이 되는 요구 사항을 충족시키기 위해 루트에서 선별 작업을 수행한다.
    3. 끝에 있는 요소가 가장 큰 요소가 될 것이기 때문에 배열 크기를 하나 줄인다.
    4. 배열의 시작 부분에 도달할 때까지 이 단계를 반복한다.
