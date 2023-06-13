# O(n^2) Sorting Algorithms

O(n^2)의 시간 복잡도는 좋은 성능은 아니지만, 이번 장에서 배울 정렬 알고리즘은 이해하기 쉽고 어떠한 경우에서는 유용할 것입니다. 

이 알고리즘은 메모리 공간을 O(1)만큼만을 차지하기 떄문에 공간이 효율적입니다. 작은 데이터셋에서는 이러한 정렬이 다른 복잡한 정렬보다 유리합니다.

이번 장에서는 아래의 정렬 알고리즘에 대해 배울 것입니다.

- 버블 정렬 (Bubble sort)
- 선택 정렬 (Selection sort)
- 삽입 정렬 (Insertion sort)

위 들은 모두 comparison-based 정렬 메소드들입니다. 저것들은 less-than 연산과 같이 요소들을 정렬하는 비교 메소드에 의존합니다. 이 비교 연산이 불리는 횟수가 정렬 기술의 성능을 나타내줍니다.

## Bubble sort

가장 직관적인 정렬은 버블 정렬로, 정렬을 하기 위해 반복적으로 인접한 값들을 비교하여 필요하다면 스왑합니다.

그러므로, 가장 큰 값은 컬렉션의 끝에서 “bubble up”이 될 것입니다.

### Example

<img width="391" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/9575269d-010d-4040-a1d9-dafca3d021f8">

버블 정렬 알고리즘의 단일 단계는 이러한 단계를 포함하고 있습니다.

- 컬렉션의 처음부터 시작합니다.
9와 4를 비교합니다.
두 값들은 스왑되어야 합니다.
컬렉션은 [4, 9, 10, 3]이 됩니다.
- 컬렉션의 다음 인덱스로 넘어갑니다. 
9와 10을 비교합니다.
이는 순서대로 되어있습니다.
- 컬렉션의 다음 인덱스로 넘어갑니다.
10과 3을 비교합니다.
두 값들은 스왑되어야 합니다.
컬렉션은 [4, 9, 3, 10]이 됩니다.

- 두 요소끼리 비교하여 스왑

한 번의 진행을 통해 완전히 정렬되는 경우는 거의 없습니다. 
하지만 가장 큰 값인 10은 컬렉션의 마지막에 도달(bubble up)하였습니다.

9과 4에 대해서도 똑같이 진행될 것입니다.

정렬은 모든 단계에서 스왑되어야 하는 값이 없을 때 완료됩니다. 
최악의 경우에는 컬렉션 요소의 개수가 n일 때 n-1번의 단계가 필요할 수도 있습니다.

## Implementation

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

1. 만약 2개 미만의 요소만 가지고 있다면 컬렉션을 정렬할 필요가 없습니다.
2. 한 번의 버블 순회는 가장 큰 값을 컬렉션의 끝으로 옮겨줍니다. 모든 순회는 이전 순회보다 하나 더 적은 값을 비교해야 하기 때문에, 각 순회마다 배열을 하나씩 줄입니다.
3. 루프는 한 번의 순회를 수행합니다. 이는 근접한 값을 비교해주고 만약 필요하다면 스왑해줍니다.
4. 만약 아무 값도 스왑이 되지 않았다면, 컬렉션은 정렬이 된 것으로 빠르게 탈출할 수 있습니다.

```swift
example(of: "bubble sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  bubbleSort(&array)
  print("Bubble sorted: \(array)")
}

---Example of bubble sort---
Original: [9, 4, 10, 3]
Bubble sorted: [3, 4, 9, 10]
```

버블 정렬은 미리 정렬되어 있다면 O(n)의 시간 복잡도를 가지며, 최악이나 평균 O(n^2)의 시간 복잡도를 가짐으로 사용하는 데에 메리트가 없습니다.

## Selection sort

선택 정렬은 버블 정렬의 기본 아이디어를 따라가지만, swapAt 연산의 수를 줄여 성능을 향상시켰습니다. 
선택 정렬은 각 순회의 마지막에서 스왑을 진행합니다.

### Example

<img width="437" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5de65e12-505c-469e-bea0-2ebcbf0b3948">

각 순회 동안, 선택 정렬은 정렬되어있지 않는 가장 낮은 값을 찾고 스왑합니다.

1. 처음에 3이 가장 낮은 값이기 때문에 9와 스왑합니다.
2. 그다음으로 낮은 값은 4인데, 이미 올바른 자리에 들어가있습니다.
3. 마지막으로, 9는 10과 스왑됩니다.

- 가장 작은 요소를 찾은 뒤, 현재 인덱스를 가장 작은 요소와 스왑함

<img width="362" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/902973a0-5c16-474f-816a-4b0a10c0e6ab">


