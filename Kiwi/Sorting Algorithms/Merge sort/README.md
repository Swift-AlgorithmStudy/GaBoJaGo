# Merge sort

합병 정렬(Merge sort)은 분할 정복(Divide and Conquer) 기법을 사용하여 정렬하는 알고리즘이다. 큰 문제를 작은 문제로 나눈 뒤, 작은 문제들을 정렬하고 다시 합쳐서 정렬된 결과를 얻는 방식으로 동작한다.

합병 정렬은 다음과 같은 단계로 이루어진다:

1. 분할(Divide): 정렬되지 않은 리스트를 반으로 나눈다. 이를 계속해서 리스트가 더 이상 분할할 수 없을 때까지 반복한다. 각각의 작은 부분 리스트로 나누어진다.

2. 정복(Conquer): 각각의 작은 부분 리스트를 재귀적으로 정렬한다. 리스트의 크기가 충분히 작아지면 정렬할 필요가 없으므로 기저 조건으로 설정된다.

3. 결합(Combine): 정렬된 작은 부분 리스트들을 합병하여 하나의 정렬된 리스트를 생성한다. 작은 부분 리스트들을 비교하면서 순서대로 합병해 나가는 과정이다.

합병 정렬은 분할과 정복 단계에서 재귀적으로 동작하며, 결합 단계에서 정렬된 작은 부분 리스트들을 효율적으로 합병한다. 이 알고리즘은 안정적이고 예측 가능한 성능을 가지며, 일반적으로 큰 데이터셋에 대해서도 효율적인 정렬을 제공한다. 시간 복잡도는 O(n log n)이며, 최악의 경우에도 효율적인 정렬을 수행한다.

## 구현

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
  guard array.count > 1 else {
    return array
  }
  let middle = array.count / 2
  let left = mergeSort(Array(array[..<middle]))
  let right = mergeSort(Array(array[middle...]))
  return merge(left, right)
}

private func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
  var leftIndex = 0
  var rightIndex = 0
  var result: [Element] = []
  while leftIndex < left.count && rightIndex < right.count {
    let leftElement = left[leftIndex]
    let rightElement = right[rightIndex]
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
  if leftIndex < left.count {
    result.append(contentsOf: left[leftIndex...])
  }
  if rightIndex < right.count {
    result.append(contentsOf: right[rightIndex...])
  }
  return result
}


/*
mergeSort 함수는 주어진 배열을 분할하고 정렬하는 역할을 수행한다. 
배열의 크기가 1보다 작을 경우, 즉 원소가 하나인 경우에는 그대로 반환한다. 
그렇지 않은 경우에는 배열을 반으로 나누어 재귀적으로 mergeSort 함수를 호출한 뒤, 
나누어진 부분 배열들을 merge 함수를 사용하여 합병한다. 최종적으로 합병된 결과를 반환한다.

merge 함수는 두 개의 부분 배열(left와 right)을 합병하는 역할을 수행한다. 
왼쪽 배열과 오른쪽 배열의 인덱스를 각각 leftIndex와 rightIndex로 초기화하고,
두 인덱스가 각각 부분 배열의 범위 내에 있는 동안 반복문을 실행한다. 
반복문 내에서는 현재 비교 중인 왼쪽 원소와 오른쪽 원소를 비교하여 작은 원소를 result 배열에 추가한다. 
원소가 같은 경우에는 양쪽 모두를 추가한다. 
반복문이 종료된 후에는 남은 원소들을 result 배열에 추가한다.
*/
```
