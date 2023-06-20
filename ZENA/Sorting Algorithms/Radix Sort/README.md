# Radix Sort

이 장에서, 완전히 다른 정렬 모델을 보게 될 것이다. 지금까지, 정렬 순서를 결정하기 위해 **비교**에 의존해 왔다.

Radix sort 기수 정렬은 선형 시간으로 정수를 정렬하기 위한 비교 알고리즘이다. 다른 문제에 초점을 맞춘 기수 정렬의 여러 구현이 있다.

과정을 단순하게 유지하기 위해, 이 장에서는 기수 정렬의 최하위 숫자(Least Significant Digit) 변수를 조사하면서 기본 10 정수를 정렬하는 데 초점을 맞출 것이다.

## Example

기수 정렬이 어떻게 작동하는지 보여주기 위해, 다음 배열을 정렬할 것이다:

```swift
var array = [88, 410, 1772, 20]
```

기수 정렬은 다음과 같이 정수의 위치 표기에 의존한다:

<img width="453" alt="스크린샷 2023-06-20 오전 4 16 41" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/c71c5874-f65b-48a8-a498-a8b07738a6e5">

먼저, 배열은 최하위 숫자의 값에 따라 버킷으로 나뉜다: 첫번째 차리 숫자

<img width="696" alt="스크린샷 2023-06-20 오전 4 16 56" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/3603dd31-e4ae-44c3-9f39-27f9b7957f43">

그런 다음 이 버킷은 순서대로 비워져 다음과 같은 부분적으로 정렬된 배열이 생성된다:

```swift
array = [410, 20, 1772, 88]
```

다음으로, 십의 자리 숫자에 대해 같은 과정을 반복한다.

<img width="698" alt="스크린샷 2023-06-20 오전 4 19 15" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/992e55a2-0216-45ed-80b6-2c9b113651a1">

요소의 상대적인 순서는 이번에는 바뀌지 않았지만, 여전히 검사해야 할 숫자가 더 많다.

고려해야 할 다음 숫자는 백의 자리 숫자이다:

<img width="700" alt="스크린샷 2023-06-20 오전 4 21 06" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/07be9e05-b4c1-46d9-b2f6-d9255ea05cad">

백의 자리 숫자(또는 값이 없는 다른 위치)가 없는 값의 경우, 숫자는 0으로 가정된다.

이 버킷을 기반으로 배열을 재조립하면 다음을 얻을 수 있다:

```swift
array = [20, 88, 410, 1772]
```

마지막으로, 천의 자리 숫자를 고려해야 한다:

<img width="698" alt="스크린샷 2023-06-20 오전 4 22 27" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/dc5c220f-cb5b-4728-9a0c-d29c5dae5707">

이 버킷에서 배열을 재조립하면 최종 정렬된 배열로 이어진다:

```swift
array = [20, 88, 410, 1772]
```

여러 숫자가 같은 버킷에 들어가면, 그들의 상대적인 순서는 변하지 않는다. 예를 들어, 백의 자리 숫자의 제로 버킷에서, 20은 88보다 먼저 온다. 이것은 이전 단계가 80보다 낮은 버킷에 20을 넣었기 때문에, 20은 배열에서 88 이전에 끝났기 때문이다.

## Implementation

```swift
extension Array where Element == Int {

  public mutating func radixSort() {

  }
}
```

여기서, 당신은 확장을 통해 정수 배열에 radixSort 메소드를 추가했다. 다음을 사용하여 radixSort 방법을 구현하세요:

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

이 부분은 비교적 간단하다:

1. 이 경우 기본 10 정수를 정렬하고 있다. 알고리즘에서 이 값을 여러 번 사용하기 때문에, 일정한 베이스에 저장한다.
2. 진행 상황을 추적하기 위해 두 가지 변수를 선언한다. Radix 정렬은 여러 패스에서 작동하므로 정렬이 완료되었는지 여부를 결정하는 플래그 역할을 한다. 숫자 변수는 당신이 보고 있는 현재 숫자를 추적한다.

다음으로, 각 요소를 버킷으로 정렬하는 논리를 작성할 것이다(버킷 정렬이라고도 함).

### Bucket Sort

While 루프 안에 다음을 써라:

```swift
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
```

코드 분석:

1. 2차원 배열을 사용하여 버킷을 인스턴스화한다. 당신은 베이스 10을 사용하고 있기 때문에, 10개의 양동이가 필요하다.
2. 각 숫자를 올바른 양동이에 넣는다.
3. 버킷의 내용을 사용하여 배열을 검사하고 업데이트하려는 다음 숫자로 숫자를 업데이트한다. flatMap은 버킷을 배열로 비우는 것처럼 2차원 배열을 1차원 배열로 평평하게 한다.

### When do you stop?

당신의 while 루프는 현재 영원히 실행되므로, 어딘가에 종료 조건이 필요할 것이다. 다음과 같이 할 것이다:

1. While 루프의 시작 부분에서, `done = true`를 추가하세요.
2. forEach의 클로저 안에 다음을 추가하라:

```swift
if remainingPart > 0 {
    done = false
}
```

forEach는 모든 정수를 반복하기 때문에, 정수 중 하나에 여전히 정렬되지 않은 숫자가 있는 한, 정렬을 계속해야 한다.

그것으로, 당신은 당신의 첫 번째 비비교 정렬 알고리즘에 대해 배웠다! 코드 테스트는 다음과 같이 하라:

```swift
example(of: "radix sort") {
  var array = [88, 410, 1772, 20]
  print("Original array: \(array)")
  array.radixSort()
  print("Radix sorted: \(array)")
}

/*
---Example of: radix sort---
Original: [88, 410, 1772, 20]
Radix sorted: [20, 88, 410, 1772]
*/
```

기수 정렬은 가장 빠른 정렬 알고리즘 중 하나이다. 기수 정렬의 평균 시간 복잡성은 O(k × n)이며, 여기서 k는 가장 큰 숫자의 유효 자릿수이고, n은 배열의 정수 수이다.

기수 정렬은 k가 일정할 때 가장 잘 작동하며, 이는 배열의 모든 숫자가 유효 자릿수가 같을 때 발생합니다. 그 시간의 복잡성은 O(n)가 된다. Radix 정렬은 또한 각 버킷을 저장할 공간이 필요하기 때문에 O(n) 공간 복잡성을 초래한다.

## 🔑 Key points

- 이전 장에서 작업한 다른 검색과 달리, 기수 정렬은 비교되지 않으며 두 값을 비교하는 데 의존하지 않는다. 기수 정렬은 값을 필터링하기 위한 체와 같은 버킷 정렬을 활용한다. 유용한 비유는 일부 자판기가 동전을 받아들이는 방법이다 - 동전은 크기에 따라 구별된다.
- Radix 정렬은 위치 표기법으로 값을 정렬하기 위한 가장 빠른 정렬 알고리즘 중 하나가 될 수 있다.
- 이 장에서는 가장 덜 중요한 숫자 기수 정렬을 다루었다. 기수 정렬을 구현하는 또 다른 방법은 가장 중요한 숫자 형태이다. 이 양식은 작은 숫자보다 가장 중요한 숫자의 우선 순위를 지정하여 정렬되며 문자열 유형의 정렬 동작으로 가장 잘 설명된다.
