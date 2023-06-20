# Quicksort

이전 장에서, 병합 정렬 및 힙 정렬과 같은 비교 기반 정렬 알고리즘을 사용하여 배열을 정렬하는 법을 배웠다.

Quicksort는 또 다른 비교 기반 정렬 알고리즘이다. 병합 정렬과 마찬가지로, 그것은 분할과 정복의 동일한 전략을 사용한다. 퀵 정렬의 중요한 특징 중 하나는 피벗 포인트를 선택하는 것이다. 피벗은 배열을 세 개의 파티션으로 나눈다:

```swift
[ elements < pivot | pivot | elements > pivot ]
```

이 장에서는 퀵 정렬을 구현하고 이 정렬 알고리즘을 최대한 활용하기 위해 다양한 분할 전략을 살펴볼 것이다.

## Example

Quicksort의 단순한 구현은 quicksortNaive.swift에서 제공된다:

```swift
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

위의 구현은 배열을 세 개의 파티션으로 재귀적으로 필터링한다. 그것이 어떻게 작동하는지 봐보자:

1. 배열에는 하나 이상의 요소가 있어야 한다. 그렇지 않다면, 배열은 정렬된 것으로 간주된다.
2. 배열의 중간 요소를 피벗으로 선택한다.
3. 피벗을 사용하여, 원래 배열을 세 개의 파티션으로 나눈다. 피벗보다 작거나 같거나 큰 요소는 다른 버킷으로 들어간다.
4. 파티션을 재귀적으로 정렬한 다음 결합한다.

이제 위의 코드를 시각화해 본다. 아래의 **정렬되지 않은** 배열을 감안할 때:

```swift
[12, 0, 3, 9, 2, 18, 8, 27, 1, 5, **8**, -1, 21]
```

이 구현의 파티션 전략은 항상 중간 요소를 피벗으로 선택하는 것이다. 이 경우, 요소는 8이다. 이 피벗을 사용하여 배열을 분할하면 다음과 같은 파티션이 발생한다:

```swift
less: [0, 3, 2, 1, 5, -1]
equal: [8, 8]
greater: [12, 9, 18, 27, 21]
```

세 개의 파티션이 아직 완전히 정렬되지 않았다는 것을 주목해라. 퀵소드는 이 파티션들을 더 작은 파티션으로 재귀적으로 나눌 것이다. 재귀는 모든 파티션에 0 또는 하나의 요소가 있을 때만 중단된다.

다음은 모든 분할 단계에 대한 개요이다:

<img width="628" alt="스크린샷 2023-06-20 오전 4 43 25" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/1cbb63f9-c5a0-45b1-bd9c-b08fdb8fbabe">

각 레벨은 퀵 정렬에 대한 재귀 호출에 해당한다. 재귀가 멈추면, 잎이 다시 결합되어 완전히 정렬된 배열이 된다:

```swift
[-1, 1, 2, 3, 5, 8, 8, 9, 12, 18, 27,
```

이 순진한 구현은 이해하기 쉽지만, 몇 가지 문제와 질문을 제기한다:

- 같은 배열에서 필터를 세 번 호출하는 것은 효율적이지 않다.
- 모든 파티션에 대해 새로운 배열을 만드는 것은 공간 효율적이지 않다. 제자리에 정리할 수 있을까?
- 중간 요소를 고르는 것이 최고의 피벗 전략인가? 어떤 피벗 전략을 채택해야 하나?

## Partitioning Strategies

이 섹션에서는 분할 전략과 이 퀵 정렬 구현을 보다 효율적으로 만드는 방법을 살펴볼 것이다. 당신이 보게 될 첫 번째 분할 알고리즘은 Lomuto의 알고리즘이다.

### Lomuto’s partitioning

Lomuto의 분할 알고리즘은 항상 마지막 요소를 피벗으로 선택한다. 이것이 코드에서 어떻게 작동하는지 봐보자.

quicksortLomuto.swift라는 파일을 만들고 다음 함수 선언을 추가하라:

```swift
public func partitionLomuto<T: Comparable>(_ a: inout [T],
                                           low: Int,
                                           high: Int) -> Int {
}
```

이 함수는 세 가지 인수를 취한다:

- a는 당신이 분할하고 있는 배열이다.
- 낮음과 높음은 분할할 배열 내의 범위를 설정한다. 이 범위는 재귀할 때마다 점점 더 작아질 것이다.

그 함수는 피벗의 인덱스를 반환한다.

이제, 다음과 같이 기능을 구현하라:

```swift
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
```

코드 분석:

1. 피벗을 설정한다. Lomuto는 항상 마지막 요소를 피벗으로 선택한다.
2. 변수 i는 얼마나 많은 요소가 피벗보다 작은지를 나타낸다. 피벗보다 작은 요소를 만나면, 인덱스 i의 요소로 바꾸고 i를 늘린다.
3. 낮은 것부터 높은 것까지 모든 요소를 반복하지만, 피벗이기 때문에 높은 것은 포함하지 않는다.
4. 현재 요소가 피벗보다 작거나 같은지 확인한다.
5. 만약 그렇다면, 인덱스 i의 요소로 바꾸고 i를 늘린다.
6. 루프가 끝나면, i의 요소를 피벗으로 바꾼다. 피벗은 항상 더 적고 더 큰 파티션 사이에 있다.
7. 피벗의 인덱스를 반환한다.

이 알고리즘이 배열을 반복하는 동안, 배열을 네 개의 영역으로 나눈다:

1. A[low..<i]는 모든 요소 <= 피벗을 포함한다.
2. A[i...j-1]은 모든 요소 > 피벗을 포함한다.
3. A[j...high-1]는 아직 비교하지 않은 요소이다.
4. A[high]는 피벗 요소이다.

```swift
[ values <= pivot | values > pivot | not compared yet | pivot ]
  low        i-1    i         j-1   j          high-1   high
```

### Step by step

그것이 어떻게 작동하는지 명확하게 이해하기 위해 알고리즘의 몇 단계를 봐보자. 아래의 정렬되지 않은 배열을 감안할 때:

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
```

먼저, 마지막 요소 8이 피벗으로 선택된다:

```swift
  0   1  2  3  4  5   6   7   8  9  10  11    12
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
  i
  j
```

그런 다음, 첫 번째 요소인 12는 피벗과 비교된다. 피벗보다 작지 않으므로, 알고리즘은 다음 요소로 계속된다:

```swift
   0  1  2  3  4  5   6   7   8  9  10  11   12
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
  i
      j
```

두 번째 요소 0은 피벗보다 작기 때문에 현재 인덱스 i (12)에 있는 요소와 교환되고 i가 증가한다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 12, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
 low                                         high
      i
         j
```

세 번째 요소 3은 다시 피벗보다 작기 때문에, 또 다른 스왑이 발생한다:

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 3, 12, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
 low                                         high
         i
            j
```

이 단계들은 피벗 요소를 제외한 모든 것이 비교될 때까지 계속된다. 결과 배열은 다음과 같다:

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 3, 2, 1, 5, 8, -1, 27, 9, 12, 21, 18, |  8  ]
 low                                         high
                         i
