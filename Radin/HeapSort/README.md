# Chap15. Heapsort

힙 정렬은 힙을 사용하여 배열을 오름차순으로 정렬하는 또 다른 비교 기반 알고리즘이다. 이 장은 "힙"에 제시된 힙 개념을 기반으로 한다.

힙소스트는 정의상 다음과 같은 특성을 가진 부분적으로 정렬된 이진 트리인 힙을 이용한다:

1. 최대 힙에서, 모든 부모 노드는 자식보다 크다.
2. 최소 힙에서, 모든 부모 노드는 자식보다 작다.

아래 다이어그램은 부모 노드 값에 밑줄이 있는 힙을 보여줍니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/51eb2cc4-33f3-4fa4-9149-714c2bd5558f)

## Getting started

스타터 놀이터를 열어. 이 놀이터에는 이미 최대 힙의 구현이 포함되어 있다. 당신의 목표는 힙을 확장하여 정렬할 수 있도록 하는 것입니다. 시작하기 전에, 힙 정렬이 어떻게 작동하는지에 대한 시각적 예를 살펴봅시다.

## Example

주어진 정렬되지 않은 배열의 경우, 가장 낮은 것에서 가장 높은 것까지 정렬하려면, 힙 정렬은 먼저 이 배열을 최대 힙으로 변환해야 합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/31fce7f9-879e-4d35-9829-bed86c2d0813)

이 변환은 모든 부모 노드를 선별하여 올바른 지점에서 끝내는 것으로 이루어집니다. 결과 최대 힙은 다음과 같습니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/2a848784-339f-4569-91b4-20dfdf496c3a)

이것은 다음 배열에 해당한다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/efee2812-32cd-4515-9e0b-e2ef70793712)

단일 선별 작업의 시간 복잡성은 O(log n)이기 때문에, 힙을 구축하는 총 시간 복잡성은 O(n log n)이다.

이 배열을 오름차순으로 정렬하는 방법을 살펴봅시다.

최대 힙에서 가장 큰 요소는 항상 루트에 있기 때문에, 인덱스 0의 첫 번째 요소를 인덱스 n - 1의 마지막 요소와 교환하는 것으로 시작합니다. 스왑 후, 배열의 마지막 요소는 올바른 위치에 있지만 힙을 무효화한다. 따라서 다음 단계는 새로운 루트 노트 5가 올바른 위치에 도착할 때까지 선별하는 것이다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/ce3fbb65-3a8b-472c-bb4e-2fc776738917)

더 이상 힙의 일부가 아니라 정렬된 배열의 일부로 간주하기 때문에 힙의 마지막 요소를 제외한다는 점에 유의하십시오.

5를 선별한 결과, 두 번째로 큰 요소 21이 새로운 뿌리가 된다. 이제 이전 단계를 반복하여 21을 마지막 요소 6과 교환하고, 힙을 축소하고 6을 걸터링할 수 있습니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/1b749f89-e129-4a7f-997a-19b7fe09980b)

패턴을 보기 시작했나요? 힙소트는 매우 간단하다. 첫 번째와 마지막 요소를 바꿀 때, 더 큰 요소는 올바른 순서로 배열의 뒤쪽으로 향합니다. 크기 1의 힙에 도달할 때까지 스와핑 및 선별 단계를 반복합니다.

그러면 배열이 완전히 정렬됩니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/67d6ed61-8e94-4c60-88ae-84551ff1cab5)

## 구현

다음으로, 당신은 이 정렬 알고리즘을 구현할 것입니다. 무거운 리프팅이 이미 siftDown 방법으로 수행되기 때문에 실제 구현은 매우 간단합니다.

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

1. 먼저 힙의 복사본을 만드세요. 힙 정렬이 요소 배열을 정렬한 후, 더 이상 유효한 힙이 아닙니다. 힙의 복사본을 작업함으로써, 당신은 힙이 유효한지 확인합니다.
2. 마지막 요소부터 시작하여 배열을 반복합니다.
3. 첫 번째 요소와 마지막 요소를 바꿉니다. 이 스왑은 가장 큰 정렬되지 않은 요소를 올바른 지점으로 이동합니다.
4. 힙이 이제 유효하지 않기 때문에, 새 루트 노드를 선별해야 합니다. 결과적으로, 다음으로 큰 요소는 새로운 루트가 될 것이다.

<aside>
💡 참고: 힙 정렬을 지원하기 위해, siftDown 메소드에 upTo 매개 변수를 추가했습니다. 이런 식으로, 선별은 모든 루프 반복에 따라 축소되는 배열의 정렬되지 않은 부분만 사용합니다.

</aside>

## 성능

힙 정렬은 **인메모리 정렬**의 이점을 얻을 수 있지만, 그 최선, 최악 및 평균 경우의 성능은 여전히 O(n log n)입니다. 이러한 성능의 일관성은 리스트 전체를 한 번 탐색해야 하며, 요소를 교환할 때마다 O(log n) 연산인 sift down을 수행해야 하기 때문입니다.

또한 힙 정렬은 안정적인 정렬이 아닙니다. 이는 요소가 어떻게 배치되고 힙에 삽입되는지에 따라서 변경될 수 있습니다. 예를 들어, 카드 덱을 순위대로 힙 정렬한다면 원래 덱과 비교하여 그들의 모양이 변경될 수 있습니다.

<aside>
💡 힙정렬은 먼저, 정렬할 데이터를 주 메모리에 로드하여 배열이나 트리 형태로 저장합니다. 그런 다음, 힙 속성을 유지하면서 요소를 힙에 삽입하거나 제거하여 정렬을 수행합니다. 이 과정에서 데이터의 비교와 교환 작업이 주 메모리에서 수행되므로, 효율적인 액세스 속도를 활용할 수 있습니다.

</aside>

## Key points

- 힙 정렬은 최대 힙 데이터 구조를 활용하여 배열의 요소를 정렬합니다.
- 힙소트는 간단한 패턴에 따라 요소를 정렬합니다:
1. 첫 번째와 마지막 요소를 바꾸세요.
2. 힙이 되는 요구 사항을 충족시키기 위해 루트에서 선별 작업을 수행하세요.
3. 끝에 있는 요소가 가장 큰 요소가 될 것이기 때문에 배열 크기를 하나 줄이세요.
4. 배열의 시작 부분에 도달할 때까지 이 단계를 반복하세요.