# O(n²) Sorting Algorithms

O(n²) 시간 복잡도는 성능이 좋지 않지만, 이 범주에 속하는 정렬 알고리즘은 이해하기 쉽고 특정 상황에서 유용합니다. </br>
이 알고리즘은 추가 메모리 공간은 상수 O(1)만 필요하므로 공간 효율적입니다. </br>
따라서 작은 데이터 세트에서는 이러한 정렬 방법이 유리합니다. </br>

* 버블 정렬 (Bubble Sort)
* 선택 정렬 (Selection Sort)
* 삽입 정렬 (Insertion Sort)

위 알고리즘들은 비교 기반 정렬 방법입니다. </br>
요소들을 정렬하기 위해 비교 연산자를 사용합니다. </br>
이 비교가 호출되는 횟수는 정렬 기법의 일반적인 성능을 측정하는 방법입니다. </br>

## Bubble sort

가장 직관적인 정렬 중 하나는 버블 정렬입니다. </br>
이 정렬은 반복적으로 인접한 값들을 비교하고 필요한 경우에는 이들을 교환하여 정렬을 수행합니다. </br>
따라서 집합 내에서 큰 값들은 `올라오면서 (bubble up)` 컬렉션의 끝 부분에 위치하게 됩니다. </br>

### Example

<img width="70%" height="70%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/6dd65dca-d78b-4d03-9ac1-abbc8832de5d">
</br>

1. 컬렉션의 시작부터 시작합니다. 따라서 9와 4를 비교합니다. 이 값들은 교환되어야 하므로 컬렉션은 [4,9,10,3]이 됩니다. 
2. 다음 인덱스로 이동하여 컬렉션의 9와 10을 비교합니다. 이들은 순서대로 정렬되어 있습니다.
3. 컬렉션의 다음 인덱스로 이동합니다. 10과 3을 비교합니다. 이 값들은 교환되어야 하므로 컬렉션은 [4,9,3,10]이 됩니다.

</br>

패스라고 불리는 한 번의 과정은 완전한 정렬을 얻지 못하지만, 컬렉션 내의 가장 큰 값이 점점 뒤쪽으로 이동하게 됩니다. </br>
이러한 과정을 반복하면서 모든 원소가 올바른 순서로 정렬되게 됩니다. </br>

<img width="70%" height="70%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/5551a37e-64fc-4610-b427-4b288a00d203">
</br>

* 정렬은 모든 값들을 교환하지 않고 컬렉션을 한 번 통과할 수 있을 때에만 완료됩니다. 
* 최악의 경우에는 컬렉션의 구성원 수를 나타내는 n에 대해 n-1번의 패스가 필요합니다.

</br>
</br>

### Implementation

```swift
public func bubbleSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  // 1
  guard array.count >= 2 else {
    return
  }
  // 2
  for end in (1..<array.count).reversed() {
    var swapped = false
    // 3
    for current in 0..<end {
      if array[current] > array[current + 1] {
        array.swapAt(current, current + 1)
        swapped = true
      }
    }
    // 4
    if !swapped {
      return
    }
  }
}
```
</br>

1. </br>
만약 컬렉션의 원소 개수가 2보다 작다면 정렬이 필요하지 않으므로 함수 종료 </br>

2. </br>
end 변수는 컬렉션의 끝을 나타냅니다. </br>
(1..< array.count) 범위를 거꾸로 반복하며, 각 패스마다 이 값이 하나씩 줄어들게 됩니다. </br>

3. </br>
current 변수는 현재 위치를 나타냅니다. </br>
0부터 end-1까지 반복하며, 각 패스마다 이 값이 하나씩 줄어들게 됩니다. </br>

4. </br>
만약 이번 패스에서 교환이 일어나지 않았다면, 컬렉션이 이미 정렬되었다는 의미이므로 함수를 종료합니다. </br>

</br>

버블 정렬은 이미 정렬된 경우 최선의 시간 복잡도가 O(n)이며, 최악 및 평균 시간 복잡도는 O(n²)로, 알려진 우주에서 가장 효율적이지 않은 정렬 알고리즘 중 하나입니다. </br>
</br>

## Selection sort

선택 정렬은 배열을 순회하면서 현재 위치에서부터 마지막 위치까지의 범위에서 가장 작은 값을 찾아 현재 위치와 교환하는 과정을 반복합니다. </br> 
이를 통해 각 패스마다 가장 작은 값이 왼쪽으로 정렬되어 가장 왼쪽에 위치하게 됩니다. </br>
따라서 선택 정렬은 패스마다 한 번의 swapAt 연산을 수행하여 비교적 적은 수의 교환 연산을 필요로 합니다. </br>
이는 버블 정렬과 비교하여 성능 개선을 이루는 특징으로 볼 수 있습니다.

</br>
</br>

### Example

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Spotify/assets/93391058/7d9a954c-1a28-4501-aa0f-1bb35afa7bd1">
</br>

> 선택 정렬은 리스트에서 가장 작은 값을 찾아 맨 앞으로 이동시키는 과정을 반복하여 정렬을 수행합니다. </br>