```

마지막으로, 피벗 요소는 현재 인덱스 i에 있는 요소와 교환된다:

```swift
  0   1  2  3  4  5   6   7   8  9  10  11     12
[ 0, 3, 2, 1, 5, 8, -1 | 8 | 9, 12, 21, 18, |  27  ]
 low                                          high
                         i
```

Lomuto의 분할은 이제 완료되었다. 피벗보다 작거나 같은 요소의 두 영역과 피벗보다 큰 요소 사이에 피벗이 어떻게 있는지 주목해보자.

퀵소트의 순진한 구현에서, 당신은 세 개의 새로운 배열을 만들고 정렬되지 않은 배열을 세 번 필터링했다. Lomuto의 알고리즘은 제자리에서 분할을 수행한다. 그게 훨씬 더 효율적임

파티션 알고리즘을 사용하면, 이제 퀵 정렬을 구현할 수 있다:

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

여기서 Lomuto의 알고리즘을 적용하여 배열을 두 영역으로 분할한 다음, 이러한 영역을 재귀적으로 정렬한다. 재귀는 한 영역이 두 개 미만의 요소를 가지면 끝난다.

놀이터에 다음을 추가하여 Lomuto의 퀵 정렬을 시도해 볼 수 있다:

```swift
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)
```

### Hoare’s partitioning

Hoare의 분할 알고리즘은 항상 첫 번째 요소를 피벗으로 선택한다. 이것이 코드에서 어떻게 작동하는지 봐보자.

놀이터에서 quicksortHoare.swift라는 파일을 만들고 다음을 추가하라.

```swift
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

