# Quicksort

지난 장에서는 병합 정렬이나 힙 정렬과 같은 비교를 기반으로한 정렬 알고리즘에 대해 배웠습니다. 

퀵 정렬(quick sort)이란 비교를 기반으로 한 알고리즘입니다. 
합병 정렬과 비슷하게, 병합 정렬을 사용합니다. 퀵 정렬의 가장 중요한 특징 중 하나는 중심점을 선택하는 것입니다. 중심점은 배열을 세 가지로 나눕니다.

```swift
[ elements < pivot | pivot | elements > pivot ]
```

이번 장에서는 퀵 정렬을 사용하고, 여러 파티셔닝 전략들을 살펴볼 것입니다.

## Example

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

위의 식은 재귀적으로 배열을 세 가지 부분으로 나눕니다.

1. 배열에 하나 이상의 요소가 있어야 합니다. 만약 그렇지 않다면, 배열이 정렬되어 있다고 가정합니다.
2. 배열의 중간 요소를 중심점으로 선택합니다.
3. 중심점을 사용하여 기존 배열을 세 부분으로 나눕니다. 중심점을 기준으로 작거나, 같거나, 큰 값을 기준으로 버킷에 넣습니다.
4. 파티션을 재귀적으로 정렬하고, 합칩니다.

이제 코드를 시각화해봅시다. 정렬되지 않은 배열이 있습니다.

```swift
[12, 0, 3, 9, 2, 18, 8, 27, 1, 5, 8, -1, 21]
                     *
```

분할 전략은 항상 중간 요소를 중심점으로 선택합니다. 이 경우에는 8입니다. 이 중심점을 사용하여 배열을 분할한 것의 결과는 다음과 같습니다.

```swift
less: [0, 3, 2, 1, 5, -1]
equal: [8, 8]
greater: [12, 9, 18, 27, 21]
```

3가지로 분할하는 것으로 완전이 정렬되지는 않았습니다. 퀵 정렬은 3가지로의 분할을 재귀적으로 반복하여 더 잘게 만듭니다. 재귀는 요소가 없거나 하나가 될 때까지 분할합니다.

<img width="509" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/bc0b3584-184b-4121-ad28-b3de6f7ef682">


각각의 레벨은 퀵 정렬에 대한 재귀 호출에 해당합니다. 재귀가 멈춘다면, 리프들이 다시 합쳐져서 완전히 정렬되었습니다. 

```swift
[-1, 1, 2, 3, 5, 8, 8, 9, 12, 18, 21, 27]
```

이러한 실행 방법은 이해하기 쉽지만, 몇 가지 문제점과 의문점이 있습니다.

- 같은 배열에서 `filter`를 세 번 부르는 것은 효율적이지 않습니다.
- 모든 분할 시기에 새로운 배열을 생성하는 것은 공간 효율적이지 않습니다. 각각의 자리에서 정렬할 수는 없을 것일까요?
- 중간 요소를 선택하는 것이 중심점 전략에서 최선일까요? 어떠한 전략을 적용해야 할까요?

## Partitioning strategies

이번 섹션에서는 퀵 정렬을 더욱 효율적으로 실행할 수 있는 전략에 대해 알아볼 것입니다. 
처음으로 알아볼 파티셔닝 알고리즘은 Lomuto의 알고리즘입니다.

### Lomuto’s partitioning

Lomuto의 파티셔닝 알고리즘은 중심점을 항상 마지막 요소로 선택합니다. 

```swift
public func partitionLomuto<T: Comparable>(_ a: inout [T],
                                           low: Int,
                                           high: Int) -> Int {
}
```

이 함수는 3가지의 특징이 있습니다.

- a는 파티셔닝하고자 하는 배열입니다.
- low와 high는 분할하고자 하는 배열의 대한 범위입니다. 이 범위는 각각의 재귀에서 점점 더 작아질 것입니다.

함수는 중심점의 인덱스를 반환합니다.

함수를 실행해봅니다.

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

1. 중심점을 설정합니다. Lumoto는 항상 마지막 요소를 중심점으로 선택합니다.
2. 변수 i는 중심점보다 작은 값이 몇 개 있는지 알려줍니다.
중심점보다 작은 요소를 만난다면, 인덱스 i에 있는 요소와 스왑하고 i를 증가시킵니다.
3. low부터 high로 요소들을 순회하지만, high가 중심점이기 때문에 이는 포함하지 않습니다.
4. 현재 요소가 중심점보다 같거나 작은지 확인합니다.
5. 만약 같거나 작다면, 인덱스 i를 스왑하고 i를 증가합니다.
6. 루프가 끝난다면, 중심점과 i에 있는 요소와 스왑합니다. 중심점은 항상 작거나 큰 파티션 사이에 있습니다. 
7. 중심점의 인덱스를 반환합니다.
    
    이 알고리즘이 배열을 순회하는 동안, 네 가지 구역으로 배열을 나눕니다.
    
    1. a[low..<i]는 중심점보다 작거나 같은 모든 요소를 포함합니다.
    2. a[i…j-1]은 중심점보다 큰 모든 요소를 포함합니다.
    3. a[j…high-1]은 아직 비교하지 않은 요소입니다.
    4. a[high]는 중심점입니다.

