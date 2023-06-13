# Chapter 28: Merge Sort

병합 정렬은 가장 효율적인 정렬 알고리즘 중 하나입니다. 시간 복잡도가 O(n log n)이므로 일반적인 정렬 알고리즘 중에서 가장 빠릅니다. 병합 정렬의 아이디어는 '분할 정복'입니다. 큰 문제를 여러 개의 작은 문제로 나누어 해결하기 쉬운 문제로 바꾼 다음 이러한 해결책을 최종 결과물로 결합하는 것입니다. 병합 정렬의 규칙은 먼저 나누고, 그 후에 병합하는 것입니다. 이 장에서는 처음부터 병합 정렬을 구현해 보겠습니다. 예시로 시작해 봅시다.

# 예시

가정하자면, 정렬되지 않은 플레잉 카드 더미가 주어졌다고 가정해봅시다.

<img width="500" alt="스크린샷 2023-06-13 오전 9 51 21" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/0b12eba6-aa98-407e-97af-05ee61e2f398">

병합 정렬 알고리즘은 다음과 같이 작동합니다:

1. 먼저, 더미를 절반으로 나눕니다. 이제 정렬되지 않은 두 개의 더미가 생깁니다.

<img width="600" alt="스크린샷 2023-06-13 오전 9 52 02" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/1f7a8853-22f6-48b3-802d-10dc0eb19e46">

1. 이제 결과로 나온 더미들을 더 이상 나눌 수 없을 때까지 계속해서 나눕니다. 최종적으로, 각 더미에는 하나의 (정렬된!) 카드가 들어있게 됩니다.

<img width="700" alt="스크린샷 2023-06-13 오전 9 52 13" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/c021a57a-c78c-432b-abc0-4356323a380a">


1. 마지막으로, 나눴던 역순으로 더미들을 병합합니다. 각 병합 과정에서는 내용물을 정렬된 순서로 배치합니다. 각 더미가 이미 정렬되어 있기 때문에 이 과정은 쉽습니다.

<img width="800" alt="스크린샷 2023-06-13 오전 9 52 33" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/5694d75d-65c0-4ec2-95aa-337998a9a197">

# 구현

## Split
****