1. 처음에 3이 가장 작은 값으로 발견됩니다. 그리고 3은 9와 자리를 바꿉니다.
2. 다음으로 작은 값인 4는 이미 올바른 위치에 있습니다. 따라서 이동할 필요가 없습니다.
3. 마지막으로, 9는 10과 자리를 바꿉니다.
</br>

> 이러한 과정을 반복하면 리스트는 작은 값부터 큰 값으로 정렬됩니다. </br>

<img  width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Spotify/assets/93391058/af468625-5749-4e6b-b16c-b3f5ad590bed"> </br>
</br>

### Implementation
</br>

```swift
public func selectionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  guard array.count >= 2 else {
    return
  }
  // 1
  for current in 0..<(array.count - 1) {
    var lowest = current
    // 2
    for other in (current + 1)..<array.count {
      if array[lowest] > array[other] {
        lowest = other
      }
    }
    // 3
    if lowest != current {
      array.swapAt(lowest, current)
    }
  }
}
```
</br>

1. 마지막 요소를 제외한 모든 요소에 대해 패스를 수행합니다. 즉, 정렬할 리스트의 모든 요소에 대해 작업을 수행합니다. 

* 마지막 요소를 제외하는 이유는, 다른 모든 요소가 이미 올바른 순서에 있다면 마지막 요소도 올바른 위치에 있을 것이기 때문입니다. 따라서 마지막 요소를 제외하고 정렬 알고리즘을 수행해도 됩니다. 

2. 각 패스에서는 나머지 요소들 중에서 가장 작은 값을 찾기 위해 순회합니다. 즉, 현재 패스에서 정렬되지 않은 요소들 중에서 최솟값을 찾습니다.

3. 만약 최솟값이 현재 요소와 다른 요소라면, 두 요소를 서로 교환합니다. 이렇게 함으로써 최솟값을 현재 위치로 이동시킵니다.

</br>
</br>

## Insertion sort

* 삽입 정렬은 평균 시간 복잡도가 `O(n²)`인 알고리즘입니다.
* 성능은 데이터가 이미 정렬되어 있는 정도에 따라 달라집니다. 데이터가 이미 정렬되어 있다면 최선의 경우 `O(n)`의 시간 복잡도를 가집니다.
* Swift 표준 라이브러리는 작은 크기의 정렬되지 않은 파티션에 대해 삽입 정렬을 사용합니다.
</br>

### Example
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Algorithm/assets/93391058/c369b14b-1305-4389-8e2a-a9f6bfd68462">

</br>

1. 첫 번째 카드는 이전 카드와 비교할 수 없으므로 무시합니다.

2. 다음으로, 4를 9와 비교하고, 4를 왼쪽으로 이동시켜서 9와 위치를 바꿉니다.

3. 10은 이전 카드와 비교하여 올바른 위치에 있으므로 이동할 필요가 없습니다.

4. 마지막으로, 3은 10, 9, 4와 순서대로 비교하고 위치를 바꿈으로써 앞쪽으로 모두 이동합니다.

</br>
</br>

### Implementation

</br>

```swift
public func insertionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  guard array.count >= 2 else {
    return
  }
  // 1
  for current in 1..<array.count {
    // 2
    for shifting in (1...current).reversed() {
      // 3
      if array[shifting] < array[shifting - 1] {
        array.swapAt(shifting, shifting - 1)
      } else {
        break
      }
    }
  }
}
```

## Generalization

## Key Points

# Radix Sort 

라딕스 정렬은 비교 연산을 사용하지 않고 정수들을 선형 시간에 정렬하는 알고리즘 입니다. </br>
라딕스 정렬은 정렬할 숫자를 자릿수 별로 나누고, 각 자릿수를 기준으로 정렬하여 최종적으로  정렬된 결과를 얻습니다. </br>
이 떄 가장 작은 작은 자릿수부터 정렬해 나가는 방식이 가장 뒷자리부터 정렬하는 LSD(Least Significant Digit)라딕스 정렬입니다. </br>
LSD 라딕스 정렬은 숫자의 각 자릿수를 분리하여 정렬하기 때문에, 숫자의 크기에 상관없이 일정한 성능을 유지합니다. </br>
그러나 LSD 라딕스 정렬은 숫자의 자릿수가 많을수록 정렬 시간이 증가하므로, 정렬 대상의 범위와 자릿수를 고려하여 사용해야 합니다. </br>

## 과정

기수 정렬은 다음과 과정을 거칩니다. </br>
예를 들어, 현재 가지고 있는 데이터 중 가장 큰 자릿수가 100의 자리라고 가정합니다. </br>

1. 각 데이터들의 1의 자리를 비교해서 같은 데이터끼리 모읍니다. 1의 자리가 작은 데이터들이 앞에 위치하게 되고 큰 숫자들이 뒤에 위치하게 됩니다. (오름차순)
2. 이떄 같은 자릿수에 여러 데이터가 있을 경우에는 입력된 순서로 데이터를 모읍니다. 
> 2번까지 과정을 마치면 1의 자리가 가장 작은 숫자부터 가장 큰 숫자 순으로 데이터들이 정렬됩니다. </br>