코드 분석:

1. 첫 번째 요소를 피벗으로 선택한다.
2. 인덱스 i와 j는 두 영역을 정의한다. 나 이전의 모든 인덱스는 피벗보다 작거나 같을 것이다. J 이후의 모든 인덱스는 피벗보다 크거나 같을 것이다.
3. 피벗보다 크지 않은 요소에 도달할 때까지 j를 줄인다.
4. 피벗보다 적지 않은 요소에 도달할 때까지 i를 늘린다.
5. I와 j가 겹치지 않았다면, 요소를 바꾼다.
6. 두 지역을 구분하는 인덱스를 반환한다.

```swift
참고: 파티션에서 반환된 인덱스가 반드시 피벗 요소의 인덱스일 필요는 없다.
```

### Step by step

아래의 정렬되지 않은 배열을 감안할 때:

```swift
[  12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8   ]
```

먼저, 12가 피벗으로 설정된다. 그런 다음 i와 j는 배열을 실행하기 시작할 것이며, (i의 경우)보다 작지 않거나 (j의 경우) 피벗보다 크지 않은 요소를 찾을 것이다. 나는 요소 12에서 멈추고 j는 요소 8에서 멈출 것이다:

```swift
[  12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1,  8  ]
        p
        i                                         j
```

These elements are then swapped:

```swift
[  8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12 ]
   i                                       j
```

i and j now continue moving, this time stopping at 21 and -1:

```swift
[  8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12 ]
                   i                    j
```

Which are then swapped:

```swift
[  8, 0, 3, 9, 2, -1, 18, 27, 1, 5, 8, 21, 12 ]
                   i                    j
```

Next, 18 and 8 are swapped, followed by 27 and 5.

After this swap, the array and indices are as follows:

```swift
[  8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12 ]
                         i      j
```

The next time you move i and j, they will overlap:

```swift
[  8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12 ]
                            j   i
```

호어의 알고리즘은 이제 완료되었고, 인덱스 j는 두 영역 사이의 분리로 반환된다. Lomuto의 알고리즘에 비해 스왑이 훨씬 적다. 좋지 않음?ㅋㅋ

이제 quicksortHoare 기능을 구현할 수 있다:

