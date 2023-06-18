# Chapter 34: Quicksort

지금까지의 장에서는 병합정렬(merge sort)과 힙정렬(heap sort)과 같은 비교 기반 정렬 알고리즘을 사용하여 배열을 정렬하는 방법에 대해 배웠습니다.
퀵정렬은 다른 비교 기반 정렬 알고리즘과 마찬가지로 분할 정복(divide and conquer) 전략을 사용합니다.
퀵정렬의 중요한 특징 중 하나는 피벗(pivot) 지점을 선택하는 것입니다.
피벗은 배열을 세 개의 파티션으로 나눕니다:

[ `elements < pivot` | `pivot` | `elements > pivot` ]

이 장에서는 퀵정렬을 구현하고 이 정렬 알고리즘에서 최대한의 효율성을 얻기 위해 다양한 파티션 전략을 살펴볼 것입니다.

# 예시

아래 구현은 재귀적으로 배열을 세 개의 파티션으로 분리합니다. 작동 방식을 살펴보겠습니다:

```swift
public func quicksortNaive<T: Comparable>(_ a: [T]) -> [T] {
	// 배열에는 하나 이상의 요소가 있어야 합니다. 그렇지 않으면 배열은 정렬된 것으로 간주됩니다.
	guard a.count > 1 else {
		return a
	}
	// 배열의 중간 요소를 피벗으로 선택합니다.
	let pivot = a[a.count / 2]
	// 피벗을 사용하여 원래 배열을 세 개의 파티션으로 분할합니다.
	// 피벗보다 작은 요소, 피벗과 같은 요소, 피벗보다 큰 요소가 각각 다른 버킷에 들어갑니다.
	let less = a.filter { $0 < pivot }
	let equal = a.filter { $0 == pivot }
	let greater = a.filter { $0 > pivot }
	// 파티션을 재귀적으로 정렬한 다음 결합합니다.
	return quicksortNaive(less) + equal + quicksortNaive(greater)
}
```

이제 위의 코드를 시각화해보겠습니다. 아래에 정렬되지 않은 배열이 주어져 있다고 가정합니다:

```swift
[12, 0, 3, 9, 2, 18, 8, 27, 1, 5, 8, -1, 21]
                     *
```

이 구현에서 사용하는 파티션 전략은 항상 중간 요소를 피벗으로 선택하는 것입니다.
이 경우, 피벗은 8입니다. 이 피벗을 사용하여 배열을 파티션하면 다음과 같은 파티션이 생성됩니다:

```swift
less: [0, 3, 2, 1, 5, -1]
equal: [8, 8]
greater: [12, 9, 18, 27, 21]
```

주목할 점은 세 개의 파티션이 아직 완전히 정렬되지 않았다는 것입니다.
퀵정렬은 이러한 파티션을 재귀적으로 더 작은 파티션으로 나누게 됩니다.
재귀 호출은 모든 파티션이 요소가 0개 또는 1개인 경우에만 중단됩니다.
다음은 모든 파티션 단계에 대한 개요입니다:

<img width="700" alt="스크린샷 2023-06-18 오후 6 58 10" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/59944c4a-dc6e-4667-a696-c2b4c8b85353">

각 레벨은 퀵정렬의 재귀 호출에 해당합니다. 재귀 호출이 중단되면, 리프 노드들이 다시 결합되어 완전히 정렬된 배열이 생성됩니다:

```swift
[-1, 1, 2, 3, 5, 8, 8, 9, 12, 18, 21, 27]
```

이 단순한 구현은 이해하기 쉽지만 몇 가지 문제와 질문을 제기합니다:

- 동일한 배열에 대해 세 번의 필터 호출은 효율적이지 않습니다.
- 각 파티션마다 새로운 배열을 생성하는 것은 공간 효율적이지 않습니다. 원위치에서 정렬할 수 있는 방법이 있을까요?
- 중간 요소를 선택하는 것이 가장 좋은 피벗 전략일까요? 어떤 피벗 전략을 채택해야 할까요?

# 파티션 전략

## Lomuto's partition

