# Chapter 26: O(n^2) Sorting Algorithms

O(n^2) 시간 복잡도는 성능이 크게 좋지 않지만, 이 범주에 속하는 정렬 알고리즘들은 이해하기 쉽고 특정 시나리오에서 유용합니다.

이러한 알고리즘들은 공간 효율적이며, 상수 시간복잡도인 O(1)의 추가 메모리 공간만 필요합니다.

작은 데이터셋의 경우, 이러한 정렬들은 더 복잡한 정렬에 비해 매우 우수한 성능을 보입니다.

이 장에서는 다음과 같은 정렬 알고리즘들을 살펴볼 것입니다:

- 버블 정렬 (Bubble sort)
- 선택 정렬 (Selection sort)
- 삽입 정렬 (Insertion sort)

이 모두 비교 기반의 정렬 방법입니다.

이들은 원소를 정렬하기 위해 작은지 여부를 비교하는 방법에 의존합니다.

정렬 기법의 일반적인 성능을 측정하는 방법은 이러한 비교 호출 횟수입니다.

# 버블 정렬(Bubble sort)

가장 간단한 정렬 중 하나는 버블 정렬(Bubble sort)입니다.

이 정렬은 반복적으로 인접한 값들을 비교하고 필요한 경우에는 값들을 교환하여 정렬을 수행합니다.

따라서, 집합 내에서 큰 값들은 "거품처럼" 컬렉션의 끝으로 올라갑니다.

## 예시

<img width="500" alt="스크린샷 2023-06-10 오후 3 15 01" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/f1feae93-729b-4c50-8cf0-4f303712b128">

버블 정렬 알고리즘의 단일 패스는 다음과 같은 단계로 구성됩니다:

1. 컬렉션의 시작부터 시작합니다. 9와 4를 비교합니다. 이 값들은 교환되어야 합니다. 그 결과 컬렉션은 [4, 9, 10, 3]이 됩니다.
2. 다음 인덱스로 이동합니다. 9와 10을 비교합니다. 이들은 순서대로 정렬되어 있습니다.
3. 컬렉션의 다음 인덱스로 이동합니다. 10과 3을 비교합니다. 이 값들은 교환되어야 합니다. 그 결과 컬렉션은 [4, 9, 3, 10]이 됩니다.

알고리즘의 단일 패스는 거의 항상 완전한 정렬을 얻지 못할 것이며, 이 컬렉션에도 그렇습니다.

그러나 이는 가장 큰 값인 10이 컬렉션의 끝으로 올라가도록 만들어줍니다.

이후의 패스에서는 각각 9와 4가 동일한 과정을 거치게 됩니다.

<img width="600" alt="스크린샷 2023-06-10 오후 3 15 32" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/1f53a490-6296-4ca3-bdb5-eff0a7e967a9">

## 구현

정렬은 컬렉션 내의 값들을 교환하지 않고 전체 패스를 수행할 수 있을 때에만 완료됩니다.

최악의 경우, 이는 컬렉션의 구성원 수를 나타내는 n에 대해 n-1번의 패스가 필요합니다.