```swift
public func quicksortHoare<T: Comparable>(_ a: inout [T],
                                          low: Int, high: Int) {
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

## Effects of a bad pivot choice

퀵소트 구현의 가장 중요한 부분은 올바른 분할 전략을 선택하는 것이다.

당신은 세 가지 다른 분할 전략을 살펴보았다:

1. 중간 요소를 피벗으로 선택하기.
2. Lomuto, 또는 마지막 요소를 피벗으로 선택하기.
3. 호어, 또는 첫 번째 요소를 피벗으로 선택하기.

나쁜 피벗을 선택하는 것은 어떤 의미일까?

다음과 같은 정렬되지 않은 배열로 시작해보자:

```swift
[8, 7, 6, 5, 4, 3, 2, 1]
```

Lomuto의 알고리즘을 사용한다면, 피벗은 마지막 요소인 1이 될 것이다. 이것은 다음과 같은 파티션을 초래한다:

```swift
less: [ ]
equal: [1]
greater: [8, 7, 6, 5, 4, 3, 2]
```

이상적인 피벗은 파티션보다 작은 것과 큰 것 사이에서 요소를 고르게 나눌 것이다. 이미 정렬된 배열의 첫 번째 또는 마지막 요소를 피벗으로 선택하면 빠른 정렬은 삽입 정렬과 매우 비슷하게 수행되며, 이로 인해 O(n²)의 최악의 성능이 발생한다.

이 문제를 해결하는 한 가지 방법은 세 가지 피벗 선택 전략의 중앙값을 사용하는 것이다. 여기서, 당신은 배열의 첫 번째, 중간 및 마지막 요소의 중앙값을 찾고 그것을 피벗으로 사용한다. 이 선택 전략은 배열에서 가장 높거나 가장 낮은 요소를 선택하는 것을 방지한다.

구현을 살펴보자. quicksortMedian.swift라는 새 파일을 만들고 다음 기능을 추가하라:

```swift
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

여기서, 정렬하여 a[low], a[center] 및 a[hight]의 중앙값을 찾을 수 있다. 중앙값은 인덱스 센터에서 끝날 것이며, 이는 함수가 반환하는 것이다.

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

놀이터에 다음을 추가하여 이것을 시도해 봐라:

```swift
var list3 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quickSortMedian(&list3, low: 0, high: list3.count - 1)
print(list3)
```

이 전략은 개선된 것이지만,더 잘할 수 있을까?

### Dutch national flag partitioning

Lomuto와 Hoare의 알고리즘의 문제는 그들이 중복을 잘 처리하지 않는다는 것이다. Lomuto의 알고리즘으로, 중복은 파티션보다 작게 끝나고 함께 그룹화되지 않는다. Hoare의 알고리즘으로, 중복이 곳곳에 있을 수 있기 때문에 상황은 훨씬 더 나쁘다.

중복 요소를 구성하는 해결책은 네덜란드 국기 분할을 사용하는 것이다. 이 기술은 빨간색, 흰색, 파란색의 세 가지 띠가 있는 네덜란드 국기의 이름을 따서 명명되었으며 세 개의 파티션을 만드는 방법과 유사하다. 네덜란드 국기 분할은 중복 요소가 많은 경우 사용할 수 있는 훌륭한 기술이다.

그것이 어떻게 구현되는지 봐보자. quicksortDutchFlag.swift라는 파일을 만들고 다음 기능을 추가하세요:

```swift
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

당신은 pivotIndex로 마지막 요소를 선택하여 Lomuto의 파티션과 동일한 전략을 채택할 것이다. 그것이 어떻게 작동하는지 살펴보자:

피벗보다 작은 요소를 만날 때마다, 인덱스를 더 작게 옮겨라. 이 규칙은 이 인덱스 앞에 오는 모든 요소가 피벗보다 적다는 것을 의미한다.

인덱스는 비교할 다음 요소와 같다. 피벗과 같은 요소는 건너뛴다. 즉, 더 작고 동등한 요소 사이의 모든 요소가 피벗과 동일하다는 것을 의미한다.

피벗보다 큰 요소를 만날 때마다, 더 큰 인덱스로 이동하라. 이 규칙은 이 인덱스 이후에 오는 모든 요소가 피벗보다 크다는 것을 의미한다.

메인 루프는 요소를 비교하고 필요한 경우 교환한다. 이 과정은 인덱스가 인덱스를 지나 더 크게 이동할 때까지 계속되며, 이는 모든 요소가 올바른 파티션으로 이동되었음을 의미한다.

알고리즘은 점점 더 큰 인덱스를 반환한다. 이것들은 중간 파티션의 첫 번째와 마지막 요소를 가리킨다.

### Step by step

아래의 정렬되지 않은 배열을 사용하여 예를 살펴보자:

```swift
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8 ]
```

이 알고리즘은 피벗 선택 전략과 독립적이기 때문에, Lomuto를 채택하고 마지막 요소 8을 선택한다.

```swift
참고: 연습을 위해, 중앙값 3과 같은 다른 전략을 시도해 보세요.
```

다음으로, 당신은 더 작고, 동등하고, 더 큰 인덱스를 설정한다:

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
  s
  e
                                          l
```