Lomuto의 파티션 알고리즘은 항상 마지막 요소를 피벗으로 선택합니다. 이 알고리즘이 어떻게 동작하는지 코드로 살펴보겠습니다.

```swift
// a: 파티션을 수행할 배열
// low, high: 파티션을 수행할 배열의 범위, 이 범위는 재귀마다 작아짐
public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	// 피벗을 설정합니다. Lomuto는 항상 마지막 요소를 피벗으로 선택합니다.
	let pivot = a[high]
	// 변수 i는 피벗보다 작은 요소의 개수를 나타냅니다.
	// 피벗보다 작은 요소를 만나면 해당 요소를 인덱스 i의 요소와 교환하고 i를 증가시킵니다.
	var i = low
	// low부터 high까지의 모든 요소를 반복하되, high는 피벗이므로 포함하지 않습니다.
	for j in low..<high {
		// 현재 요소가 피벗보다 작거나 같은지 확인합니다.
		if a[j] <= pivot {
			// 만약 작거나 같다면, 해당 요소를 인덱스 i의 요소와 교환하고 i를 증가시킵니다.
			a.swapAt(i, j)
			i += 1
		}
	}
	// 루프가 끝나면, 인덱스 i의 요소와 피벗을 교환합니다. 피벗은 항상 작은 파티션과 큰 파티션 사이에 위치합니다.
	a.swapAt(i, high)
	// 피벗의 인덱스를 반환합니다.
	return i
}
```

이 알고리즘은 배열을 순회하면서 다음과 같이 배열을 네 개의 영역으로 나눕니다:

1. `a[low..<i]`는 피벗보다 작거나 같은 모든 요소를 포함합니다.
2. `a[i...j-1]`은 피벗보다 큰 모든 요소를 포함합니다.
3. `a[j...high-1]`는 아직 비교하지 않은 요소들입니다.
4. `a[high]`는 피벗 요소 자체입니다.

```swift
[values <= pivot | values > pivot | not compared yet | pivot ]
 low         i-1   i          j-1   j         high-1   high
```

### Step-by-step

아래의 정렬되지 않은 배열을 사용하여 알고리즘이 어떻게 동작하는지 명확히 이해하기 위해 몇 가지 단계를 살펴보겠습니다:

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
```

처음으로, 마지막 요소 8이 피벗으로 선택됩니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11    12
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
   i
      j
```

그런 다음 첫 번째 요소인 12가 피벗과 비교됩니다. 12는 피벗보다 작지 않으므로 알고리즘은 다음 요소로 진행합니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11    12
[ 0, 12, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
      i
         j
```

세 번째 요소인 3은 다시 피벗보다 작기 때문에 다른 교환이 발생합니다.

```swift
  0  1   2  3  4   5   6   7  8  9  10  11   12
[ 0, 3, 12, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
 low                                         high
         i
            j
```

이러한 단계는 피벗 요소를 제외한 모든 요소가 비교될 때까지 계속됩니다. 결과로 얻은 배열은 다음과 같습니다:

```swift
  0  1  2  3  4  5   6   7  8   9  10  11    12
[ 0, 3, 2, 1, 5, 8, -1, 27, 9, 12, 21, 18, |  8  ]
 low                                         high
                         i
```

마지막으로, 피벗 요소는 현재 인덱스 i에 있는 요소와 교환됩니다.

```swift
  0  1  2  3  4  5   6   7   8   9  10  11     12
[ 0, 3, 2, 1, 5, 8, -1 | 8 | 9, 12, 21, 18, |  27 ]
 low                                          high
                         i
```

이제 Lomuto의 파티셔닝이 완료되었습니다.
피벗이 피벗보다 작거나 같은 요소의 영역과 피벗보다 큰 요소의 영역 사이에 위치하는 것을 확인할 수 있습니다.
QuickSort의 단순한 구현에서는 세 개의 새로운 배열을 생성하고 정렬되지 않은 배열을 세 번 필터링했습니다.
Lomuto의 알고리즘은 파티셔닝을 제자리에서 수행합니다. 이것은 훨씬 효율적입니다!
Lomuto's partitioning algorithm을 구현한 이후에는 quicksort를 구현할 수 있습니다:

```swift
public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	}
}
```

여기서는 Lomuto의 알고리즘을 사용하여 배열을 두 개의 영역으로 분할하고, 이러한 영역을 재귀적으로 정렬합니다.
재귀 호출은 영역에 요소가 2개 미만인 경우에 종료됩니다.

```swift
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)
```

## Hoare’s partitioning

Hoare의 파티션 알고리즘은 항상 첫 번째 요소를 피벗으로 선택합니다. 이 알고리즘이 어떻게 동작하는지 코드로 살펴보겠습니다.

```swift
public func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
	// 첫 번째 요소를 피벗으로 선택합니다.
	let pivot = a[low]
	// 인덱스 i와 j는 두 개의 영역을 정의합니다.
	// i 이전의 모든 인덱스는 피벗보다 작거나 같을 것입니다.
	// j 이후의 모든 인덱스는 피벗보다 크거나 같을 것입니다.
	var i = low - 1
	var j = high + 1
	
	while true {
		// j를 감소시키면서 피벗보다 크지 않은 요소에 도달할 때까지 이동합니다.
		repeat { j -= 1 } while a[j] > pivot
		// i를 증가시키면서 피벗보다 작지 않은 요소에 도달할 때까지 이동합니다.
		repeat { i += 1 } while a[i] < pivot
		// i와 j가 겹치지 않았다면 요소를 교환합니다.
		if i < j {
			a.swapAt(i, j)
		} else {
			// 두 영역을 구분하는 인덱스를 반환합니다.
			return j
		}
	}
}
```

### Step-by-step

아래의 정렬되지 않은 배열을 가정합니다:

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
```

