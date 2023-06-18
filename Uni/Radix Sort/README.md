# Chapter 30: Radix Sort

이번 장에서는 완전히 다른 정렬 모델인 기수 정렬을 살펴보겠습니다.
지금까지는 정렬 순서를 결정하기 위해 비교를 사용해왔지만, 기수 정렬은 선형 시간에 정수를 정렬하는 비교 방식이 아닌 알고리즘입니다.
간단하게 유지하기 위해 이번 장에서는 10진수 정수를 정렬하면서 가장 덜 중요한 자릿수(LSD, Least Significant Digit) 기반의 기수 정렬에 초점을 맞출 것입니다.

# 예시

기수 정렬이 어떻게 동작하는지 보여주기 위해 다음 배열을 정렬해 보겠습니다:

```swift
var array = [88, 410, 1772, 20]
```

먼저, 배열은 일의 자리 숫자에 따라 각 버킷에 나눠집니다.

<img width="300" alt="스크린샷 2023-06-18 오후 5 30 16" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/19d47ad4-c365-4352-b4b6-251fd3523a44">

이러한 버킷은 순서대로 비워지며, 다음과 같이 부분적으로 정렬된 배열이 생성됩니다:

```swift
array = [410, 20, 1772, 88]
```

다음으로, 십의 자리 숫자에 대해서도 이 절차를 반복합니다:

<img width="300" alt="스크린샷 2023-06-18 오후 5 36 02" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/0891b050-848a-4bd2-93dc-7033d9643d65">

이번에는 원소들의 상대적인 순서가 변경되지 않았지만, 아직 조사할 자릿수가 더 남아 있습니다.
다음으로 고려할 자릿수는 백의 자리 숫자입니다:

<img width="300" alt="스크린샷 2023-06-18 오후 5 39 47" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/2c124e40-5ca5-4c50-aba1-2e8f0445c654">

두  자리 숫자의 경우 백의 자리 숫자값은 0으로 간주됩니다.

이 버킷을 기반으로 배열을 재조합하면 다음과 같습니다.

```swift
array = [20, 88, 410, 1772]
```

마지막으로, 천의 자리 숫자를 고려해야 합니다:

<img width="300" alt="스크린샷 2023-06-18 오후 5 41 14" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/9937a9f1-868d-45b5-b176-64578a8397dc">

이러한 버에킷키 배열을 다시 조립하면 최종적으로 정렬된 배열이 만들어집니다:

```swift
array = [20, 88, 410, 1772]
```

여러 숫자가 같은 버킷에 들어갈 때, 그들의 상대적인 순서는 변하지 않습니다.
예를 들어, 백 자리 숫자에서 0 버킷에는 20이 88보다 앞에 오게 됩니다.
이는 이전 단계에서 20이 80보다 낮은 버킷에 들어가기 때문에, 배열에서 20이 88보다 앞에 위치하게 되었기 때문입니다.

# 구현

```swift
extension Array where Element == Int {
	public mutating func radixSort() {
		// 이 경우 10진수 정수를 정렬하고 있습니다.
		// 알고리즘에서 이 값을 여러 번 사용하므로 상수 base에 저장합니다.
		let base = 10
		// 진행 상황을 추적하기 위해 두 개의 변수를 선언합니다.
		// 기수 정렬은 여러 번의 패스로 동작하므로 done은 정렬이 완료되었는지 여부를 나타내는 플래그로 사용됩니다.
		// digits 변수는 현재 조사 중인 자릿수를 추적합니다.
		var done = false
		var digits = 1
		while !done {
			// Bucket Sort
		}
	}
}
```

다음으로, 각 요소를 버킷에 정렬하는 로직 (Bucket sort로도 알려져 있음)을 작성하게 될 것입니다.

## Bucket Sort

```swift
extension Array where Element == Int {
	public mutating func radixSort() {
		let base = 10
		var done = false
		var digits = 1
		while !done {
			**// 두 차원 배열을 사용하여 버킷을 생성합니다.
			// 10진법을 사용하기 때문에 10개의 버킷이 필요합니다.
			var buckets: [[Int]] = .init(repeating: [], count: base)
			// 각 숫자를 올바른 버킷에 넣습니다.
			forEach { number in
				let remainingPart = number / digits
				let digit = remainingPart % base
				buckets[digit].append(number)
			}
			// digits를 다음으로 조사할 자릿수로 업데이트하고, flatMap을 사용하여 배열을 업데이트합니다.
			// flatMap은 버킷을 배열에 비워넣는 것과 같이 두 차원 배열을 일차원 배열로 펼쳐줍니다.
			digits *= base
			self = buckets.flatMap { $0 }**
		}
	}
}
```

## When do you stop?

현재 while 루프가 무한히 실행되고 있어서 종료 조건이 필요합니다. 다음과 같이 수정하겠습니다:

```swift
extension Array where Element == Int {
	public mutating func radixSort() {
		let base = 10
		var done = false
		var digits = 1
		while !done {
			**done = true**
			var buckets: [[Int]] = .init(repeating: [], count: base)
			forEach { number in
				let remainingPart = number / digits
				**if remainingPart > 0 {**
					**done = false**
				**}**
				let digit = remainingPart % base
				buckets[digit].append(number)
			}
			digits *= base
			self = buckets.flatMap { $0 }
		}
	}
}
```

비교를 사용하지 않는 첫 번째 정렬 알고리즘을 배워봤습니다!
Radix 정렬은 가장 빠른 정렬 알고리즘 중 하나입니다.
Radix 정렬의 평균 시간 복잡도는 O(k × n)입니다.
여기서 k는 가장 큰 숫자의 자릿수의 개수이고, n은 배열 내의 정수의 개수입니다.
Radix 정렬은 k가 상수일 때 가장 효율적으로 동작하는데, 이는 배열 내의 모든 숫자가 동일한 유의미한 자릿수를 가질 때 발생합니다.
이 경우, 시간 복잡도는 O(n)이 됩니다. 또한, Radix 정렬은 각 버킷을 저장하기 위한 공간이 필요하므로 O(n)의 공간 복잡도를 가집니다.

# Key points

- 다른 검색 알고리즘과 달리, radix 정렬은 두 값의 비교에 의존하지 않고 값을 필터링하는 역할을 하는 버킷 정렬을 활용합니다.
- Radix 정렬은 위치 표기법을 사용하여 값들을 정렬하는 데에 있어 가장 빠른 정렬 알고리즘 중 하나일 수 있습니다.
- 높은 자릿수를 우선시하여 정렬하는 방법도 있는데 String 타입의 정렬에 사용할 수 있습니다.