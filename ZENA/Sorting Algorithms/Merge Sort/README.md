# Merge Sort

병합 정렬은 가장 효율적인 정렬 알고리즘 중 하나이다. O(n log n)의 시간 복잡도로, 모든 범용 정렬 알고리즘 중 가장 빠른 것 중 하나이다. 병합 정렬은 큰 문제를 몇 가지 더 작고 해결하기 쉬운 문제로 나누고 그 해결책을 최종 결과로 결합하는 것이다. 병합 정렬 만트라는 먼저 분할하고 그 후에 병합하는 것이다. 이 장에서, 처음부터 병합 정렬을 구현한다. 예시부터 시작.

## Example

정렬되지 않은 게임 카드가 있다고 하자:

<img width="700" alt="스크린샷 2023-06-13 오전 10 41 02" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/10af762d-68c6-4631-ade3-0e9faa23724c">

머지 소트 알고리즘은 다음과 같이 동작한다:

1. 일단, 카드더미를 반으로 나눈다. 정렬되지 않은 카드 두 더미를 갖게 된다.

<img width="700" alt="스크린샷 2023-06-13 오전 10 41 15" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/9f07044b-932a-4a24-8981-c6e0f88cf751">

2. 이제, 더이상 쪼갤 수 없을 때까지 더미 split을 계속한다. 마지막에는 각 더미마다 단 하나의 (정렬된) 카드를 갖게 된다.

<img width="700" alt="스크린샷 2023-06-13 오전 10 41 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/6f3c7961-2954-48b4-b127-86b553e2180b">

<img width="700" alt="스크린샷 2023-06-13 오전 10 41 43" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/8b1e57d3-e2c5-49c3-a2be-f8f91ff0da4a">

3. 마지막으로, 더미를 나눠온 역순으로 다시 합친다. merge하면서 카드들을 정렬된 순서대로 놓는다. 각 파일들이 이미 정렬되어 있어 이 과정은 쉽다!

<img width="701" alt="스크린샷 2023-06-13 오전 10 42 01" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/a44f78cb-faa1-4c27-807d-8e2bdc181fba">

<img width="701" alt="스크린샷 2023-06-13 오전 10 42 16" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/021ab0f3-0567-4fe4-953e-f43d27ecfa28">

<img width="700" alt="스크린샷 2023-06-13 오전 10 42 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/6bc62af6-efac-4d82-9aba-393fd7d82d9b">

## Implementation

### Split

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
  let middle = array.count / 2
  let left = Array(array[..<middle])
  let right = Array(array[middle...])
  // ... more to come
}
```

여기서 배열을 반으로 나눈다. 한 번 나누는 것만으로는 충분하지 않다. 더 이상 분할할 수 없을 때까지 재귀적으로 계속 분할해야 한다. 이는 각 세분화된 더미에 하나의 요소만 포함되어 있을 때이다.

이렇게 하려면, 다음과 같이 mergeSort를 업데이트한다:

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
  // 1
  guard array.count > 1 else { return array }
  let middle = array.count / 2
  // 2
  let left = mergeSort(Array(array[..<middle]))
  let right = mergeSort(Array(array[middle...]))
  // ... more to come
}
```

여기서 변경된 두 가지:

1. 재귀에는 "종료 조건"으로 생각할 수 있는 기본 사례가 필요하다. 이 경우, 기본 경우는 배열에 하나의 요소만 있을 때이다.
2. 이제 원래 배열의 왼쪽과 오른쪽 절반에서 mergeSort를 호출하고 있다. 배열을 반으로 나누자마자, 다시 나누려고 시도할 것이다.

코드가 컴파일되기 전에 해야 할 일이 더 많다. 이제 분할 부분을 완료했으니, 병합에 집중해보자자자자

### Merge

마지막 단계는 왼쪽과 오른쪽 배열을 병합하는 것이다. 깔끔한 동작을 위해 이를 위한 별도의 병합 기능을 만들 것이다.

병합 함수의 유일한 책임은 **두 개의 정렬된 배열을 가져와 정렬 순서를 유지하면서 결합하는 것**이다. mergeSort 기능 바로 아래에 다음을 추가한다:

```swift
private func merge<Element>(_ left: [Element], _ right: [Element])
    -> [Element] where Element: Comparable {
  // 1
  var leftIndex = 0
  var rightIndex = 0
  // 2
  var result: [Element] = []
  // 3
  while leftIndex < left.count && rightIndex < right.count {
    let leftElement = left[leftIndex]
    let rightElement = right[rightIndex]
    // 4
    if leftElement < rightElement {
      result.append(leftElement)
      leftIndex += 1
    } else if leftElement > rightElement {
      result.append(rightElement)
      rightIndex += 1
    } else {
      result.append(leftElement)
      leftIndex += 1
      result.append(rightElement)
      rightIndex += 1
    }
  }
  // 5
  if leftIndex < left.count {
    result.append(contentsOf: left[leftIndex...])
  }
  if rightIndex < right.count {
    result.append(contentsOf: right[rightIndex...])
  }
  return result
}
```

