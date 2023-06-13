# Merge Sort

합병 정렬은 정렬 알고리즘 중 가장 효율적인 알고리즘 중 하나입니다. 
O(n log n)의 시간 복잡도를 가짐으로, 일반적인 정렬 알고리즘 중 가장 가장 속도를 가집니다.

합병 정렬은 분할정복(divide and conquer)이라는 아이디어에서부터 시작되었습니다. 
이는 큰 문제를 풀기 쉬운 작은 단위로 나눈 뒤, 마지막 결과물에 해결책을 합치는 방법입니다.

합병 정렬은 ‘먼저 분할하고, 나중에 합병’하는 방법입니다.

## Example

정렬되지 않은 카드 더미가 있다고 가정해봅시다.

<img width="360" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ca0f0087-2845-4789-a4a8-de6e26ea96b1">

1. 먼저, 카드 더미를 반으로 나눕니다. 이제 두 개의 정렬되지 않은 카드 더미가 있습니다.

<img width="347" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/52fe4e43-25dd-42a6-9320-a130708e55e0">

1. 더 이상 나눌 수 없을 때까지 카드 더미를 나눕니다. 
결국엔 각 카드 더미엔 하나의 카드만 남게 될 것입니다.

<img width="384" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/db1effe2-66da-4f26-8e30-5a6ebd67ae86">

1. 마지막으로, 더미를 분할한 역순으로 병합합니다. 
각각의 병합이 진행될 때, 정렬된 상태로 병합합니다. 

<img width="375" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/fe35e753-fd8f-4c2b-a4f8-30957ff353e1">


## Implementation

## Split

```swift
public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
  let middle = array.count / 2
  let left = Array(array[..<middle])
  let right = Array(array[middle...])
  // ... more to come
}
```

배열을 반으로 나눕니다. 한 번 나누는 것은 충분하지 않습니다. 
하나의 요소만 남을 때까지 재귀적으로 나눠야합니다.

그렇게 하기 위해선, mergeSort 메소드를 업데이트 해야합니다.

```swift
public func mergeSort<Element>(_ array: [Element])
    -> [Element] where Element: Comparable {
  // 1
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

위 식에선 두 가지의 변화가 있습니다.

1. 재귀에는 “탈출 조건”으로도 알고 있는 base case가 필요합니다. 
위 경우의 base case는 배열이 오직 하나의 요소만 가지고 있을 때를 말합니다.
2. mergeSort를 호출하여 원래 배열의 왼쪽 반과 오른쪽 반으로 분할합니다. 배열을 절반으로 나누면 바로 다시 분할을 시도합니다. 이 과정은 배열에 하나의 요소만 남을 때까지 계속됩니다.

이제 나누는 부분은 끝났고, 병합하는 과정을 해야합니다.

## Merge

마지막 단계는 왼쪽과 오른쪽 배열을 병합하는 것입니다. 
깔끔하게 만들기 위해, merge 함수를 나눕니다.

merge 함수의 역할은 두 개의 정렬된 배열을 가지고 정렬을 유지한 채로 합치는 것입니다.

mergeSort 함수 밑에 식을 추가해줍니다.

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

1. leftIndex와 rightIndex 변수는 두 배열을 파싱하면서 진행 상황을 추적합니다.
2. 결과 배열은 결합된 배열을 담게됩니다.
3. 처음부터 시작하여, 왼쪽과 오른쪽 배열을 차례대로 비교합니다. 
둘 중 하나의 배열이라도 끝에 도달하게 되면, 더 이상 비교할 것이 없는 것입니다.
4. 두 요소 중 작은값은 결과 배열에 들어갑니다. 만약 요소의 값이 같다면, 둘 다 추가될 수 있습니다.
5. 첫 번째 루프는 왼쪽이나 오른쪽이 비어있는지 확인해줍니다. 
두 배열이 정렬되어 있기 때문에, 남아있는 요소가 현재 결과에 들어있는 값보다 크거나 같음이 보장됩니다.

## Finishing up

merge 함수를 호출하여 mergeSort 함수를 완료합니다. 
mergeSort를 재귀적으로 호출했기 때문에, 합병되기 전에 나누고 정렬할 것입니다.

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

1. 합병 정렬의 전략은 분할정복으로, 하나의 큰 문제를 해결하는 것이 아니라 매우 작은 문제들을 해결하는 것입니다.
2. 초기 배열을 재귀적으로 나누는 거과 두 배열을 합병하는 두 개의 중요한 역할이 있습니다.
3. merging 함수는 두 개의 정렬된 함수를 가지고 하나의 정렬된 배열을 반환해야 합니다.

```swift
example(of: "merge sort") {
  let array = [7, 2, 6, 3, 9]
  print("Original: \(array)")
  print("Merge sorted: \(mergeSort(array))")
}

---Example of merge sort---
Original: [7, 2, 6, 3, 9]
Merge sorted: [2, 3, 6, 7, 9]
```

## Performance

합병 정렬의 시간 복잡도는 O(n log n)으로 엄청 나쁘지는 않습니다. 
만약 n log n이 어떻게 나왔는지 알고 싶다면, 재귀가 어떻게 작동하는 지 확인해보면 됩니다.

- 일반적으로, 만약 n크기의 배열을 가지고 있다면, 레벨의 수는 long2(n)입니다. 
재귀를 할 때마다, 배열을 더 작은 배열로 나눕니다. 이는 크기가 2인 배열은 1의 재귀 레벨이 필요하다는 것이고, 크기가 4인 배열은 2의 재귀 레벨이 필요한 것이고, 크기가 8인 배열은 3의 재귀 레벨이 필요한 것입니다.
- 한 번의 재귀는 O(n)입니다. 한 번의 재귀 레벨은 n 요소를 합병할 것입니다. 
하나의 큰 것을 합병하거나 여러 개의 작은 요소를 합병하는 것의 여부는 상관 없이 각각의 레벨에서 n일 것입니다.

이는 총 O(log n) * log(n) = O(n log n)입니다.

## Key points

- 이번 카테고리의 합병 정렬은 분할정복 알고리즘을 사용합니다.
- 합병 정렬에는 여러가지 구현 방법이 있으며, 어떤 특징의 구현을 하느냐에 따라 다른 성능을 보입니다.