비교할 첫 번째 요소는 12이다. 피벗보다 크기 때문에, 인덱스가 더 큰 요소로 교환되고, 이 인덱스는 감소한다.

인덱스는 증가되지 않으므로, (8)에서 교환된 요소는 다음에 비교된다:

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
 e
                                      l
```

당신이 선택한 피벗은 여전히 8. 8은 피벗과 같기 때문에, 같은 증가를 한다:

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
    e
                                      l
```

0은 피벗보다 작기 때문에, 요소를 동등하고 작게 바꾸고 두 포인터를 모두 증가시킨다:

```swift
[0, 8, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
    s
       e
                                      l
```

그리고 계속.

배열이 얼마나 작고, 같고, 더 큰 파티션인지 주목하라:

- [low..<smaller]의 요소는 피벗보다 작다.
- [smaller..<equal]의 요소는 피벗과 같다.
- [Larger>..high]의 요소는 피벗보다 크다.
- [equal...larger] 요소는 아직 비교되지 않았다.

알고리즘이 어떻게 그리고 언제 끝나는지 이해하려면, 두 번째에서 마지막 단계부터 계속해 보자:

```swift
[0, 3, -1, 2, 5, 8, 8, 27, 1, 18, 21, 9, 12]
                 s
                        e
                           l
```

여기서, 27이 비교되고 있다. 그것은 피벗보다 크므로, 1로 교환되고 더 큰 인덱스는 감소한다:

```swift
[0, 3, -1, 2, 5, 8, 8, 1, 27, 18, 21, 9, 12]
                 s
                       e
                       l
```

비록 같은 것이 이제 더 큰 것과 같지만, 알고리즘은 완전하지 않다.

현재 동등한 요소는 아직 비교되지 않았다. 그것은 피벗보다 작기 때문에, 8로 교환되며, 더 작고 동등한 두 인덱스 모두 증가한다:

```swift
[0, 3, -1, 2, 5, 1, 8, 8, 27, 18, 21, 9, 12]
                    s
                          e
                       l
```

더 작고 더 큰 인덱스는 이제 중간 파티션의 첫 번째와 마지막 요소를 가리킨다. 그것들을 반환함으로써, 그 기능은 세 개의 파티션의 경계를 표시한다.

이제 네덜란드 국기 분할을 사용하여 새로운 버전의 퀵 정렬을 구현할 준비가 되었다:

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

재귀가 middleFirst와 middleLast 인덱스를 사용하여 재귀적으로 정렬해야 하는 파티션을 결정하는 방법을 주목하라. 피벗과 같은 요소가 함께 그룹화되기 때문에, 그것들은 재귀에서 제외될 수 있다.

다음을 추가하여 새로운 퀵 정렬을 시도해 봐라:

```swift
var list4 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortDutchFlag(&list4, low: 0, high: list4.count - 1)
print(list4)
```

이게 끝~

## 🔑 Key points

- 순진한 분할은 모든 필터 함수에 새로운 배열을 만든다; 이것은 비효율적이다. 다른 모든 전략은 제자리에 정렬된다.
- 로무토의 분할은 마지막 요소를 피벗으로 선택한다.
- 호어의 분할은 첫 번째 요소를 피벗으로 선택한다.
- 이상적인 피벗은 파티션 간에 요소를 고르게 나눌 것이다.
- 잘못된 피벗을 선택하면 빠른 정렬이 O(n²)에서 수행될 수 있습니다.
- 세 개의 중앙값은 첫 번째, 중간 및 마지막 요소의 중앙값을 취하여 피벗을 찾습니다.
- 네덜란드 국기 분할 전략은 중복 요소를 더 효율적으로 구성하는 데 도움을 준다.