```swift
public func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
	// 컬렉션의 요소가 2개 미만이면 정렬할 필요가 없습니다.
	guard array.count >= 2 else { return }
	// 단일 패스는 가장 큰 값을 컬렉션의 끝으로 올립니다.
	// 각 패스마다 이전 패스보다 하나 덜 값을 비교해야 하므로, 패스마다 배열의 길이가 하나씩 줄어듭니다.
	for end in (1..<array.count).reversed() {
		var swapped = false
		// 이 루프는 단일 패스를 수행합니다. 인접한 값들을 비교하고 필요한 경우에는 교환합니다.
		for current in 0..<end {
			if array[current] > array[current + 1] {
				array.swapAt(current, current + 1)
				swapped = true
			}
		}
		// 만약 이번 패스에서 값이 교환되지 않았다면, 컬렉션이 정렬되었다는 것이므로 조기에 종료할 수 있습니다.
		if !swapped { return }
	}
}

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

버블 정렬은 최선의 경우, 즉 이미 정렬되어 있는 경우에는 O(n)의 시간 복잡도를 갖지만, 최악 및 평균의 경우에는 O(n^2)의 시간 복잡도를 가집니다. 따라서, 이는 알려진 정렬 알고리즘 중에서는 가장 선호되지 않는 정렬 중 하나입니다.

# 선택 정렬(Selection sort)

선택 정렬은 버블 정렬의 기본 아이디어를 따르지만 swapAt 연산의 수를 줄여 이 알고리즘을 개선합니다. 선택 정렬은 각 패스의 끝에서만 교환 연산을 수행합니다. 다음의 예제와 구현을 통해 그 방법을 살펴보겠습니다.

## 예시

다음과 같은 카드 패를 가정해 보겠습니다:

<img width="500" alt="스크린샷 2023-06-10 오후 3 19 59" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/b8da72a4-0475-4a42-8723-f867ea4af145">


각 패스에서 선택 정렬은 정렬되지 않은 값들 중에서 가장 작은 값을 찾아 해당 위치로 교환합니다:

1. 첫 번째로, 3이 가장 작은 값으로 발견됩니다. 3은 9와 교환됩니다.
2. 다음으로, 4가 가장 작은 값입니다. 이미 올바른 위치에 있습니다.
3. 마지막으로, 9가 10과 교환됩니다.

## 구현

```swift
public func selectionSort<Element>(_ array: inout [Element]) where Element: Comparable {
	guard array.count >= 2 else { return }
	// 컬렉션의 각 요소에 대해 마지막 요소를 제외하고 패스를 수행합니다.
	// 다른 모든 요소가 올바른 순서에 있으면 마지막 요소도 올바른 순서에 있을 것이기 때문에 마지막 요소를 포함할 필요가 없습니다.
	for current in 0..<(array.count - 1) {
		var lowest = current
		// 각 패스에서 남은 컬렉션을 탐색하여 가장 작은 값을 가진 요소를 찾습니다.
		for other in (current + 1)..<array.count {
			if array[lowest] > array[other] {
				lowest = other
			}
		}
		// 그 요소가 현재 요소와 다르다면 서로 교환합니다.
		if lowest != current {
			array.swapAt(lowest, current)
		}
	}
}

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

마찬가지로 선택 정렬도 최선, 최악 및 평균 시간 복잡도가 O(n^2)로, 상당히 좋지 않습니다. 그러나 이해하기 쉽고, 버블 정렬보다는 성능이 향상됩니다!

# 삽입 정렬(**Insertion sort)**

삽입 정렬은 더 유용한 알고리즘입니다. 버블 정렬과 선택 정렬과 마찬가지로, 삽입 정렬의 평균 시간 복잡도는 O(n^2)입니다. 그러나 삽입 정렬의 성능은 다양할 수 있습니다. 데이터가 이미 정렬되어 있는 경우, 삽입 정렬은 더 적은 작업이 필요하게 됩니다. 데이터가 이미 정렬되어 있는 경우, 삽입 정렬의 최선의 시간 복잡도는 O(n)입니다. Swift 표준 라이브러리의 정렬 알고리즘은 정렬 방식의 하이브리드를 사용하며, 작은 (<20 요소) 정렬되지 않은 파티션에 대해서는 삽입 정렬을 사용합니다.

## 예시

삽입 정렬의 아이디어는 카드 패를 정렬하는 방법과 유사합니다. 다음과 같은 카드 패를 고려해 보세요:

<img width="500" alt="스크린샷 2023-06-10 오후 3 24 27" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/3f994adf-bd47-4459-a1ef-4f0c740e448f">

삽입 정렬은 카드를 왼쪽에서 오른쪽으로 한 번씩 반복하여 진행합니다. 각 카드는 자신의 올바른 위치에 도달할 때까지 왼쪽으로 이동합니다.

<img width="600" alt="스크린샷 2023-06-10 오후 3 26 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/ea8effba-1216-447b-b295-0c8d75a51e27">

