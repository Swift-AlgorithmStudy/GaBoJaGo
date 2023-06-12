# Chap13. Merge Sort

머지 정렬은 가장 효율적인 정렬 알고리즘 중 하나이다. O(n log n)의 시간 복잡성으로, 그것은 모든 범용 정렬 알고리즘 중 가장 빠른 것 중 하나이다. 머지 정렬의 이면에 있는 아이디어는 큰 문제를 몇 가지 더 작고 해결하기 쉬운 문제로 나누고 그 해결책을 최종 결과로 결합하는 것이다. 머지 정렬 만트라는 먼저 분할하고 그 후에 병합하는 것이다. 이 장에서, 당신은 처음부터 머지 정렬을 구현할 것입니다. 

## 예시

정렬되지 않은 [7, 2, 6, 3, 9]

1. 먼저, 더미를 반으로 나누세요. 당신은 이제 두 개의 분류되지 않은 더미를 가지고 있습니다.
[7, 2] [6, 3, 9]
2. 이제, 더 이상 나눌 수 없을 때까지 결과 더미를 계속 나누세요. 결국, 당신은 각 더미에 정렬된 카드 하나를 갖게 될 것입니다.
    1. [7] [2] [6] [3, 9]
    2. [7] [2] [6] [3] [9]
3. 마지막으로, 더미를 나누는 역순으로 병합하세요. 각 병합 중에, 당신은 내용을 정렬된 순서로 배치합니다. 각 더미가 이미 정렬되어 있기 때문에 이 과정은 쉽다:
    1. [2, 7] [3, 6] [9]
    2. [2,3,6,7] [9]
    3. [2,3,6,7,9]
    

## 구현

### **Split**

MergeSort.swift

```swift
public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
  //1
  guard array.count > 1 else {
    return array
  }
  let middle = array.count / 2
  // 2
  let left = mergeSort(Array(array[..<middle]))
  let right = mergeSort(Array(array[middle...]))

  // ... more to come
}
```

1. 재귀에는 "종료 조건"으로 생각할 수 있는 기본 사례가 필요합니다. 이 경우, 기본 경우는 배열에 하나의 요소만 있을 때이다.
2. 이제 원래 배열의 왼쪽과 오른쪽 절반에서 mergeSort를 호출하고 있습니다. 배열을 반으로 나누자마자, 다시 나누려고 시도할 것입니다.

### Merge

마지막 단계는 왼쪽과 오른쪽 배열을 병합하는 것입니다. Clean하게 유지하기 위해, 당신은 이것을 위한 별도의 병합(머지) 기능을 만들 것입니다.

병합 함수의 유일한 책임은 두 개의 정렬된 배열을 가져와 정렬 순서를 유지하면서 결합하는 것이다. mergeSort 기능 바로 아래에 다음을 추가하세요:

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

1. 왼쪽 인덱스와 오른쪽 인덱스 변수는 두 배열을 구문 분석할 때 진행 상황을 추적합니다.
2. 결과 배열은 결합된 배열을 수용할 것이다.
3. 처음부터 왼쪽과 오른쪽 배열의 요소를 순차적으로 비교합니다. 두 배열의 끝에 도달했다면, 비교할 것이 없습니다.
4. 두 요소 중 작은 것은 결과 배열에 들어간다. 요소가 같다면, 둘 다 추가할 수 있다.
5. 첫 번째 루프는 왼쪽이나 오른쪽이 비어 있음을 보장합니다. 두 배열이 모두 정렬되기 때문에, 이것은 남은 요소가 현재 결과보다 크거나 같도록 보장한다. 이 시나리오에서는 비교 없이 나머지 요소를 추가할 수 있습니다.

### Finishing up

merge를 호출하여 mergeSort 기능을 완료하세요. mergeSort를 재귀적으로 호출하기 때문에, 알고리즘은 병합하기 전에 두 반쪽을 분할하고 정렬합니다.

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

이 코드는 병합 정렬 알고리즘의 최종 버전입니다. 다음은 병합 정렬의 주요 절차에 대한 요약입니다:

1. 병합 정렬의 전략은 하나의 큰 문제 대신 많은 작은 문제를 해결할 수 있도록 나누고 정복하는 것이다.
2. 그것은 두 가지 핵심 책임이 있다: 초기 배열을 재귀적으로 나누는 방법과 두 배열을 병합하는 방법.
3. 병합 함수는 두 개의 정렬된 배열을 가져와 하나의 정렬된 배열을 생성해야 합니다.

## Performance

병합 정렬의 최상, 최악 및 평균 시간 복잡도는 O(n log n)입니다. 이는 그리 나쁘지 않은 성능입니다. 만약 n log n이 어디에서 나오는지 이해하기 어렵다면, 재귀가 어떻게 동작하는지 생각해보세요:

- 일반적으로 크기가 n인 배열이 주어진 경우, 레벨의 수는 log2(n)입니다. 재귀를 수행하면 하나의 배열을 두 개의 작은 배열로 나누게 됩니다. 따라서 크기가 2인 배열은 한 단계의 재귀가 필요하고, 크기가 4인 배열은 두 단계의 재귀가 필요하며, 크기가 8인 배열은 세 단계의 재귀가 필요하게 됩니다. 예를 들어 1,024개의 요소로 이루어진 배열이 있다면, 10단계의 재귀를 통해 1,024개의 단일 요소 배열로 분할될 수 있습니다.
- 한 번의 재귀의 비용은 O(n)입니다. 하나의 재귀 레벨은 n개의 요소를 병합합니다. 작은 병합이 많이 있든 하나의 큰 병합이 있든 각 레벨에서 병합되는 요소의 수는 여전히 n입니다.

따라서 전체 비용은 O(log n) × O(n) = O(n log n)이 됩니다.

이전 장의 정렬 알고리즘은 인-플레이스로 작동하며, 요소를 이동하기 위해 swapAt을 사용했습니다. 그에 반해, 병합 정렬은 작업을 수행하기 위해 추가적인 메모리를 할당합니다. 그 양은 얼마나 될까요? 재귀의 수준인 log2(n)이 있고, 각 수준에서 n개의 요소가 사용됩니다. 이로 인해 전체 공간 복잡도는 O(n log n)이 됩니다. 병합 정렬은 가장 유명한 정렬 알고리즘 중 하나입니다. 비교적 이해하기 쉽고 분할 정복 알고리즘의 작동 방식을 소개하는 좋은 기회가 됩니다. 병합 정렬의 시간 복잡도는 O(n log n)이며, 이 구현은 O(n log n)의 공간을 요구합니다. 만약 적절한 메모리 관리를 한다면, 사용 중이 아닌 메모리를 폐기하여 필요한 메모리를 O(n)으로 줄일 수 있습니다.

## 🗝️ Key points

- 병합 정렬은 분할 및 정복 알고리즘의 카테고리에 속한다.
- 병합 정렬에는 많은 구현이 있으며, 구현에 따라 다른 성능 특성을 가질 수 있습니다.