첫 번째로, 12가 피벗으로 설정됩니다.
그런 다음 i와 j가 배열을 훑으면서 i는 피벗 이상인 수, j는 피벗 미만인 수를 찾습니다.
i는 요소 12에서 멈추고, j는 요소 8에서 멈춥니다.

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
 p                                        j
 i
```

이러한 요소들은 교환됩니다.

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 i                                        j
```

i와 j는 이제 이동을 계속하며, 이번에는 21과 -1에서 멈춥니다.

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
                 i                    j
```

그런 다음 이들은 교환됩니다.

```swift
[8, 0, 3, 9, 2, -1, 18, 27, 1, 5, 8, 21, 12]
                 i                    j
```

다음으로, 18과 8이 교환되고, 그 다음에는 27과 5가 교환됩니다. 이 교환 후, 배열과 인덱스는 다음과 같습니다.

```swift
[8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12]
                       i      j
```

다음으로 i와 j를 이동할 때, 이들은 교차하게 됩니다.

```swift
[8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12]
                          j   i
```

Hoare의 알고리즘이 이제 완료되었고, 인덱스 j가 두 영역을 구분하는 지점으로 반환됩니다.
여기서는 Lomuto의 알고리즘에 비해 훨씬 적은 교환 작업이 이루어집니다.
이제 quicksortHoare 함수를 구현할 수 있습니다.

```swift
public func quicksortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let p = partitionHoare(&a, low: low, high: high)
		quicksortHoare(&a, low: low, high: p)
		quicksortHoare(&a, low: p + 1, high: high)
	}
}

var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortHoare(&list2, low: 0, high: list.count - 1)
print(list2)
```

# 나쁜 피벗 선택의 영향

퀵소트를 구현하는 가장 중요한 부분은 올바른 분할 전략을 선택하는 것입니다. 여기서는 세 가지 다른 분할 전략을 살펴보았습니다:

1. 중간 요소를 피벗으로 선택하는 방법
2. Lomuto, 또는 마지막 요소를 피벗으로 선택하는 방법
3. Hoare, 또는 첫 번째 요소를 피벗으로 선택하는 방법

잘못된 피벗을 선택하는 것의 영향은 무엇일까요? 아래의 정렬되지 않은 배열로 시작해보겠습니다.

```swift
[8, 7, 6, 5, 4, 3, 2, 1]
```

Lomuto의 알고리즘을 사용하면 피벗은 마지막 요소인 1이 됩니다. 이로 인해 다음과 같은 분할이 이루어집니다.

```swift
less: [ ]
equal: [1]
greater: [8, 7, 6, 5, 4, 3, 2]
```

이상적인 피벗은 작은 값과 큰 값의 파티션을 균등하게 분할해야 합니다.
이미 정렬된 배열에서 첫 번째 또는 마지막 요소를 피벗으로 선택하면 퀵소트는 삽입 정렬과 유사한 동작을 하게 되어 최악의 경우 O(n²)의 성능을 보이게 됩니다.
이 문제를 해결하는 한 가지 방법은 세 요소 중 첫 번째, 중간, 마지막 요소의 중앙값을 찾아 피벗으로 사용하는 것입니다.
이 선택 전략은 배열에서 가장 큰 값 또는 가장 작은 값을 선택하는 것을 방지합니다.
구현을 살펴봅시다.

```swift
public func medianOfThree<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
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

