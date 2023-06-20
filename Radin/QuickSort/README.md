# Chap16. Quicksort

이전 장에서, 당신은 병합 정렬 및 힙 정렬과 같은 비교 기반 정렬 알고리즘을 사용하여 배열을 정렬하는 방법을 배웠습니다.

**Quicksort**는 또 다른 비교 기반 정렬 알고리즘이다. 병합 정렬과 마찬가지로, 그것은 **분할과 정복**의 동일한 전략을 사용한다. 퀵 정렬의 중요한 특징 중 하나는 **피벗 포인트를 선택**하는 것이다. 피벗은 배열을 세 개의 파티션으로 나눕니다:

[ elements < pivot | pivot | elements > pivot ]

이 장에서는 퀵 정렬을 구현하고 이 정렬 알고리즘을 최대한 활용하기 위해 다양한 분할 전략을 살펴볼 것입니다.

## Example

```swift
//quicksortNaive.swift
public func quicksortNaive<T: Comparable>(_ a: [T]) -> [T] {
  guard a.count > 1 else { // 1
    return a
  }
  let pivot = a[a.count / 2] // 2
  let less = a.filter { $0 < pivot } // 3
  let equal = a.filter { $0 == pivot }
  let greater = a.filter { $0 > pivot }
  return quicksortNaive(less) + equal + quicksortNaive(greater) // 4
}
```

위의 구현은 배열을 세 개의 파티션으로 재귀적으로 필터링한다. 그것이 어떻게 작동하는지 봅시다:

1. 배열에는 하나 이상의 요소가 있어야 한다. 그렇지 않다면, 배열은 정렬된 것으로 간주됩니다.
2. 배열의 중간 요소를 피벗으로 선택하세요.
3. 피벗을 사용하여, 원래 배열을 세 개의 파티션으로 나누세요. 피벗보다 작거나 같거나 큰 요소는 다른 버킷으로 들어간다.
4. 파티션을 재귀적으로 정렬한 다음 결합하세요.

이제 위의 코드를 시각화해 봅시다. 정렬되지 않은 배열이 주어집니다.

[12, 0, 3, 9, 2, 18, 8*, 27, 1, 5, 8, -1, 21]

이 구현의 파티션 전략은 항상 중간 요소를 피벗으로 선택하는 것입니다. 이 경우, 피벗은 8이다. 이 피벗을 사용하여 배열을 분할하면 다음과 같은 파티션이 생깁니다:

less: [0, 3, 2, 1, 5, -1]
equal: [8, 8]
greater: [12, 9, 18, 27, 21]

세 개의 파티션이 아직 완전히 정렬되지 않았다는 것을 주목하세요. 퀵소트는 이 파티션들을 더 작은 파티션으로 재귀적으로 나눌 것이다. 재귀는 모든 파티션에 0 또는 1개의 요소가 있을 때만 중단됩니다.

다음은 모든 분할 단계에 대한 개요입니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/631dc5cd-4aaf-455c-9507-87985de359a3)

각 레벨은 퀵 정렬에 대한 재귀 호출에 해당한다. 재귀가 멈추면, 잎이 다시 결합되어 완전히 정렬된 배열이 된다:

[-1, 1, 2, 3, 5, 8, 8, 9, 12, 18, 21, 27]

이 구현은 이해하기 쉽지만, 몇 가지 문제와 질문을 제기한다:

- 같은 배열에서 필터를 세 번 호출하는 것은 효율적이지 않다.
- 모든 파티션에 대해 새로운 배열을 만드는 것은 공간 효율적이지 않다. 제자리에서 정리하면 안되나요?
- 중간 요소를 고르는 것이 최고의 피벗 전략인가요? 어떤 피벗 전략을 채택해야 하나요?

## Partitioning strategies

이 섹션에서는 분할 전략과 이 퀵 정렬 구현을 보다 효율적으로 만드는 방법을 살펴볼 것입니다. 
첫 번째 분할 알고리즘은 Lomuto의 알고리즘입니다.