```swift
[ values <= pivot | values > pivot | not compared yet | pivot ]
  low         i-1   i          j-1   j         high-1   high
```

### step-by-step

아래에는 정렬되지 않은 배열이 주어져있습니다.

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
```

첫 번째로, 가장 마지막 요소인 8이 중심점으로 선택되었습니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11    12
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
  i
  j
```

그 다음 첫 번째 요소인 12를 중심점과 비교합니다. 
이는 중심점보다 작지 않기 때문에, 다음 요소로 넘어갑니다.

```swift
   0  1  2  3  4  5   6   7   8  9  10  11   12
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
  low                                        high
  i
      j
```

두 번째 요소인 0은 8보다 작기 때문에, 현재의 요소인 12(인덱스 i)와 스왑하고, i를 증가시킵니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 12, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
 low                                         high
      i
         j
```

세 번째 요소인 3은 중심점보다 작기 때문에, 스왑이 일어납니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 3, 12, 9, 2, 21, 18, 27, 1, 5, 8, -1, |  8  ]
 low                                         high
         i
            j
```

이 단계는 중심점을 제외한 모든 요소를 비교할 때까지 진행합니다. 
결과는 다음과 같습니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11   12
[ 0, 3, 2, 1, 5, 8, -1, 27, 9, 12, 21, 18, |  8  ]
 low                                         high
                         i
```

마지막으로, 중심점은 인덱스 i에 있는 요소와 스왑합니다.

```swift
  0   1  2  3  4  5   6   7   8  9  10  11     12
[ 0, 3, 2, 1, 5, 8, -1 | 8 | 9, 12, 21, 18, |  27  ]
 low                                          high
                         i
```

Lumoto의 파티셔닝은 이제 끝났습니다. 
퀵정렬에서 피벗은 피벗보다 작거나 같은 요소들의 영역과 
피벗보다 큰 요소들의 영역 사이에 위치함을 주목하십시오.

퀵 정렬을 실행하면, 세 가지의 새로운 배열을 생성하고 정렬되지 않은 배열을 필터링하는 과정을 세 번 반복합니다. Lomuto의 알고리즘은 제자리에서 파티셔닝을 수행합니다. 이것이 훨씬 효율적입니다.

파티셔닝 알고리즘을 통해 퀵 정렬을 수행할 수 있습니다.

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

여기서 Lomuto의 알고리즘으로 배열을 두 지역으로 나눕니다. 그리고, 그 지역을 재귀적으로 정렬합니다.

```swift
var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list, low: 0, high: list.count - 1)
print(list)
```

### Hoarse’s partitioning

Hoare의 파티셔닝 알고리즘은 중심점을 항상 첫 번째 요소로 선택합니다. 

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

1. 첫 요소를 중심점으로 선택합니다.
2. 인덱스 i와 j는 두 지역을 정의합니다. i 이전의 모든 인덱스는 중심저보다 작거나 같을 것입니다. 
j 이후의 모든 인덱스는 중심점보다 크거나 같을 것입니다.
3. 중심점보다 크지 않은 요소를 만날 때까지 j를 줄입니다.
4. 중심점보다 작지 않은 요소를 만날 때까지 i를 증가시킵니다.
5. 만약 i와 j가 겹치지 않는다면 요소들을 스왑합니다.
6. 두 지역을 나누는 인덱스를 반환합니다.

### Step-by-step

정렬되지 않은 배열이 있습니다.

```swift
[  12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8   ]
```

12를 중심점으로 설정합니다. 그 다음 i와 j는 배열을 순회하면서, 작지 않거나 (i의 경우) 크지 않은 (j의 경우) 경우의 요소를 찾습니다. i은 12일 때, j는 8일 때 정지합니다.

```swift
[  12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1,  8  ]
   p
   i                                         j
```

이 요소들이 스왑되었습니다.

```swift
[  8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12 ]
   i                                       j
```

i와 j는 움직이기 시작하고, 이번에는 21과 -1에서 각각 멈춥니다. 

```swift
[  8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12 ]
                   i                    j
