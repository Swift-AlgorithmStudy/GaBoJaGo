# O(n²) 정렬 알고리즘

O(n²) 시간 복잡성의 성능은 좋지 않지만, 이 종류의 정렬 알고리즘은 이해하기 쉽고 일부 시나리오에서 유용하다. 
이 알고리즘은 공간 효율적이다; 일정한 O(1)의 추가 메모리 공간만 필요하다. 작은 데이터 셋의 경우, 이러한 종류는 더 복잡한 종류와 매우 유리하게 비교된다.

이 장에서 다음과 같은 정렬 알고리즘을 살펴보자:

- 버블 정렬
- 선택 정렬
- 삽입 정렬

이것들은 모두 비교 기반 **comparison-based** 정렬 방법이다. 요소를 정렬하기 위해 less-tha n(<) 연산자와 같은 비교 방법에 의존한다. 이 비교가 호출되는 횟수는 정렬 기술의 일반적인 성능을 측정하는 방법이다.

## Bubble sort

가장 간단한 정렬 중 하나는 인접한 값을 반복적으로 비교하고 필요한 경우 정렬을 수행하기 위해 교환하는 버블 정렬이다. 따라서, 가장 큰 값은 컬렉션의 끝까지 "bubble up 거품이 될" 것이다.

### Example

다음과 같은 카드가 있다고 해보자:

<img width="599" alt="스크린샷 2023-06-12 오전 10 22 46" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/5829c3c2-d056-42a6-8a08-0ac47fd7f81c">

버블 정렬 알고리즘의 Single pass는 다음 단계로 구성된다:

- 컬렉션의 시작 부분에서 시작한다. 9와 4를 비교한다. 이 가치들은 교환되어야 한다. 그럼 컬렉션은 [4, 9, 10, 3]이 된다.
- 컬렉션의 다음 인덱스로 넘어간다. 9와 10을 비교해보면, 9와 10은 순서대로 되어 있다.
- 컬렉션의 다음 인덱스로 이동한하고 10과 3을 비교한다. 이 값들은 교환되어야 하므로, 컬렉션은 [4, 9, 3, 10]이 된다.

알고리즘의 single pass로는 거의 완전한 순서의 결과가 나오지 않으며, 이는 이 컬렉션도 해당된다. 그러나, 그것은 가장 큰 값인 10을 컬렉션의 끝까지 bubble up한다.

컬렉션을 통과하는 후속 정렬 과정은 각각 9와 4에 대해 똑같이 진행될 것이다:

<img width="550" alt="스크린샷 2023-06-12 오전 10 28 04" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/5d9d617b-283f-4fec-963c-54406e7d02b2">

정렬은 값을 교환하지 않고 컬렉션에 대한 전체 패스를 수행할 수 있을 때만 끝난다. 최악의 경우, 이것은 n-1번의 패스가 필요하며, 여기서 n은 컬렉션의 크기이다.

### Implementation

```swift
public func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
  // 1
  guard array.count >= 2 else { return }
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
    if !swapped { return }
  }
}
```

하나씩 봐보자:

1. 요소의 개수가 두 개 미만이라면 컬렉션을 정렬할 필요가 없다.
2. 싱글 패스는 컬렉션의 끝까지 가장 큰 가치를 bubble한다. 모든 패스는 이전 패스보다 하나 적은 개수를 비교해야 하므로, 본질적으로 각 패스마다 배열을 하나씩 단축할 수 있다.
3. 이 루프는 단일 패스를 수행한다; 인접한 값을 비교하고 필요한 경우 바꾼다.
4. 이 패스에 값이 교환되지 않았다면, 컬렉션을 정렬해야 하며, 일찍 종료할 수 있다.

테스트 코드:

```swift
example(of: "bubble sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  bubbleSort(&array)
  print("Bubble sorted: \(array)")
}

/* 
    ---Example of bubble sort---
    Original: [9, 4, 10, 3]
    Bubble sorted: [3, 4, 9, 10]
*/
```