### **로무토의 분할**

Lomuto의 분할 알고리즘은 항상 마지막 요소를 피벗으로 선택합니다. 

- 이 함수는 세 가지 인수를 취한다:
    - a는 분할하고 있는 배열입니다.
    - low과 high은 분할할 배열 내의 범위를 설정합니다. 이 범위는 재귀할 때마다 점점 더 작아질 것이다.
- 함수는 피벗의 인덱스를 반환한다.

```swift
//quicksortLomuto.swift
public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	let pivot = a[high] // 1
	
	var i = low // 2
	for j in low..<high { // 3
	  if a[j] <= pivot { // 4
	    a.swapAt(i, j) // 5
	    i += 1
	  }
	}
	
	a.swapAt(i, high) // 6
	return i // 7
}
```

1. 피벗을 설정하세요 → Lomuto는 항상 **마지막 요소를 피벗으로 선택**한다.
2. 변수 i는 얼마나 많은 요소가 피벗보다 작은지를 나타낸다. 피벗보다 작은 요소를 만나면, 인덱스 i의 요소로 바꾸고 i를 늘릴겁니다.
3. 낮은 것부터 높은 것까지 모든 요소를 반복하지만, 피벗이기 때문에 high은 포함하지 않는다.
4. 현재 요소가 피벗보다 작거나 같은지 확인하세요.
5. 만약 그렇다면, 인덱스 i의 요소로 바꾸고 i를 늘리세요.
6. 루프가 끝나면, i의 요소를 피벗으로 바꾸세요. 피벗은 항상 더 적고 더 큰 파티션 사이에 있다.
7. 피벗의 인덱스를 반환하세요.

이 알고리즘이 배열을 반복하는 동안, 배열을 네 개의 영역으로 나눕니다:

1. a[low..<i]는 모든 요소 <= 피벗을 포함한다.
2. a[i...j-1]은 모든 요소 > 피벗을 포함한다.
3. a[j...high-1]는 아직 비교하지 않은 요소입니다.
4. a[high]는 피벗 요소이다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/7f2d9475-78be-437b-ba7e-e55a66d80001)


```swift
public func quicksortLomuto<T: Comparable>(_ a: inout [T],
                                           low: Int, high: Int) {
  if low < high {
    let pivot = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: pivot - 1)
    quicksortLomuto(&a, low: pivot + 1, high: high)
  }
}
```

여기서 Lomuto의 알고리즘을 적용하여 배열을 두 영역으로 분할한 다음, 이러한 영역을 재귀적으로 정렬합니다. 재귀는 한 영역이 두 개 미만의 요소를 가지면 끝난다.

 Lomuto의 퀵 정렬을 시도해 볼까요?

```swift
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)
```

### **Hoare’s partitioning**

Hoare의 분할 알고리즘은 항상 첫 번째 요소를 피벗으로 선택합니다. 이것이 코드에서 어떻게 작동하는지 봅시다.

```swift
//quicksortHoare.swift
public func partitionHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) -> Int {
  let pivot = a[low] // 1
  var i = low - 1 // 2
  var j = high + 1

  while true {
    repeat { j -= 1 } while a[j] > pivot // 3
    repeat { i += 1 } while a[i] < pivot // 4

    if i < j { // 5
      a.swapAt(i, j)
    } else {
      return j // 6
    }
  }
}

```

1. 첫 번째 요소를 피벗으로 선택하세요.
2. 인덱스 i와 j는 두 영역을 정의한다. 나 이전의 모든 인덱스는 피벗보다 작거나 같을 것이다. J 이후의 모든 인덱스는 피벗보다 크거나 같을 것이다.
3. 피벗보다 크지 않은 요소에 도달할 때까지 j를 줄이세요.
4. 피벗보다 적지 않은 요소에 도달할 때까지 i를 늘리세요.
5. I와 j가 겹치지 않았다면, 요소를 바꾸세요.
6. 두 지역을 구분하는 인덱스를 반환합니다.