```

그리고 스왑됩니다.

```swift
[  8, 0, 3, 9, 2, -1, 18, 27, 1, 5, 8, 21, 12 ]
                   i                    j
```

그 다음, 27과 5 다음으로 18과 8이 스왑됩니다.

스왑 이후에, 배열과 인덱스는 다음과 같아집니다.

```swift
[  8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12 ]
                         i      j
```

i와 j를 움직일 때, 겹칠 것입니다.

```swift
[  8, 0, 3, 9, 2, -1, 8, 5, 1, 27, 18, 21, 12 ]
                            j   i
```

Hoare 알고리즘은 완료되었고, j는 두 지역을 나눕니다. Lomuto 알고리즘에 비해 적은 스왑이 일어납니다. 

그 다음 quicksortHoare 함수를 실행할 수 있습니다.

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

## Effects of a bad pivot choice

퀵 정렬을 실행하는 데에 있어서 가장 중요한 점은 올바은 파티셔닝 전략을 선택하는 것입니다.

세 가지의 다른 파티셔닝 전략을 살펴보았습니다.

1. 중간 요소를 중심점을 선택합니다.
2. Lomuto는 마지막 요소를 중심점으로 선택합니다.
3. Hoare는 첫 번째 요소를 중심점으로 선택합니다.

그렇다면 나쁜 중심점을 선택하는 것은 무엇일까요?

정렬되지 않은 배열부터 시작해봅시다.

```swift
[8, 7, 6, 5, 4, 3, 2, 1]
```

만약 Lomuto 알고리즘을 사용한다면, 중심점은 마지막 요소인 1이됩니다. 이 결과는 다음과 같은 분할을 수행합니다.

```swift
less: [ ]
equal: [1]
greater: [8, 7, 6, 5, 4, 3, 2]
```

이상적인 중심점은 요소를 큰 값과 작은 값을 나누는 것입니다. 이미 정렬된 배열에서 첫 번째나 마지막 요소를 중심점으로 선택하는 것은 삽입 정렬처럼 수행되는데, 이는 최악의 경우에 O(n^2)의 성능을 보여줍니다. 
이 문제를 해결하기 위한 방법은 세 개의 중앙값(median of three)선택 전략이 있습니다. 
여기서 배열의 첫 번째, 중간, 마지막 요소의 중앙값을 중심점으로 설정하는 것입니다. 
이러한 선택 전략은 배열 안에서 가장 높은 값과 가장 낮은 값을 선택하는 상황을 방지합니다. 

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

여기서 [low], [center], [high]를 정렬함으로써 중앙값을 찾았습니다. 중앙값은 함수가 반환하는 것처럼 인덱스 center에서 멈출 것입니다.

다음으로는 이 세 개의 중앙값을 이용해서 퀵 정렬의 변형을 실행해보겠습니다.

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

위 코드는 첫 단계에서 세 요소의 중앙값을 선택하는 것으로, quicksortLomuto의 변형입니다.

## Dutch national flag partitioning

Lomuto와 Hoare 알고리즘의 문제는 복제를 잘 다루지 않았다는 것입니다.
Lomuto 알고리즘은 작을 때의 분할만 복제되었고, 함께 그룹화되지 않았습니다. 
Hoare 알고리즘은 모든 곳에서 복제가 이루어질 수도 있기 때문에 더 최악입니다.

복제된 요소를 관리하는 방법으로는 Dutch national flag partitioning을 사용하는 것이 있습니다. 
이 기술은 네델란드 국기에서 이름을 따왔는데, 이는 세 가지의 파티션을 생성하는 것이 국기의 흰색, 빨간색, 파란색으로 나뉜 것과 비슷하기 때문입니다. 
Dutch national flag 파티셔닝은 복제된 요소가 많을 때 훌륭한 기술입니다. 

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

Lomuto 알고리즘의 전략처럼 마지막 인덱스를 pivotIndex로 선택하는 방법을 적용할 것입니다. 

1. 중심점보다 작은 값의 요소를 만난다면, 인덱스를 smaller로 움직입니다. 
이 규칙은 이 인덱스 전에 오는 모든 요소들은 중심점보다 값이 작은 것입니다.
2. equal 인덱스는 비교하기 위해 다음 요소를 가리킵니다. 
중심점과 같은 값은 넘어가는데, 이는 smaller와 equal 사이에 있는 값은 중심점과 값이 같다는 것입니다.
3. 중심점보다 큰 값을 만난다면, 인덱스를 larger로 움직입니다.
이 규칙은 이 인덱스 이후에 오는 모든 요소들은 중심점보다 값이 큰 것입니다.
4. 메인 루프는 요소들을 비교하고 필요하다면 스왑합니다. 
이 과정은 인덱스 equal이 larger를 지나칠 때까지 진행되는데, 이는 모든 요소가 제자리에 배치된 것입니다.
5. 알고리즘은 smaller와 larger의 인덱스를 반환합니다. 이는 중간 파티션의 첫 번째와 마지막 요소를 가리킵니다.

### step-by-step

정렬되지 않은 배열을 통해 확인해봅시다.

```swift
[ 12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8 ]
```

이 알고리즘은 중심점 선택 전략과 독립적이기 때문에, Lomuto 적용하고 마지막 요소인 8을 선택합니다.

다음으로, smaller, equal, larger 인덱스를 준비합니다.

```swift
[12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
  s
  e
                                          l
```

비교될 첫 번째 요소는 12입니다. 중심점보다 크기 때문에, larger 인덱스에 있는 값과 스왑되고, larger 인덱스는 감소합니다.

equal 인덱스는 증가하지 않았기 때문에, 스왑된 요소(8)는 다음에도 비교됩니다.

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
 e
                                      l
```

선택한 중심점은 여전히 8이라는 것을 기억하십시오. 
8은 중심점과 같기 때문에 equal을 증가시킵니다.

```swift
[8, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
 s
    e
                                      l
```

0은 중심점보다 작기 때문에 equal과 smaller에 있는 요소들을 스왑하고, 두 포인터를 증가시킵니다.

```swift
[0, 8, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 12]
    s
       e
                                      l
```

이를 계속합니다.

smaller, equal, larger가 어떻게 나뉘어졌는지 확인하십시오.

- [low..<smaller]에 있는 요소들은 중심점보다 작습니다.
- [smaller..<equal]에 있는 요소들은 중심점과 같습니다.
- [larger>..high]에 있는 요소들은 중심점보다 큽니다.
- [equal…larger]에 있는 요소들을 아직 비교되지 않았습니다.

알고리즘이 어떻게 끝나는지 이해하기 위해서, 두 번째부터 마지막 단계까지를 살펴봅시다.

```swift
[0, 3, -1, 2, 5, 8, 8, 27, 1, 18, 21, 9, 12]
                 s
                        e
                           l
```

여기서 27이 비교되었습니다. 이는 중심점보다 크기 때문에, 1과 스왑되고 larger 인덱스는 증가합니다.

```swift
[0, 3, -1, 2, 5, 8, 8, 1, 27, 18, 21, 9, 12]
                 s
                       e
                       l
```

비록 equal이 larger와 같아졌지만, 알고리즘은 끝나지 않았습니다.

현재 equal에 있는 요소는 아직 비교되지 않았습니다. 이는 중심점보다 작기 때문에 8과 스왑되고, smaller와 equal의 인덱스는 증가합니다.

```swift
[0, 3, -1, 2, 5, 1, 8, 8, 27, 18, 21, 9, 12]
                    s
                          e
                       l
```

smaller와 larger는 중간 파티션의 첫 번째와 마지막 요소를 가리키고 있습니다. 이들을 반환함으로써, 세 파티션의 경계선을 표시합니다.

이제 새로운 버전의 퀵 정렬인 Dutch national flag 파티셔닝을 실행할 준비가 완료되었습니다.

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

재귀가 middleFirst와 middleLast 인덱스를 사용하여 재귀적으로 정렬해야할 파티션을 결정하는 것을 주목하십시오. 피벗과 동일한 값을 가진 요소들은 함께 그룹화되기 때문에 재귀적으로 정렬하는 과정에서 제외될 수 있습니다.

```swift
var list4 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortDutchFlag(&list4, low: 0, high: list4.count - 1)
print(list4)
```

## Key points

- 순수 파티셔닝은 모든 filter 함수마다 새로운 배열을 생성합니다. 매우 비효율적입니다. 
다른 모든 전략들은 제자리에서 정렬을 진행합니다.
- Lomuto의 파티셔닝은 마지막 요소를 중심점으로 선택합니다.
- Hoare의 파티셔닝은 첫 번째 요소를 중심점으로 선택합니다.
- 이상적인 중심점은 파티션 간의 요소들을 동등하게 나누는 것입니다.
- 나쁜 중심점을 선택한다면 퀵정렬이 O(n^2)의 성능을 보일 수 있습니다.
- 세 개의 중앙값은 첫 번째, 중간, 마지막 요소의 중앙값을 통해 중심점을 찾는 것입니다.
- Dutch national flag 파티셔닝은 복제된 요소를 더욱 효율적으로 정리할 수 있도록하는 전략입니다.
