# O(n²) Sorting Algorithms

O(n²) 시간 복잡성은 성능이 좋지 않지만, 이 범주의 정렬 알고리즘은 이해하기 쉽고 일부 시나리오에서 유용합니다. 이 알고리즘은 공간 효율적이다; 일정한 O(1) 추가 메모리 공간만 필요하다. 작은 데이터 세트의 경우, 이러한 종류는 더 복잡한 종류와 매우 유리하게 비교된다.

- Bubble sort
- Selection sort
- Insertion sort

이번 챕터에서 다룰 내용들이며 모두 비교 기반 정렬 방법이다. 이는 요소를 정렬하기 위해 연산자보다 적은 연산자와 같은 비교 방법에 의존한다. 이 비교가 호출되는 횟수는 정렬 기술의 일반적인 성능을 측정하는 방법입니다.

## Bubble sort

가장 간단한 정렬 중 하나는 인접한 값을 반복적으로 비교하고 필요한 경우 정렬을 수행하기 위해 교환하는 버블 정렬이다. 따라서, 세트의 더 큰 값은 컬렉션의 끝까지 “bubble up"될 것이다.

**예제**

`[9, 4, 10, 3]`의 컬렉션이 있다고 가정했을 때 버블 정렬 알고리즘의 싱글 패스는 다음 단계로 구성됩니다:

1. 컬렉션의 시작 부분에서 시작하세요. 9와 4를 비교하세요. 이 값들은 교환되어야 한다. 그 컬렉션은 [4, 9, 10, 3]이 된다.
2. 컬렉션의 다음 인덱스로 이동하세요. 9와 10을 비교하세요. 이것들은 순서대로 되어 있어.
3. 컬렉션의 다음 인덱스로 이동하세요. 10과 3을 비교하세요. 이 가치들은 교환되어야 한다. 그 컬렉션은 [4, 9, 3, 10]이 된다.

알고리즘의 단일 패스는 거의 결코 완전한 정렬을 결과로 내지 못합니다. 이 컬렉션에 대해서도 마찬가지입니다. 그러나 최대 값인 10은 컬렉션의 끝으로 올라갑니다.

이후 컬렉션에 대한 추가적인 패스는 각각 9와 4도 마찬가지로 수행합니다:

1 - [ 4, 9, 3, 10 ]
2 - [ 4, 3, 9, 10 ]
3 - [ 3, 4, 9, 10 ]

정렬은 어떠한 값도 교환하지 않고 컬렉션 전체를 통과할 수 있는 경우에만 완료됩니다. 최악의 경우에는 컬렉션의 멤버 수인 n-1 번의 패스가 필요합니다.

**구현**

BubbleSort.swift