여기서는 a[low], a[center], a[high]의 중앙값을 정렬하여 찾습니다. 중앙값은 center 인덱스에 위치하게 되며, 이 값이 함수에서 반환됩니다.

다음으로, 세 요소의 중앙값을 사용하는 Quicksort의 변형을 구현해보겠습니다.

```swift
public func quickSortMedian<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let pivotIndex = medianOfThree(&a, low: low, high: high)
		a.swapAt(pivotIndex, high)
		let pivot = partitionLomuto(&a, low: low, high: high)
		quicksortLomuto(&a, low: low, high: pivot - 1)
		quicksortLomuto(&a, low: pivot + 1, high: high)
	}
}
```

# 네덜란드 국기 분할(Dutch national flag partitioning)

Lomuto의 알고리즘과 Hoare의 알고리즘은 중복 요소를 처리하는 데 문제가 있습니다.
Lomuto의 알고리즘에서는 중복 요소가 작은 값들의 파티션에 섞여 있어 그룹화되지 않습니다.
Hoare의 알고리즘에서는 상황이 더 나빠져 중복 요소가 파티션 전반에 흩어질 수 있습니다.
중복 요소를 조직화하는 해결책은 더치 국기 분할(Dutch national flag partitioning)을 사용하는 것입니다.
이 기법은 더치 국기의 색상인 빨강, 흰색, 파랑과 유사한 방식으로 세 개의 파티션을 만드는 것과 같습니다.
더치 국기 분할은 많은 중복 요소가 있는 경우에 효과적인 기법입니다.
Lomuto의 파티션과 동일한 전략으로 마지막 요소를 pivotIndex로 선택합니다. 작동 방식을 알아보겠습니다:

```swift
public func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
	let pivot = a[pivotIndex]
	// pivot보다 작은 요소를 만날 때마다 해당 요소를 작은 인덱스로 이동합니다.
	// 이 규칙은 이 인덱스 이전의 모든 요소가 pivot보다 작다는 것을 의미합니다.
	var smaller = low
	// equal 인덱스는 비교할 다음 요소를 가리킵니다.
	// pivot과 동일한 요소는 건너뛰므로 작은 인덱스와 equal 인덱스 사이의 모든 요소는 pivot과 같습니다.
	var equal = low
	// pivot보다 큰 요소를 만날 때마다 해당 요소를 큰 인덱스로 이동합니다.
	// 이 규칙은 이 인덱스 이후의 모든 요소가 pivot보다 크다는 것을 의미합니다.
	var larger = high
	// 주요 루프는 요소를 비교하고 필요한 경우 요소를 교환합니다.
	// 이 과정은 equal 인덱스가 larger 인덱스를 지나가면서 모든 요소가 올바른 파티션으로 이동할 때까지 계속됩니다.
	while equal <= larger {
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
	// 알고리즘은 작은 인덱스와 큰 인덱스를 반환합니다.
	// 이 인덱스들은 중간 파티션의 첫 번째 요소와 마지막 요소를 가리킵니다.
	return (smaller, larger)
}
```

## Step-by-step

아래의 정렬되지 않은 배열을 사용하여 예제를 살펴보겠습니다:

```swift
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8 ]
```

이 알고리즘은 피벗 선택 전략과 독립적이므로, Lomuto의 방법을 채택하고 마지막 요소 8을 선택합니다.