3. 이번에는 10의 자리가 같은 데이터끼리 오름차순으로 나열합니다.
> 10보다 작은 숫자들은 배열에 위치했던 순서대로 새로운 정렬의 제일 앞에 위치하게 됩니다.  </br>

4. 이번에는 100의 자리가 같은 데이터끼리 오름차순으로 나열합니다. 
5. 100보다 작은 숫자들은 배열의 제일 앞에서부터 순서대로 채웁니다. 
6. 데이터들의 최대 자릿수가 100의 자리이기 때문에 더 이상 진행하지 않고 종료합니다. </br>

</br>

## Implementation

```swift
extension Array where Element == Int {
  
  public mutating func radixSort() {
  // 1
  let base = 10
  // 2
  var done = false
  var digits = 1
  while !done {

  }
}
```
</br>

1. 
이 경우에는 십진수를 정렬하고 있습니다. 알고리즘에서 이 값을 여러 번 사용하므로, 상수 base에 이 값을 저장합니다.

2. 진행 상황을 추적하기 위해 두 개의 변수를 선언합니다. 라딕스 정렬은 여러 번의 패스(pass)로 작동하기 때문에, done은 정렬을 완료했는지를 나타내는 플래그 역할을 합니다.

</br>
</br>

## POINT

* Radix 정렬의 시간 복잡도는 O(dN) </br>
>  N은 데이터의 개수를 의미하고 d는 데이터들의 최대 자리수입니다. 기수 정렬은 비교연산을 수행하지 않고 버킷에 데이터를 넣고 빼는 작업(N)을 최대 자릿수(d)만큼 만큼 반복하기 때문에 위와 같은 시간복잡도를 가지게 됩니다. </br>

* 자리수가 고정되어 있으므로 안정성이 있는 정렬방식</br>
> 정렬이후에도 중복된 값들은 자리가 바뀌지 않습니다. </br>

</br>
</br>

# HeapSort

## EXAMPLE

<img width="329" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/8d5224aa-e3b3-4357-9a4c-2b2f17a05a14">
</br>

다음과 같은 정렬되지 않은 배열을 오름차순으로 정렬하기 위해서는 힙 정렬힙(max heap)으로 변환해야 합니다. </br>

<img width="731" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/b0577a58-b4e3-40a8-beba-e106fd2a67ed">
<img width="893" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/366cdb4b-edd6-4f39-94de-eaf91ae48b70">

</br>

최대힙은 다음과 같습니다. </br>

단일 sift-down 연산의 시간복잡도는 O(log n)이므로 힙을 구축하는 전체 시간복잡도는 O(n log n)입니다. </br>

이제 배열을 오름차순으로 정렬하는 방법을 살펴보겠습니다. </br>

최대힙에서 가장 큰 요소는 항상 루트에 위치하기 때문에, 먼저 인덱스 0의 첫 번째 요소와 인덱스 n - 1의 마지막 요소를 교환합니다. </br>

교환 후에는 배열의 마지막 요소가 올바른 위치에 있지만 힙의 조건을 위배합니다. </br>

따라서 다음 단계는 새로운 루트 노드 5를 올바른 위치로 이동할 때까지 sift down하는 것입니다. </br>

<img width="340" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/998be4d3-e10d-4953-b361-c9953c353f53">

마지막 요소는 더 이상 힙의 일부가 아니라 정렬된 배열의 일부로 간주되므로, 힙의 마지막 요소를 제외합니다. </br>

5를 sift down한 결과로 두 번째로 큰 요소인 21이 새로운 루트가 됩니다. </br>

이제 이전 단계를 반복하여 21을 마지막 요소 6과 교환하고, 힙을 축소하고 6을 sift down합니다. </br>

<img width="373" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/d946bab4-43bf-46c1-ad8a-cc60a6790876">

힙 정렬은 매우 간단합니다. </br>

첫 번째와 마지막 요소를 교환하면서 더 큰 요소들이 올바른 순서로 배열의 뒷부분으로 이동합니다.</br>

교환하고 sift down하는 단계를 반복하여 힙의 크기가 1이 될 때까지 진행합니다.</br>

그러면 배열은 완전히 정렬됩니다.</br>
</br>

## Implementation

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
</br>

1. 먼저 힙의 복사본을 만듭니다. 힙 정렬은 원래의 배열을 정렬한 후에는 유효한 힙이 아닙니다. 힙의 복사본을 사용하여 원래의 힙이 유효하도록 보장합니다. </br>

2. 배열을 마지막 요소부터 반복합니다. </br>

3. 첫 번째 요소와 마지막 요소를 교환합니다. 이 교환은 정렬되지 않은 요소 중 가장 큰 요소를 올바른 위치로 이동시킵니다. </br>

4. 힙이 이제 유효하지 않으므로 새로운 루트 노드를 아래로 이동시켜야 합니다. 결과적으로 다음으로 큰 요소가 새로운 루트가 됩니다. </br></br>

# QuickSort
