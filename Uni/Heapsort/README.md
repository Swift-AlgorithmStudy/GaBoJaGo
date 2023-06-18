# Chapter 32: Heapsort

힙 정렬(Heapsort)은 힙(heap)을 사용하여 배열을 오름차순으로 정렬하는 비교 기반 알고리즘입니다.

이번 장은 "힙(Heaps)"에서 소개된 힙 개념을 기반으로 구축됩니다.

힙 정렬은 다음과 같은 특징을 갖는, 정의에 따라 부분적으로 정렬된 이진 트리인 힙(heap)을 활용합니다:

1. 최대힙(max heap)에서는 모든 부모 노드가 자식보다 큽니다.
2. 최소힙(min heap)에서는 모든 부모 노드가 자식보다 작습니다.

<img width="600" alt="스크린샷 2023-06-18 오후 6 38 03" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/6404e2aa-51e2-463b-9972-c5f220b1f24b">

# 예시

<img width="600" alt="스크린샷 2023-06-18 오후 6 39 05" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/e3eb5d02-dd92-485c-a75d-d07dcc7fa86f">

주어진 정렬되지 않은 배열을 오름차순으로 정렬하기 위해, 힙 정렬은 먼저 이 배열을 최대힙(max heap)으로 변환해야 합니다.

최종적으로 생성되는 최대힙은 다음과 같습니다:

<img width="600" alt="스크린샷 2023-06-18 오후 6 39 31" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/4a6f194e-9588-44b8-857a-213f150ef653">

이는 다음과 같은 배열과 일치합니다:

<img width="600" alt="스크린샷 2023-06-18 오후 6 39 46" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/e303d857-7393-4260-a0f8-e4e3e5d946bc">

단일 sift-down 연산의 시간복잡도는 O(log n)이므로 힙을 구축하는 전체 시간복잡도는 O(n log n)입니다.

이제 배열을 오름차순으로 정렬하는 방법을 살펴보겠습니다.

최대힙에서 가장 큰 요소는 항상 루트에 위치하기 때문에, 먼저 인덱스 0의 첫 번째 요소와 인덱스 n - 1의 마지막 요소를 교환합니다.

교환 후에는 배열의 마지막 요소가 올바른 위치에 있지만 힙의 조건을 위배합니다.

따라서 다음 단계는 새로운 루트 노드 5를 올바른 위치로 이동할 때까지 sift down하는 것입니다.

<img width="600" alt="스크린샷 2023-06-18 오후 6 40 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/3e67fedf-f348-4122-9e1c-5e3dad028ca0">

마지막 요소는 더 이상 힙의 일부가 아니라 정렬된 배열의 일부로 간주되므로, 힙의 마지막 요소를 제외합니다.

5를 sift down한 결과로 두 번째로 큰 요소인 21이 새로운 루트가 됩니다.

이제 이전 단계를 반복하여 21을 마지막 요소 6과 교환하고, 힙을 축소하고 6을 sift down합니다.

<img width="600" alt="스크린샷 2023-06-18 오후 6 40 55" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/079991ee-d68f-480e-9974-b34af047ac71">

네, 패턴을 보시나요? 힙 정렬은 매우 간단합니다.

첫 번째와 마지막 요소를 교환하면서 더 큰 요소들이 올바른 순서로 배열의 뒷부분으로 이동합니다.

교환하고 sift down하는 단계를 반복하여 힙의 크기가 1이 될 때까지 진행합니다.

그러면 배열은 완전히 정렬됩니다.

<img width="400" height="2000" alt="스크린샷 2023-06-18 오후 6 42 41" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/517e903c-7fdb-40b4-b8ef-f7affc58c01e">

# 구현

다음으로, 이 정렬 알고리즘을 구현하겠습니다. 실제 구현은 매우 간단하며, 실질적인 작업은 이미 siftDown 메서드에 의해 수행되었습니다.

```swift
extension Heap {
    func sorted() -> [Element] {
        // 먼저 힙의 사본을 만듭니다. 힙 정렬이 요소 배열을 정렬한 후에는 더 이상 유효한 힙이 아닙니다.
        // 힙의 사본을 사용함으로써 힙이 유효한 상태로 유지됩니다.
        var heap = Heap(sort: sort, elements: elements)
        // 배열을 끝에서부터 순환합니다.
        for index in heap.elements.indices.reversed() {
            // 첫 번째 요소와 마지막 요소를 교환합니다.
            // 이 교환은 정렬되지 않은 요소 중 가장 큰 요소를 올바른 위치로 이동시킵니다.
            heap.elements.swapAt(0, index)
            // 힙이 더 이상 유효하지 않기 때문에 새로운 루트 노드를 sift down해야 합니다.
            // 결과적으로 다음으로 큰 요소가 새로운 루트가 됩니다.
            // 참고: upTo 매개변수를 사용하면 정렬된 값(가장 큰 값)을 제외할 수 있습니다.
            heap.siftDown(from: 0, upTo: index)
        }
        return heap.elements
    }
}
```

# 성능

힙 정렬의 최선, 최악 및 평균 경우의 성능이 모두 O(n log n)인 이유는 다음과 같습니다.

한 번 전체 목록을 훑어야 하며, 요소를 교환할 때마다 sift down을 수행해야 하기 때문에 O(log n)의 작업이 필요합니다.

힙 정렬은 안정적인 정렬 방법이 아닙니다. 이는 요소들이 어떻게 배치되고 힙에 넣어지느냐에 따라 달라집니다.

예를 들어, 카드 덱의 순위에 따라 힙 정렬을 수행한다면 원래 덱과 비교하여 그들의 모양이 변경될 수 있습니다.

# Key points

- 힙 정렬은 최대힙(max heap) 자료 구조를 활용하여 배열의 요소를 정렬합니다.
- 힙 정렬은 다음과 같은 간단한 패턴을 따라 요소를 정렬합니다:
    1. 첫 번째 요소와 마지막 요소를 교환합니다.
    2. 루트부터 sift down을 수행하여 힙의 조건을 만족시킵니다.
    3. 배열의 크기를 하나 감소시킵니다. 이는 끝에 있는 요소가 가장 큰 요소가 될 것이기 때문입니다.
    4. 배열의 시작지점에 도달할 때까지 이러한 단계를 반복합니다.