## Implementation

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

1. 마지막을 제외한 모든 컬렉션 요소를 지나갑니다. 마지막을 제외한 모든 요소가 정확하게 정렬되어 있다면 마지막 또한 제대로 되어있기 때문에 마지막 요소를 추가할 필요가 없습니다.
2. 모든 순환에서 가장 낮은 값을 가진 요소를 찾기 위해 나머지 컬렉션을 거칩니다.
3. 만약 해당 요소가 현재 요소가 아니라면, 스왑합니다.

```swift
example(of: "selection sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  selectionSort(&array)
  print("Selection sorted: \(array)")
}

---Example of selection sort---
Original: [9, 4, 10, 3]
Selection sorted: [3, 4, 9, 10]
```

버블 정렬과 같이 선택 정렬은 O(n^2)의 시간 복잡도를 가지는데, 이는 상당히 암울합니다. 
하지만 이해하기 쉽고 버블 정렬보다는 좋은 성능을 보여줍니다.

## Insertion sort

삽입 정렬은 더욱 유용한 알고리즘입니다. 버블 정렬과 선택 정렬과 같이, 삽입 정렬은 평균 O(n^2)의 시간 복잡도를 가지지만, 성능은 매우 달라질 수 있습니다. 많은 데이터가 정렬되어 있을 수록 해야 할 일이 줄어듭니다. 
만약 데이터가 이미 정렬되어 있다면 최고 O(n)의 시간 복잡도를 가집니다. 스위프트 표준 라이브러리의 정렬 알고리즘은 정렬 방법의 혼합을 사용하며, 정렬되지 않은 작은 파티션(20개 미만의 요소)에 삽입 정렬이 사용됩니다.

삽입 정렬은 왼쪽에서 오른쪽으로 한 번 반복됩니다. 각 카드는 올바른 위치에 도달할 때까지 왼쪽으로 이동합니다. 

<img width="372" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/20e28b7e-1e8f-4e1e-a802-e80321fb0747">

1. 비교할 대상이 없기 때문에 첫 번째 카드는 무시해도 됩니다.
2. 다음으로 4를 9와 비교한 뒤 4를 9가 있는 위치(왼쪽)로 스왑합니다.
3. 이전 카드와 비교했을 때 올바른 위치에 있기 때문에 10은 스왑할 필요가 없습니다.
4. 마지막으로, 3은 10, 9, 4와 비교하면서 가장 앞쪽으로 이동합니다.

삽입 정렬의 최상의 시나리오는 이미 정렬되어 있을 때인데, left shifting이 필요없기 때문입니다.

- 현재 인덱스가 왼쪽 인덱스 값보다 작으면 왼쪽으로 계속 이동시킴

## Implementation

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

1. 삽입 정렬은 왼쪽에서 오른쪽으로 반복하도록 합니다.
2. 현재 인덱스부터 뒤로 진행하면서 필요하다면 왼쪽 이동(shift left)을 할 수 있도록 합니다.
3. 필요한 만큼 요소를 왼쪽으로 이동시킵니다. 요소가 해당 위치에 도달했다면, 안쪽 루프에서 벗어나 새로운 요소를 다음 요소를 시작합니다.

```swift
example(of: "insertion sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  insertionSort(&array)
  print("Insertion sorted: \(array)")
}

---Example of insertion sort---
Original: [9, 4, 10, 3]
Insertion sorted: [3, 4, 9, 10]
```

## Generalization

이번 섹션에서는 배열 이외의 다른 컬렉션 타입을 위해 일반화할 것입니다.

- 삽입 정렬은 요소를 이동시킬 때 컬렉션의 뒤로 순회합니다. 
그렇기 때문에 컬렉션은 BidirectionalCollection 타입이어야 합니다.
- 버블 정렬과 선택 정렬은 어떠한 컬렉션도 다룰 수 있어야 하기 때문에 앞에서 뒤로만 순회합니다.
- 어떠한 경우에서든지 컬렉션은 요소를 스왑할 수 있어야 하기 때문에 MutableCollection이어야 합니다.

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

알고리즘은 똑같습니다. 컬렉션의 인덱스를 사용하기 위해 루프를 업데이트합니다. 

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

다음 장에서는 O(n^2)보다 좋은 성능을 가진 정렬 알고리즘을 배울 예정입니다. 
다음은 분할정복(divide and conquer)이라는 고전적인 방법을 사용하는 합병 정렬을 사용할 것입니다.

## Key points

- n^2 알고리즘은 불필요한 반복을 가집니다. 
하지만 이 알고리즘은 장점을 가질 수 있는데, 컬렉션이 이미 정렬되어 있다면 O(n) 시간만 사용하면 됩니다.