버블 정렬은 이미 정렬된 경우 **O(n)의 최고 시간 복잡도와, O(n²)의 최악의 평균 시간 복잡도**를 가지며, 이는 우주에서 가장 덜 매력적인 종류 중 하나로 알려져 있다.

## Selection sort

선택 정렬은 버블 정렬의 기본 개념을 따르지만 `swapAt()` 작업의 수를 줄임으로써 이 알고리즘을 개선했다. 선택 정렬은 각 패스가 끝날 때만 swap된다. 다음 예제와 구현에서 그것이 어떻게 작동하는지 볼 수 있다.

### Example

다음과 같은 카드가 있다고 하자:

<img width="751" alt="스크린샷 2023-06-12 오전 11 30 04" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/67b67fe9-3ade-4a09-8354-3728010f8f6f">

각 패스 동안, 선택 정렬은 정렬되지 않은 가장 낮은 값을 찾아 제자리로 스왑한다:

1. 먼저, 3이 가장 낮은 값이므로 9로 바꾼다.
2. 다음으로 낮은 값은 4인데, 그건 이미 올바른 위치에 있다.
3. 마침내, 9는 10으로 스왑된다.

<img width="752" alt="스크린샷 2023-06-12 오전 11 30 20" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/90e9c6c1-ea8b-48a1-aeae-6bcdab0dc407">

### Implementation

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

코드 분석하기:

1. 마지막 요소를 제외한 컬렉션의 모든 요소에 대해 패스를 수행한다. 다른 모든 요소가 올바른 순서에 있다면, 마지막 요소도 마찬가지일 것이기 때문에 마지막 요소를 포함할 필요가 없다.
2. 모든 패스에서, 컬렉션의 나머지 부분을 통해 가장 낮은 값을 가진 요소를 찾는다.
3. 그 요소가 현재 요소가 아니라면, 그것들을 바꾸세요.

테스트 코드:

```swift
example(of: "selection sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  selectionSort(&array)
  print("Selection sorted: \(array)")
}

/*
    ---Example of selection sort---
    Original: [9, 4, 10, 3]
    Selection sorted: [3, 4, 9, 10]
 */
```

버블 정렬과 마찬가지로, 선택 정렬은 **O(n²)의 최고, 최악 및 평균 시간 복잡도**를 가지며, 이는 상당히 암울하다..ㅜ 하지만, 이해하기 쉬운 것이며, 버블 정렬보다 더 잘 작동한다!

## Insertion sort

삽입 정렬은 더 유용한 알고리즘이다. 버블 정렬 및 선택 정렬과 마찬가지로, **삽입 정렬의 평균 시간 복잡도는 O(n²)**이지만, 삽입 정렬의 성능은 다를 수 있다. 데이터가 이미 정렬될수록, 해야 할 일이 줄어든다. **데이터가 이미 정렬된 경우 삽입 정렬은 O(n)의 가장 좋은 시간 복잡도**를 가진다. 스위프트 표준 라이브러리 정렬 알고리즘은 정렬 접근 방식을 하이브리드로 사용하며, 작은 파티션(20개 이하의 요소)에는 삽입 정렬이 사용된다.

### Example

삽입 정렬의 아이디어는 손에 쥔 카드를 정렬하는 방법과 유사하다. 손에 다음과 같은 카드들이 있다:

<img width="751" alt="스크린샷 2023-06-13 오전 9 53 41" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/f30856c9-9f4f-45f4-99b4-8e70778ded8e">

삽입 정렬은 카드의 왼쪽에서 오른쪽으로 한 번 반복된다. 각 카드는 올바른 위치에 도달할 때까지 왼쪽으로 이동한다.

<img width="749" alt="스크린샷 2023-06-13 오전 9 54 17" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/7c086ad8-a9a6-41ab-a602-18e090da1d55">

1. 비교할 이전 카드가 없기 때문에 첫 번째 카드를 무시할 수 있다.
2. 다음으로, 4를 9와 비교하고 9로 위치를 바꾸어 4를 왼쪽으로 이동한요.
3. 10은 이전 카드에 비해 올바른 위치에 있기 때문에 바꿀 필요가 없다.
4. 마지막으로, 3은 각각 10, 9, 4와 비교하고 교환하여 가장 앞으로 이동한다.