<aside>
💡 참고: 파티션에서 반환된 인덱스가 반드시 피벗 요소의 인덱스일 필요는 없습니다.

</aside>

Lomuto의 알고리즘에 비해 스왑이 훨씬 적다. 

이제 quicksortHoare 기능을 구현할 수 있습니다:

```swift
public func quicksortHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) {
  if low < high {
    let p = partitionHoare(&a, low: low, high: high)
    quicksortHoare(&a, low: low, high: p)
    quicksortHoare(&a, low: p + 1, high: high)
  }
}
```

```swift
var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortHoare(&list2, low: 0, high: list.count - 1)
print(list2)
```

### !! 잘못된 피벗 선택의 영향

퀵소트 구현의 가장 중요한 부분은 올바른 분할 전략을 선택하는 것이다.

당신은 세 가지 다른 분할 전략을 살펴보았습니다:

1. 중간 요소를 피벗으로 선택하기.
2. Lomuto, 또는 마지막 요소를 피벗으로 선택하기.
3. 호어, 또는 첫 번째 요소를 피벗으로 선택하기.

나쁜 피벗을 선택하는 것은 어떤 의미인가요?

다음과 같은 정렬되지 않은 배열로 시작합시다:

[8, 7, 6, 5, 4, 3, 2, 1]

로무토의 알고리즘을 사용하면, 피벗이 마지막 요소인 1이 될 것이다. 이것은 다음과 같은 파티션을 초래한다:

less: [ ]
equal: [1]
greater: [8, 7, 6, 5, 4, 3, 2]

이상적인 피벗은 파티션보다 작은 것과 큰 것 사이에서 요소를 고르게 나눌 것이다. 이미 정렬된 배열의 첫 번째 또는 마지막 요소를 피벗으로 선택하면 퀵 정렬은 삽입 정렬과 매우 비슷하며, 이로 인해 최악의 성능은 O(n²)입니다. 이 문제를 해결하는 한 가지 방법은 세 가지 피벗 선택 전략의 중앙값을 사용하는 것이다. 여기서, 당신은 배열의 첫 번째, 중간 및 마지막 요소의 중앙값을 찾고 그것을 피벗으로 사용합니다. 이 선택 전략은 배열에서 가장 높거나 가장 낮은 요소를 선택하는 것을 방지합니다.

구현

```swift
//quicksortMedian.swift
public func medianOfThree<T: Comparable>(_ a: inout [T],
                                         low: Int, high: Int) -> Int {
  let center = (low + high) / 2
  if a[low] > a[center] {
    a.swapAt(low, center)
  }
  if a[low] > a[high] {
    a.swapAt(low, high)
  }
  if a[center] > a[high] {
    a.swapAt(center, high)
  }
  return center
}
```

여기서, 당신은 그것들을 정렬하여 a[낮음], a[중앙] 및 a[높음]의 중앙값을 찾을 수 있습니다. 중앙값은 인덱스 센터에서 끝날 것이며, 이는 함수가 반환하는 것이다.

다음으로, 이 세 개의 중앙값을 사용하여 Quicksort의 변형을 구현해 봅시다:

```swift
public func quickSortMedian<T: Comparable>(_ a: inout [T],
                                           low: Int, high: Int) {
  if low < high {
    let pivotIndex = medianOfThree(&a, low: low, high: high)
    a.swapAt(pivotIndex, high)
    let pivot = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: pivot - 1)
    quicksortLomuto(&a, low: pivot + 1, high: high)
  }
}
```

이 코드는 단순히 첫 번째 단계로 세 요소의 중앙값을 선택하는 quicksortLomuto의 변형이다.

**네덜란드 국기 분할 Dutch national flag partitioning**

Lomuto 알고리즘과 Hoare 알고리즘의 문제는 중복 처리를 잘 다루지 못한다는 것입니다. Lomuto 알고리즘의 경우, 중복 값은 '작은 값' 분할에 들어가게 되며 함께 그룹화되지 않습니다. Hoare 알고리즘의 경우 상황은 더욱 악화되어 중복 값이 여기저기 흩어질 수 있습니다.