1. 첫 번째 카드는 이전 카드와 비교할 것이 없으므로 무시할 수 있습니다.
2. 다음으로, 4를 9와 비교하고, 4를 왼쪽으로 이동하기 위해 9와 위치를 교환합니다.
3. 10은 이전 카드와 비교했을 때 올바른 위치에 있기 때문에 이동할 필요가 없습니다.
4. 마지막으로, 3은 각각 10, 9, 4와 비교하고 교환하여 앞쪽으로 이동합니다.

삽입 정렬에서 최선의 경우는 값의 순서가 이미 정렬되어 있고 왼쪽 이동이 필요하지 않을 때입니다.

## 구현

```swift
public func insertionSort<Element>(_ array: inout [Element]) where Element: Comparable {
	guard array.count >= 2 else { return }
	// 삽입 정렬은 한 번씩 왼쪽에서 오른쪽으로 이터레이션해야 합니다. 이 반복문은 그 역할을 합니다.
	for current in 1..<array.count {
		// 여기서는 현재 인덱스부터 역으로 진행하여 필요에 따라 왼쪽으로 이동할 수 있도록 합니다.
		for shifting in (1...current).reversed() {
			// 요소가 필요한 만큼 왼쪽으로 이동시키세요. 요소가 올바른 위치에 도달하면 내부 루프를 종료하고 다음 요소로 시작하세요.
			if array[shifting] < array[shifting - 1] {
				array.swapAt(shifting, shifting - 1)
			} else {
				break
			}
		}
	}
}

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

삽입 정렬은 데이터가 이미 정렬되어 있는 경우 가장 빠른 정렬 알고리즘 중 하나입니다. 이는 당연한 사실처럼 들릴 수도 있지만, 모든 정렬 알고리즘에 대해서는 참이 아닙니다. 실제로 많은 데이터 컬렉션은 이미 대부분 또는 완전히 정렬되어 있을 수 있으며, 이러한 시나리오에서 삽입 정렬은 탁월한 성능을 발휘합니다.

# Generalization

이 섹션에서는 Array 이외의 컬렉션 타입에 대해서도 이러한 정렬 알고리즘을 일반화할 것입니다. 그러나 정확히 어떤 컬렉션 타입을 사용할 수 있는지는 알고리즘의 요구 사항에 따라 다릅니다:

- 삽입 정렬: 요소를 이동할 때 컬렉션을 역방향으로 순회합니다. 따라서 컬렉션은 BidirectionalCollection 유형이어야 합니다.
- 버블 정렬과 선택 정렬: 이 알고리즘들은 컬렉션을 앞에서부터 뒤로 순회합니다. 따라서 어떤 Collection 유형이든 다룰 수 있습니다.
- 어떤 경우에도 컬렉션은 MutableCollection 이어야 합니다. 요소를 교환할 수 있어야 하기 때문입니다.

```swift
public func bubbleSort<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
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

```swift
public func selectionSort<T>(_ collection: inout T) where T: MutableCollection, T.Element: Comparable {
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

```swift
public func insertionSort<T>(_ collection: inout T) where T: BidirectionalCollection & MutableCollection, T.Element: Comparable {
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

조금의 연습을 통해 이러한 알고리즘들을 일반화하는 것은 다소 기계적인 과정이 됩니다. 다음 장에서는 O(n^2)보다 더 나은 성능을 발휘하는 정렬 알고리즘을 살펴볼 것입니다. 다음은 분할 정복이라고 알려진 고전적인 접근 방식을 사용하는 정렬 알고리즘인 합병 정렬입니다.

# **Key points**

- O(n^2) 알고리즘들은 종종 좋지 않은 평판을 가지고 있습니다. 그러나 이러한 알고리즘들 중 일부는 보완할 만한 특징을 가지고 있습니다. 삽입 정렬은 컬렉션이 이미 정렬된 상태인 경우 O(n)의 시간 복잡도로 정렬할 수 있으며, 점진적으로 O(n^2)로 확장됩니다.
- 삽입 정렬은 데이터가 대부분 미리 정렬된 상태인 것을 알고 있을 때 가장 좋은 정렬 중 하나입니다.