```swift
public func bubbleSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  // 1 2개 미만의 요소가 있다면 컬렉션을 정렬할 필요가 없습니다.
  guard array.count >= 2 else {
    return
  }
  // 2 단일 패스는 최대값을 컬렉션의 끝으로 올립니다. 
  // 각 패스마다 이전 패스보다 하나 덜 값과 비교해야 하므로, 각 패스마다 배열을 하나씩 줄여나갑니다.
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

1. 2개 미만의 요소가 있다면 컬렉션을 정렬할 필요가 없습니다.
2. 단일 패스는 최대값을 컬렉션의 끝으로 올립니다. 각 패스마다 이전 패스보다 하나 덜 값과 비교해야 하므로, 각 패스마다 배열을 하나씩 줄여나갑니다.
3. 이 루프는 단일 패스를 수행합니다. 인접한 값들을 비교하고 필요한 경우에는 서로 교환합니다.
4. 만약 이 패스에서 값들이 교환되지 않았다면, 컬렉션은 이미 정렬되어 있으며 조기에 종료할 수 있습니다.

버블 정렬은 이미 정렬된 경우 `O(n)`의 최고 시간 복잡성과 `O(n²)`의 최악의 평균 시간 복잡성을 가지며, 이는 알려진 우주에서 가장 덜 매력적인 정렬 중 하나입니다.

## Selection sort

'Selection sort(선택 정렬)은 버블 정렬의 기본 아이디어를 따르지만 swapAt 작업의 수를 줄여 이 알고리즘을 개선합니다. 선택 정렬은 각 패스의 끝에서만 교환을 수행합니다. 다음 예제와 구현에서 그 작동 방식을 살펴보겠습니다.

**예제**

다음과 같은 카드가 있다고 가정해 봅시다:

[9, 4, 10, 3]

각 패스에서, 선택 정렬은 정렬되지 않은 값 중 가장 작은 값을 찾아서 해당 위치로 교환합니다:

1. 먼저, 3이 가장 작은 값으로 발견됩니다. 9와 교환됩니다.
2. 다음으로, 4가 가장 작은 값입니다. 이미 올바른 위치에 있습니다.
3. 마지막으로, 9와 10이 교환됩니다.

0 - [9, 4, 10, 3]
1 - [3, 4, 10, 9]
2 - [3, 4, 10, 9] 
3 - [3, 4, 9, 10]

**구현**

SelectionSort.swift

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

1. 마지막 요소를 제외한 컬렉션의 모든 요소에 대해 패스를 수행합니다. 마지막 요소는 포함할 필요가 없습니다. 왜냐하면 다른 모든 요소가 올바른 순서에 있다면 마지막 요소도 그렇기 때문입니다.
2. 각 패스에서, 남은 컬렉션을 통해 가장 작은 값을 가지는 요소를 찾습니다.
3. 만약 그 요소가 현재 요소와 다르다면, 둘을 교환합니다.

거품 정렬과 마찬가지로, 선택 정렬은 O(n²)의최선, 최악 및 평균 시간 복잡도가 O(n²)로 상당히 비효율적입니다. 하지만, 그것은 이해하기 쉬우며, 버블 정렬보다 성능이 좋습니다!

## Insert sort

삽입 정렬은 더 유용한 알고리즘입니다. 버블 정렬과 선택 정렬과 마찬가지로, 삽입 정렬의 평균 시간 복잡도는 O(n²)이지만 성능은 다양할 수 있습니다. 데이터가 이미 정렬되어 있을수록 삽입 정렬은 더 적은 작업을 수행해야 합니다. 데이터가 이미 정렬되어 있는 경우, 삽입 정렬의 최선 시간 복잡도는 O(n)입니다. Swift 표준 라이브러리의 sort 알고리즘은 정렬 접근 방식의 혼합해 사용하며, 삽입 정렬은 작은 (<20 요소) 정렬되지 않은 파티션에 사용됩니다.

**예제**

[9, 4, 10, 3]

삽입 정렬은 카드를 왼쪽에서 오른쪽으로 한 번씩 반복 순회합니다. 각 카드는 왼쪽으로 이동하여 올바른 위치에 도달할 때까지 이동합니다.

1 - [9, 4, 10, 3]
2 - [4, 9, 10, 3]
3 - [4, 9, 10, 3]
4 - [3, 4, 9, 10]

1. 비교할 이전 카드가 없기 때문에 첫 번째 카드를 무시할 수 있습니다.
2. 다음으로, 4를 9와 비교하고 9로 위치를 바꾸어 4를 왼쪽으로 이동하세요.
3. 10은 이전 카드에 비해 올바른 위치에 있기 때문에 바꿀 필요가 없습니다.
4. 마지막으로, 3은 각각 10, 9, 4와 비교하고 교환하여 전면으로 이동한다.

삽입 정렬의 최상의 경우는 값의 순서가 이미 정렬된 상태이며, 왼쪽으로의 이동이 필요하지 않을 때입니다. 이 점을 강조해야 합니다.

**구현**

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

1. 삽입 정렬은 한 번 왼쪽에서 오른쪽으로 반복 순회해야 합니다. 이 반복문이 그 역할을 수행합니다.
2. 여기서는 현재 인덱스부터 역으로 실행하여 필요한 만큼 왼쪽으로 이동할 수 있도록 합니다.
3. 필요한 만큼 요소를 왼쪽으로 계속 이동합니다. 요소가 위치에 들어오면 내부 루프를 중단하고 다음 요소로 넘어갑니다.

삽입 정렬은 데이터가 이미 정렬된 경우에는 가장 빠른 정렬 알고리즘 중 하나입니다. 이는 당연한 사실처럼 들릴 수 있지만, 모든 정렬 알고리즘에 대해서는 그렇지 않습니다. 실제로 많은 데이터 컬렉션은 이미 대부분 또는 완전히 정렬되어 있을 것이며, 삽입 정렬은 그러한 시나리오에서 탁월한 성능을 발휘합니다.

## Generalization 일반화

Array 이외의 컬렉션 유형에 대해서도 이러한 정렬 알고리즘을 일반화할 것입니다. 그러나 정확히 어떤 컬렉션 유형을 사용할 수 있는지는 알고리즘에 따라 다릅니다:

- 삽입 정렬은 요소를 이동할 때 컬렉션을 역으로 순회합니다. 따라서 컬렉션은 BidirectionalCollection 유형이어야 합니다.
- 버블 정렬과 선택 정렬은 컬렉션을 앞에서 뒤로 순회하므로 모든 Collection을 처리할 수 있어야 합니다.
- 어떤 경우에도 컬렉션은 MutableCollection 이어야 합니다. 요소를 교환할 수 있어야 하기 때문입니다.

BubbleSort.swift 수정 코드

```swift
public func bubbleSort<T>(_ collection: inout T)
    where T: MutableCollection, T.Element: Comparable {
  guard collection.count >= 2 else {
      return
  }
  for end in collection.indices.reversed() {
    var swapped = false
    var current = collection.startIndex
    while current < end {
      let next = collection.index(after: current)
      if collection[current] > collection[next] {
        collection.swapAt(current, next)
        swapped = true
      }
      current = next
    }
    if !swapped {
      return
    }
  }
}
```

알고리즘은 동일하게 유지됩니다; 컬렉션의 인덱스를 사용하기 위해 루프를 업데이트합니다. 

SelectionSort.swift 수정 코드

```swift
public func selectionSort<T>(_ collection: inout T)
    where T: MutableCollection, T.Element: Comparable {
  guard collection.count >= 2 else {
    return
  }
  for current in collection.indices {
    var lowest = current
    var other = collection.index(after: current)
    while other < collection.endIndex {
      if collection[lowest] > collection[other] {
        lowest = other
      }
      other = collection.index(after: other)
    }
    if lowest != current {
      collection.swapAt(lowest, current)
    }
  }
}
```

InsertionSort.swift 수정 코드

```swift
public func insertionSort<T>(_ collection: inout T)
    where T: BidirectionalCollection & MutableCollection,
          T.Element: Comparable {
  guard collection.count >= 2 else {
    return
  }
  for current in collection.indices {
    var shifting = current
    while shifting > collection.startIndex {
      let previous = collection.index(before: shifting)
      if collection[shifting] < collection[previous] {
        collection.swapAt(shifting, previous)
      } else {
        break
      }
      shifting = previous
    }
  }
}
```

## Key points

- n² 알고리즘들은 종종 형편없는 평판을 가지고 있습니다. 그럼에도 불구하고, 이러한 알고리즘 중 일부는 일반적으로 약간의 특징을 가지고 있습니다. 삽입 정렬은 컬렉션이 이미 정렬된 순서로 주어지고 점진적으로 O(n²)로 확장되는 경우 O(n) 시간에 정렬할 수 있습니다.
- 삽입 정렬은 데이터가 대부분 사전에 정렬되어 있음을 미리 알 수 있는 상황에서 가장 좋은 정렬 알고리즘 중 하나입니다.