여기서는 배열을 반으로 나눕니다. 한 번 나누는 것으로는 충분하지 않습니다. 그러나 더 이상 나눌 수 없을 때까지 재귀적으로 계속 나누어야 합니다. 이는 각 부분이 단 하나의 요소만 포함할 때입니다.

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
	// 재귀는 기본 사례(base case) 또는 "탈출 조건"이 필요합니다.
	// 이 경우, 기본 사례는 배열에 하나의 요소만 있는 경우입니다.
	guard array.count > 1 else {
		return array
	}
	let middle = array.count / 2
	// 이제 원래 배열의 왼쪽 절반과 오른쪽 절반에 대해 mergeSort를 호출합니다.
	// 배열을 반으로 나눈 후에는 다시 반으로 나누려고 합니다.
	// 코드가 컴파일될 수 있도록 더 많은 작업이 필요합니다.
	// 이제 나누기 부분을 완료했으므로 병합에 집중할 시간입니다.
	let left = mergeSort(Array(array[..<middle]))
	let right = mergeSort(Array(array[middle...]))
	// ... more to come
}
```

## Merge
마지막 단계는 왼쪽 배열과 오른쪽 배열을 병합하는 것입니다. 코드를 깔끔하게 유지하기 위해 이를 위한 별도의 merge 함수를 작성할 것입니다.
병합 함수의 유일한 책임은 두 개의 정렬된 배열을 받아들여 정렬 순서를 유지하면서 결합하는 것입니다. 다음을 mergeSort 함수 바로 아래에 추가해주세요.

```swift
private func merge<Element>(_ left: [Element], _ right: [Element]) -> [Element] where Element: Comparable {
	// leftIndex와 rightIndex 변수는 두 배열을 파싱하는 동안 진행 상황을 추적합니다.
	var leftIndex = 0
	var rightIndex = 0
	// result 배열은 결합된 배열을 저장합니다.
	var result: [Element] = []
	// 처음부터 시작하여 왼쪽 배열과 오른쪽 배열의 요소를 순차적으로 비교합니다. 두 배열 중 하나의 끝에 도달하면 비교할 요소가 없습니다.
	while leftIndex < left.count && rightIndex < right.count {
		let leftElement = left[leftIndex]
		let rightElement = right[rightIndex]
		// 두 요소 중 작은 요소를 result 배열에 넣습니다. 요소가 같은 경우에도 모두 추가할 수 있습니다.
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
	// 첫 번째 루프는 left 또는 right 중 하나가 비어 있는 것을 보장합니다.
	// 두 배열 모두 정렬되어 있으므로, 남은 요소들은 현재 result에 있는 요소보다 크거나 같음을 보장합니다.
	// 이 경우 비교 없이 나머지 요소들을 추가할 수 있습니다.
	if leftIndex < left.count {
		result.append(contentsOf: left[leftIndex...])
	}
	if rightIndex < right.count {
		result.append(contentsOf: right[rightIndex...])
	}
	return result
}
```

## Finishing up

mergeSort 함수를 완성하기 위해 merge를 호출해주세요. mergeSort를 재귀적으로 호출하므로, 알고리즘은 병합하기 전에 양쪽 절반을 모두 나누고 정렬합니다.

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
	guard array.count > 1 else {
		return array
	}
	let middle = array.count / 2
	let left = mergeSort(Array(array[..< middle]))
	let right = mergeSort(Array(array[middle...]))
	return merge(left, right)
}
```

이 코드는 병합 정렬 알고리즘의 최종 버전입니다. 병합 정렬의 주요 절차를 요약하면 다음과 같습니다:

1. 병합 정렬의 전략은 큰 문제 하나 대신 많은 작은 문제를 해결하여 분할 정복하는 것입니다.
2. 이 알고리즘에는 두 가지 핵심 역할이 있습니다: 초기 배열을 재귀적으로 분할하는 메서드와 두 배열을 병합하는 메서드입니다.
3. 병합 함수는 두 개의 정렬된 배열을 받아 하나의 정렬된 배열을 생성해야 합니다.

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

# Performance

병합 정렬의 최선, 최악 및 평균 시간 복잡도는 O(n log n)으로, 그리 나쁘지 않습니다. n log n이 어디에서 나오는지 이해하기 어려울 경우, 재귀가 어떻게 작동하는지 생각해보세요:

- 일반적으로 크기가 n인 배열이 주어진 경우, 레벨의 수는 log2(n)입니다. 재귀를 진행할 때마다 하나의 배열을 두 개의 작은 배열로 나눕니다. 따라서 크기가 2인 배열은 한 단계의 재귀가 필요하며, 크기가 4인 배열은 두 단계의 재귀가 필요하고, 크기가 8인 배열은 세 단계의 재귀가 필요하며, 이와 같은 식입니다. 만약 1,024개의 요소로 이루어진 배열이 있다면, 1,024개의 단일 요소 배열로 분할하기 위해 10단계의 재귀가 필요합니다.
- 단일 재귀의 비용은 O(n)입니다. 단일 재귀 수준은 n개의 요소를 병합합니다. 작은 병합이 많이 있든 큰 병합이 하나 있든 각 수준에서 병합되는 요소의 수는 여전히 n입니다.

이로써 전체 비용은 O(log n) × O(n) = O(n log n)이 됩니다.
이전 장의 정렬 알고리즘은 in-place이고 swapAt을 사용하여 요소를 이동했습니다. 반면에 병합 정렬은 추가적인 메모리를 할당하여 작업을 수행합니다. 얼마나 많이 할당되는지는 log2(n) 수준의 재귀가 있고, 각 수준에서 n개의 요소가 사용된다는 것을 고려하면, 전체 공간 복잡도는 O(n log n)입니다. 병합 정렬은 대표적인 정렬 알고리즘 중 하나입니다. 비교적 이해하기 쉽고 분할 정복 알고리즘 작동 방식에 대한 좋은 소개 역할을 합니다. 병합 정렬은 O(n log n)이며, 이 구현은 O(n log n)의 공간을 필요로 합니다. 메모리 사용량을 효율적으로 관리하면 사용되지 않는 메모리를 폐기하여 필요한 메모리를 O(n)으로 줄일 수 있습니다.

# **Key points**

- 병합 정렬은 분할 정복 알고리즘의 한 종류입니다.
- 병합 정렬에는 여러 가지 구현 방식이 있으며, 구현 방식에 따라 다른 성능 특성을 가질 수 있습니다.