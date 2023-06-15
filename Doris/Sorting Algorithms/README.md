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

