# Chapter 20: Binary Search

이진 검색은 O(logn)의 시간 복잡도를 가진 가장 효율적인 검색 알고리즘 중 하나입니다.

이진 검색을 사용하기 전에 충족해야 하는 두 가지 조건이 있습니다

1. RandomAccessCollection이어야 합니다.
ex) array[3]
2. 컬렉션은 정렬되어 있어야 합니다.

## Example

이진 검색의 이점은 선형 검색과 비교하여 가장 잘 설명됩니다.

Swift의 Array 타입은 firstIndex(of:) 메서드를 구현하기 위해 선형 검색을 사용합니다.

이는 컬렉션 전체를 탐색하거나 첫 번째 요소를 찾을 때까지 순회합니다.

시간복잡도: O(n)

<img width="500" alt="스크린샷 2023-06-01 오전 8 54 55" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/4466ed3b-e458-46a9-917e-71ad53d2a746">

이진 검색은 컬렉션이 이미 정렬되어 있다는 사실을 활용하여 다른 방식으로 처리합니다.

<img width="500" alt="스크린샷 2023-06-01 오전 8 55 35" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/bcd019e9-6b85-4d51-981e-3755c29ff487">

31을 찾기 위해 8단계가 필요한 대신 3단계만으로도 찾을 수 있습니다.

시간복잡도: O(logn)

### 1단계: 중간 인덱스 찾기

첫 번째 단계는 컬렉션의 중간 인덱스를 찾는 것입니다.

<img width="500" alt="스크린샷 2023-06-01 오전 8 57 01" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/8965b10a-7132-450c-b52e-f0fdd574b744">

### 2단계: 중간 인덱스의 요소 확인하기

다음 단계는 중간 인덱스에 저장된 요소를 확인하는 것입니다.

만약 찾고자 하는 값과 일치한다면 해당 인덱스를 반환합니다.

그렇지 않다면 3단계로 진행합니다.

### 3단계: 이진 검색 재귀 호출하기

마지막 단계는 이진 검색을 재귀적으로 호출하는 것입니다.

그러나 이번에는 중간 인덱스를 기준으로 왼쪽 또는 오른쪽 요소만을 고려합니다.

이는 찾고자 하는 값에 따라서 결정됩니다. 찾고자 하는 값이 중간 값보다 작다면 왼쪽 부분 수열을 검색하고, 중간 값보다 크다면 오른쪽 부분 수열을 검색합니다.

각 단계마다 비교할 대상이 절반으로 줄어듭니다.

예를 들어, 값 31을 찾는다고 가정할 때 (이 값은 중간 요소 22보다 큽니다), 오른쪽 부분 수열에서 이진 검색을 적용합니다.

<img width="500" alt="스크린샷 2023-06-01 오전 9 18 12" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/b3261494-e986-43d6-b263-a87405f08c37">

이러한 세 단계를 반복하여 컬렉션을 왼쪽과 오른쪽 절반으로 분할할 수 없거나 컬렉션 내에서 값을 찾을 때까지 계속합니다.

이진 검색은 이렇게 하면 O(logn)의 시간 복잡도를 달성합니다.

# 구현

```swift
public extension RandomAccessCollection where Element: Comparable {
	// 이진 검색은 재귀적으로 작동하기 때문에 검색할 범위(range)를 전달해야 합니다.
	// 범위를 지정하지 않는 경우 전체 컬렉션을 검색합니다.
	func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
		// 먼저, range가 nil인지 확인합니다. 그렇다면, 전체 컬렉션을 포함하는 범위를 생성합니다.
		let range = range ?? startIndex..<endIndex
		// 범위가 유효하지 않는 경우, nil을 반환합니다.
		guard range.lowerBound < range.upperBound else {
			return nil
		}
		// 이제 범위에 요소가 있는 것을 확신할 수 있으므로, 범위에서 중간 인덱스를 찾습니다.
		let size = distance(from: range.lowerBound, to: range.upperBound)
		let middle = index(range.lowerBound, offsetBy: size / 2)
		// 그런 다음, 이 인덱스에 있는 값과 검색 중인 값을 비교합니다.
		// 값이 일치하는 경우, 중간 인덱스를 반환합니다.
		if self[middle] == value {
			return middle
		// 일치하지 않는 경우, 컬렉션의 왼쪽 또는 오른쪽 절반을 재귀적으로 검색합니다.
		} else if self[middle] > value {
			return binarySearch(for: value, in: range.lowerBound..<middle)
		} else {
			return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
		}
	}
}

let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]
let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)
print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")

index(of:): Optional(7)
binarySearch(for:): Optional(7)
```

정렬된 배열이 주어진다면 Binary Search 알고리즘을 우선적으로 고려해보세요.

또한, O(n^2)의 시간 복잡도로 검색해야 할 것 같은 문제가 주어진 경우,

미리 정렬을 수행하여 이진 검색을 사용하여 정렬 비용인 O(n log n)의 시간 복잡도로 줄일 수 있는지 고려해보세요.

# Key points

- 이진 검색은 정렬된 자료구조에서만 유효한 알고리즘입니다.
- 때로는 이진 검색 기능을 활용하기 위해 컬렉션을 정렬하는 것이 유리할 수 있습니다.
- sequences의 firstIndex(of:) 메서드는 선형 검색을 사용하며 O(n)의 시간 복잡도를 가집니다.
이진 검색은 O(log n)의 시간 복잡도를 가지므로, 반복적인 조회 작업을 수행하는 경우 대규모 데이터 세트에서 훨씬 더 효율적으로 작동합니다.