코드 분석:

1. `leftIndex`와 `rightIndex` 변수는 두 배열을 분석할 때 진행 상황을 추적한다.
2. 결과 배열은 결합된 배열을 담을 것 이다.
3. 처음부터 왼쪽과 오른쪽 배열의 요소를 순차적으로 비교한다. 두 배열의 끝에 도달했다면, 비교할 것이 없는 것이다.
4. 두 요소 중 **작은 것**은 결과 배열에 들어간다. 요소가 같다면, 둘 다 추가할 수 있다.
5. 첫 번째 루프는 왼쪽이나 오른쪽이 비어 있음을 보장한다. 두 배열이 모두 정렬되기 때문에, 이것은 남은 요소가 현재 결과보다 크거나 같도록 보장한다. 이 시나리오에서는 비교 없이 나머지 요소를 추가할 수 있다.

### Finishing up

병합을 호출하여 mergeSort 기능을 끝내보자. mergeSort를 재귀적으로 호출하기 때문에, 알고리즘은 병합하기 전에 두 반쪽을 분할하고 정렬한다.

```swift
public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
  guard array.count > 1 else {
    return array
  }
  let middle = array.count / 2
  let left = mergeSort(Array(array[..< middle]))
  let right = mergeSort(Array(array[middle...]))
  return merge(left, right)
}
```

이 코드는 병합 정렬 알고리즘의 최종 버전! 다음은 병합 정렬의 주요 절차에 대한 요약이다:

1. 병합 정렬의 전략은 **하나의 큰 문제 대신 많은 작은 문제를 해결할 수 있도록 나누고 정복하는 것 Divide and Conquer**이다.
2. 그것은 두 가지 핵심 책임이 있다: **초기 배열을 재귀적으로 나누는 방법**과 **두 배열을 병합하는 방법**.
3. 병합 함수는 두 개의 정렬된 배열을 가져와 하나의 정렬된 배열을 생성해야 한다.

마지막으로 - 확인해 볼 시간이다. 다음과 같이 병합 정렬을 테스트해:

```swift
example(of: "merge sort") {
  let array = [7, 2, 6, 3, 9]
  print("Original: \(array)")
  print("Merge sorted: \(mergeSort(array))")
}

/*
    This outputs:
    ---Example of merge sort---
    Original: [7, 2, 6, 3, 9]
    Merge sorted: [2, 3, 6, 7, 9]
 */
```

## Performance

병합 정렬의 **최고, 최악 및 평균 시간 복잡성은** `O(n log n)`이며, 이는 그렇게 나쁘지 않다. N log n이 어디에서 왔는지 이해하기 위해 고군분투하고 있다면, 재귀가 어떻게 작동하는지 생각해 봐라:

- 일반적으로, 크기 n의 배열이 있다면, 레벨 수는 `log2(n)`입니다. 반복할 때, 당신은 하나의 배열을 두 개의 더 작은 배열로 나눈다. 이때 크기 2의 배열에는 하나의 재귀 레벨이 필요하고, 크기 4의 배열에는 두 개의 레벨이 필요하며, 크기 8의 배열에는 세 개의 레벨이 필요하다는 것을 의미한다. 1,024개의 요소 배열이 있다면, 1024개의 단일 요소 배열로 내려가려면 두 개로 재귀적으로 분할하는 10단계가 필요할 것이다.
- 단일 재귀 비용은 `O(n)`이다. 단일 재귀 레벨은 n개의 요소를 병합할 것이다. 많은 작은 병합이 있든 하나의 큰 병합이 있는지는 중요하지 않다; 병합된 요소의 수는 여전히 각 수준에서 n이 될 것이다.

이것은 총 비용을 `O(log n) × O(n) = O(n log n)`로 가져옵니다.

이전 장의 정렬 알고리즘은 제자리에 있었고 swapAt를 사용하여 요소를 이동했다. 대조적으로, 병합 정렬은 작업을 하기 위해 **추가 메모리**를 할당한다. 얼마나인가? Log2(n) 수준의 재귀가 있으며, 각 수준에서 n개의 요소가 사용된다. 그것은 **공간의 총** `O(n log n)`**을 복잡하게** 만든다. 병합 정렬은 특징적인 정렬 알고리즘 중 하나이다. 그것은 이해하기가 비교적 간단하며 분할과 정복 알고리즘이 어떻게 작동하는지에 대한 훌륭한 소개 역할을 한다. 병합 정렬은 `O(n log n)`이며, 이 구현에는 `O(n log n)의 공간`이 필요합니다. bookkeeping에 영리하다면, 적극적으로 사용되지 않는 메모리를 폐기하여 `O(n)`에 필요한 메모리를 줄일 수 있다.

## 🔑 Key points

- 병합 정렬은 **분할-정복 알고리즘**의 카테고리에 속한다.
- 병합 정렬에는 많은 구현이 있으며, 구현에 따라 다른 성능 특성을 가질 수 있다.
