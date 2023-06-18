# Chap14. Radix Sort

 당신은 완전히 다른 정렬 모델을 보게 될 것입니다. 지금까지, 당신은 정렬 순서를 결정하기 위해 비교에 의존해 왔습니다.

기수 정렬은 선형 시간으로 정수를 정렬하기 위한 비교 알고리즘이다. 다른 문제에 초점을 맞춘 기수 정렬의 여러 구현이 있다.

일을 단순하게 유지하기 위해 기수 정렬의 최하위 숫자(LSD) 변형을 조사하면서 기본 10 정수를 정렬하는 데 초점을 맞출 것입니다.

## Example

기수 정렬이 어떻게 작동하는지 보여주기 위해, 다음 배열을 정렬할 것입니다:

var array = [88, 410, 1772, 20]

기수 정렬은 다음과 같이 정수의 위치 표기에 의존합니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/67b53149-b08f-4269-9f90-64766a159a48)

먼저, 배열은 가장 작은 자릿수인 일의 자릿수에 기반하여 버킷으로 나눠집니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d78e8641-d1bc-4406-b7b9-f09ed1a531b9)


이러한 버킷들은 순서대로 비워지며, 다음과 같이 부분적으로 정렬된 배열이 생성됩니다:

array = [410, 20, 1772, 88]

다음으로, 십의 자릿수에 대해 이 절차를 반복합니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/164b9480-1a81-4f0f-bf7e-fdaa359b8c3a)

요소의 상대적인 순서는 이번에는 바뀌지 않았지만, 당신은 여전히 검사해야 할 숫자가 더 많습니다.

고려해야 할 다음 숫자는 백의 자리 숫자입니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/f81f6e6d-4732-48a0-bf58-90f43a36c983)

백의 자리(또는 값이 없는 다른 위치)가 없는 값의 경우, 숫자는 0으로 가정됩니다.

이 버킷을 기반으로 배열을 재조립하면 다음을 얻을 수 있습니다:

array = [20, 88, 410, 1772]

마지막으로, 천의 자리 숫자를 고려해야 합니다:

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/17f0ff04-4d96-4828-aa54-f8529fb00269)

이 버킷에서 배열을 재조립하면 최종 정렬된 배열로 이어집니다:

배열 = [20, 88, 410, 1772]

여러 숫자가 같은 버킷에 들어가면, 그들의 상대적인 순서는 변하지 않는다. 예를 들어, 수백 위치의 제로 버킷에서, 20은 88보다 먼저 온다. 이것은 이전 단계가 80보다 낮은 버킷에 20을 넣었기 때문에, 20은 배열에서 88 이전에 끝났기 때문이다.

## 구현

```swift
//RadixSort.swift.
extension Array where Element == Int {

  public mutating func radixSort() {

  }
}
```

여기서, 당신은 확장을 통해 정수 배열에 radixSort 메소드를 추가했습니다. 다음을 사용하여 radixSort 방법을 구현하기 시작하세요:

```swift
public mutating func radixSort() {
  // 1
  let base = 10
  // 2
  var done = false
  var digits = 1
  while !done {

  }
}

```

1. 이 경우 기본 10 정수를 정렬하고 있습니다. 알고리즘에서 이 값을 여러 번 사용하기 때문에, 일정한 베이스에 저장합니다.
2. 진행 상황을 추적하기 위해 두 가지 변수를 선언합니다. Radix 정렬은 여러 패스에서 작동하므로 정렬이 완료되었는지 여부를 결정하는 플래그 역할을 합니다. 숫자 변수는 당신이 보고 있는 현재 숫자를 추적합니다.

다음으로, 각 요소를 버킷으로 정렬하는 논리를 작성할 것입니다(버킷 정렬이라고도 함).

**Bucket 정렬**

While 루프 안에 다음을 쓰세요:

```swift
public mutating func radixSort() {
  let base = 10
  var done = false
  var digits = 1
  while !done {
		// 1
		var buckets: [[Int]] = .init(repeating: [], count: base)
		// 2
		forEach {
		  number in
		  let remainingPart = number / digits
		  let digit = remainingPart % base
		  buckets[digit].append(number)
		}
		// 3
		digits *= base
		self = buckets.flatMap { $0 }
  }
}
```

1. 2차원 배열을 사용하여 버킷을 인스턴스화합니다. 당신은 베이스 10을 사용하고 있기 때문에, 10개의 양동이가 필요합니다.
2. 각 숫자를 올바른 양동이에 넣으세요.
3. 버킷의 내용을 사용하여 배열을 검사하고 업데이트하려는 다음 숫자로 숫자를 업데이트합니다. flatMap은 버킷을 배열로 비우는 것처럼 2차원 배열을 1차원 배열로 평평하게 합니다.

**When do you stop?**

당신의 while 루프는 현재 영원히 실행되므로, 어딘가에 종료 조건이 필요할 것입니다. 당신은 다음과 같이 그것을 할 것입니다:

1. While 루프의 시작 부분에서, done = true를 추가하세요.
2. forEach의 클로져 안에 다음을 추가하세요:

```swift
if remainingPart > 0 {
  done = false
}
```

forEach는 모든 정수를 반복하기 때문에, 정수 중 하나에 여전히 정렬되지 않은 숫자가 있는 한, 정렬을 계속해야 합니다.

기수 정렬은 가장 빠른 정렬 알고리즘 중 하나이다. 기수 정렬의 평균 시간 복잡성은 O(k × n)이며, 여기서 k는 가장 큰 숫자의 유효 자릿수이고, n은 배열의 정수 수이다.

기수 정렬은 k가 일정할 때 가장 잘 작동하며, 이는 배열의 모든 숫자가 유효 자릿수가 같을 때 발생합니다.

## 🗝️ Key points

- 이전 장에서 작업한 다른 검색과 달리, 기수 정렬은 비교되지 않으며 두 값을 비교하는 데 의존하지 않습니다. 기수 정렬은 값을 필터링하기 위한 체와 같은 버킷 정렬을 활용한다. 유용한 비유는 일부 자판기가 동전을 받아들이는 방법이다 - 동전은 크기에 따라 구별된다.
- Radix 정렬은 위치 표기법으로 값을 정렬하기 위한 가장 빠른 정렬 알고리즘 중 하나가 될 수 있다.
- 이 장에서는 가장 덜 중요한 숫자 기수 정렬을 다루었다. 기수 정렬을 구현하는 또 다른 방법은 가장 중요한 숫자 형태이다. 이 형태는 보다 낮은 자릿수보다는 가장 중요한 자릿수를 우선으로 정렬하며, 가장 잘 설명하는 예는 문자열 유형의 정렬 동작입니다.