중복 요소를 정리하기 위한 한 가지 해결책은 네덜란드 국기 분할(Dutch national flag partitioning)을 사용하는 것입니다. 이 기술은 네덜란드 국기에서 이름을 딴 것으로, 빨간색, 흰색, 파란색 세 가지 색상으로 이루어진 세 개의 섹션을 생성하는 방법과 유사합니다. 네덜란드 국기 분할은 많은 중복 요소가 있는 경우에 사용하기에 훌륭한 기술입니다.

```swift
//quicksortDutchFlag.swift
public func partitionDutchFlag<T: Comparable>(_ a: inout [T],
                                              low: Int, high: Int,
                                              pivotIndex: Int)
                                              -> (Int, Int) {
  let pivot = a[pivotIndex]
  var smaller = low // 1
  var equal = low // 2
  var larger = high // 3
  while equal <= larger { // 4
    if a[equal] < pivot {
      a.swapAt(smaller, equal)
      smaller += 1
      equal += 1
    } else if a[equal] == pivot {
      equal += 1
    } else {
      a.swapAt(equal, larger)
      larger -= 1
    }
  }
  return (smaller, larger) // 5
}
```

Lomuto의 분할과 동일한 전략을 채택하여 마지막 요소를 pivotIndex로 선택합니다. 작동 방식을 살펴보겠습니다:

- 피벗보다 작은 요소를 만날 때마다 해당 요소를 smaller 인덱스로 이동합니다. 이 규칙은 해당 인덱스 이전의 모든 요소가 피벗보다 작음을 의미합니다.
- equal 인덱스는 비교할 다음 요소를 가리킵니다. 피벗과 동일한 값을 가진 요소는 건너뛰며, 따라서 smaller와 equal 사이의 모든 요소는 피벗과 동일합니다.
- 피벗보다 큰 요소를 만날 때마다 해당 요소를 larger 인덱스로 이동합니다. 이 규칙은 해당 인덱스 이후의 모든 요소가 피벗보다 큼을 의미합니다.
- 주 루프는 요소를 비교하고 필요한 경우에 교환합니다. 이 과정은 equal 인덱스가 larger 인덱스를 넘어갈 때까지 계속됩니다. 이는 모든 요소가 올바른 분할로 이동되었음을 의미합니다.
- 알고리즘은 smaller와 larger 인덱스를 반환합니다. 이들은 중간 파티션의 첫 번째와 마지막 요소를 가리킵니다.

```swift
public func quicksortDutchFlag<T: Comparable>(_ a: inout [T],
                                              low: Int, high: Int) {
  if low < high {
    let (middleFirst, middleLast) =
      partitionDutchFlag(&a, low: low, high: high, pivotIndex: high)
    quicksortDutchFlag(&a, low: low, high: middleFirst - 1)
    quicksortDutchFlag(&a, low: middleLast + 1, high: high)
  }
}
```

재귀가 middleFirst와 middleLast 인덱스를 사용하여 재귀적으로 정렬해야 하는 파티션을 결정하는 방법을 주목하세요. 피벗과 같은 요소가 함께 그룹화되기 때문에, 그것들은 재귀에서 제외될 수 있다.

## Key points

- 순진한 분할은 모든 필터 함수에 새로운 배열을 만든다; 이것은 비효율적이다. 다른 모든 전략은 제자리에 정렬된다.
- 로무토의 분할은 마지막 요소를 피벗으로 선택한다.
- 호어의 분할은 첫 번째 요소를 피벗으로 선택한다.
- 이상적인 피벗은 파티션 간에 요소를 고르게 나눌 것이다.
- 잘못된 피벗을 선택하면 빠른 정렬이 O(n²)에서 수행될 수 있습니다.
- 세 개의 중앙값은 첫 번째, 중간 및 마지막 요소의 중앙값을 취하여 피벗을 찾습니다.
- 네덜란드 국기 분할 전략은 중복 요소를 더 효율적으로 구성하는 데 도움을 준다.