> 참고: 연습으로 다른 전략, 예를 들어 세 요소의 중간값(median of three)을 사용해보세요.

다음으로, 인덱스 smaller, equal, larger를 설정합니다:

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
  s
  e
                                          l
```

비교할 첫 번째 요소는 12입니다. 12는 피벗보다 크기 때문에, 12는 인덱스 larger에 있는 요소와 교환되고, 해당 인덱스는 감소됩니다.
equal 인덱스는 증가하지 않았으므로, 교환된 요소인 8이 다음으로 비교됩니다:

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
 e
                                      l
```

선택한 피벗은 여전히 8입니다. 8은 피벗과 같으므로, equal 인덱스를 증가시킵니다:

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
    e
                                      l
```

0은 피벗보다 작으므로, equal과 smaller 인덱스의 요소를 교환하고 두 포인터를 증가시킵니다:

```swift
[0, 8, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
    s
       e
                                      l
```

계속해서 진행하면서 smaller, equal, larger가 배열을 분할하는 것을 주목해보세요:

- [low..<smaller] 범위의 요소는 피벗보다 작습니다.
- [smaller..<equal] 범위의 요소는 피벗과 같습니다.
- [larger>..high] 범위의 요소는 피벗보다 큽니다.
- [equal...larger] 범위의 요소는 아직 비교되지 않았습니다.

알고리즘이 어떻게 동작하고 언제 종료되는지 이해하기 위해 마지막 직전 단계부터 계속해봅시다:

```swift
[0, 3, -1, 2, 5, 8, 8, 27, 1, 18, 21, 9, 12]
                 s
                        e
                           l
```

여기서 27이 비교되고 있습니다. 피벗보다 크기 때문에 1과 교환되고 larger 인덱스가 감소합니다:

```swift
[0, 3, -1, 2, 5, 8, 8, 1, 27, 18, 21, 9, 12]
                 s
                       e
                       l
```

equal은 현재 larger와 같아졌지만, 알고리즘이 완료되지 않았습니다.
현재 equal에 있는 요소는 아직 비교되지 않았습니다. 피벗보다 작기 때문에 8과 교환되고, 작은 인덱스와 equal 모두 증가합니다:

```swift
[0, 3, -1, 2, 5, 1, 8, 8, 27, 18, 21, 9, 12]
                    s
                          e
                       l
```

이제 작은 인덱스와 큰 인덱스는 중간 파티션의 첫 번째와 마지막 요소를 가리킵니다. 이들을 반환함으로써 함수는 세 파티션의 경계를 표시합니다.
이제 Dutch national flag partitioning을 사용한 퀵소트의 새로운 버전을 구현할 준비가 되었습니다:

```swift
public func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
	if low < high {
		let (middleFirst, middleLast) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: high)
		quicksortDutchFlag(&a, low: low, high: middleFirst - 1)
		quicksortDutchFlag(&a, low: middleLast + 1, high: high)
	}
}
```

재귀 호출은 middleFirst와 middleLast 인덱스를 사용하여 재귀적으로 정렬해야 할 파티션을 결정합니다.
피벗과 같은 요소들이 함께 그룹화되어 있기 때문에 재귀에서 제외될 수 있습니다.

# Key points

- 단순한 파티셔닝은 모든 필터 함수에서 매번 새로운 배열을 생성하기 때문에 비효율적입니다. 다른 전략들은 제자리에서 정렬을 수행합니다.
- Lomuto의 파티셔닝은 피벗으로 마지막 요소를 선택합니다.
- Hoare의 파티셔닝은 첫 번째 요소를 피벗으로 선택합니다.
- 이상적인 피벗은 요소들을 파티션 사이에 고르게 분할합니다.
- 나쁜 피벗을 선택하면 퀵소트의 수행 시간이 O(n²)로 증가할 수 있습니다.
- Median of three는 첫 번째, 중간, 마지막 요소의 중간값을 피벗으로 선택합니다.
- Dutch national flag 파티셔닝 전략은 중복 요소들을 보다 효율적으로 정리하는 데 도움이 됩니다.