삽입 정렬을 위한 가장 좋은 시나리오는 값의 순서가 이미 정렬된 순서로 정렬되어 있고 왼쪽 이동이 필요하지 않을 때 발생한다는 점을 짚어볼 가치가 있다.

### Implementation

```swift
public func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
  guard array.count >= 2 else { return }
  // 1
  for current in 1..<array.count {
    // 2
    for shifting in (1...current).reversed() {
      // 3
      if array[shifting] < array[shifting - 1] {
        array.swapAt(shifting, shifting - 1)
      } else { break }
    }
  }
}
```

코드 분석:

1. 삽입 정렬은 왼쪽에서 오른쪽으로 한 번 반복해야 한다. 이 루프는 그렇게 함.
2. 여기서, 현재 인덱스에서 뒤로 돌아가서 필요에 따라 왼쪽으로 이동할 수 있다.
3. 필요한 만큼 요소를 계속 옮긴다. 요소가 제자리에 도착하자마자, 내부 루프를 끊고 다음 요소로 시작하면 된다.

```swift
example(of: "insertion sort") {
  var array = [9, 4, 10, 3]
  print("Original: \(array)")
  insertionSort(&array)
  print("Insertion sorted: \(array)")
}
/*
    You should see the following console output:
    ---Example of insertion sort---
    Original: [9, 4, 10, 3]
    Insertion sorted: [3, 4, 9, 10]
*/
```

삽입 정렬은 데이터가 이미 정렬된 경우 가장 빠른 정렬 알고리즘 중 하나이다. 이는 명백하게 들릴지 모르지만, 모든 정렬 알고리즘에 대해서는 사실이 아니다. 실제로, 많은 데이터 컬렉션은 이미 완전히는 아니더라도 대부분 정렬될 것이며, 삽입 정렬은 이러한 시나리오에서 예외적으로 잘 수행될 것이다.

## Generalization

이 섹션에서는 배열 이외의 컬렉션 유형에 대한 이러한 정렬 알고리즘을 일반화할 것이다. 하지만 정확히 어떤 컬렉션 유형이냐에 따라 알고리즘에 달려 있다:

- 삽입 정렬은 요소를 이동할 때 컬렉션을 뒤로 가로지른다. 따라서, 컬렉션은 `BidirectionalCollection`이어야 합니다.
- 버블 정렬과 선택 정렬은 컬렉션을 앞뒤로만 통과하여 모든 `Collection`을 처리할 수 있다.
- 어쨌든, 요소를 스왑할 수 있어야 하기 때문에 컬렉션은 `MutableCollection`이어야 한다.

BubbleSort.swift로 돌아가서 기능을 다음과 같이 업데이트:

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

알고리즘은 동일하게 유지된다; 컬렉션의 인덱스를 사용하기 위해 루프를 업데이트한다.

선택 정렬은 다음과 같이 업데이트:

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

삽입 정렬은 이렇게 된다:

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

약간의 연습으로, 이러한 알고리즘을 일반화하는 것은 다소 기계적인 과정이 된다.

다음 장에서는 O(n²)보다 더 잘 작동하는 정렬 알고리즘을 살펴볼 것입니다. 다음은 분할과 정복으로 알려진 고전적인 접근 방식을 사용하는 정렬 알고리즘입니다 - Merge sort!

## 🔑 Key points

- N² 알고리즘은 종종 끔찍한 평판을 가지고 있다. 여전히, 이러한 알고리즘 중 일부는 보통 몇 가지 상환 포인트를 가지고 있다. 컬렉션이 이미 정렬된 순서이고 점차적으로 O(n²)로 축소되는 경우 삽입 정렬은 O(n) 시간으로 정렬할 수 있다.
- 삽입 정렬은 데이터가 대부분 미리 정렬된 순서로 정렬되어 있다는 것을 알고 있는 상황에서 가장 좋은 종류 중 하나이다.
