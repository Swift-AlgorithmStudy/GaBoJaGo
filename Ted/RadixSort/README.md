# Radix Sort

지금까지는 정렬을 할 때 비교를 통해 정렬을 진행했습니다. 
기수 정렬(radix sort)이란 정수를 선형 시간으로 정렬하기 위한 비교하지 않는(non-comparative) 알고리즘입니다.

문제에 따라 매우 다양한 기수 정렬이 존재합니다.

이번 장에서는 기수 정렬의 최수 유효 자리(least significant digit, LSD) 변형을 조사하면서 기본 10진수에 대해 집중할 예정입니다.

## Example

```swift
var array = [88, 410, 1772, 20]
```

기수 정렬은 정수의 위치 표기법에 의존합니다.

<img width="433" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/456d824b-c5bf-4c3c-90e5-929928495cbc">

배열을 최하위 자리의 숫자(1의 자리)를 기준으로 버킷에 나눕니다.

<img width="312" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/117312ed-4b2d-4853-8f8a-da045d96499b">

이 버킷들을 순서대로 비운다면, 다음과 같이 일부 정렬된 모습을 볼 수 있습니다.

```swift
array = [410, 20, 1772, 88]
```

다음으로는 10의 자리에서 진행합니다.

<img width="210" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/8e05a62e-d2f2-4c67-97c6-730b927b083f">

요소의 순서가 바뀌는 것이 없었지만, 탐색해야 할 다른 자릿수가 있습니다.

다음은 백의 자리를 탐색할 차례입니다.

<img width="230" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ab960df6-3956-44d0-9366-91a686e22467">

백의 자리가 없는 숫자들에 대해 백의 자리를 0으로 지정합니다.

해당 버킷을 기준으로 배열을 정렬하면 다음과 같습니다.

```swift
array = [20, 88, 410, 1772]
```

마지막으로 천의 자리가 남았습니다. 

<img width="257" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/bdf26999-2a10-435f-ab17-9f8ef7351d92">

해당 버킷을 기준으로 배열을 정렬하면 다음과 같습니다.

```swift
array = [20, 88, 410, 1772]
```

만약 여러 숫자가 같은 버킷에 있다면, 상대적인 정렬은 변하지 않습니다. 
예를 들어, 100의 자리에서의 0 버킷에서 20이 88보다 앞에 옵니다. 이는 이전 단계에서 20이 88보다 낮은 버킷에 있었기 때문입니다.

## Implementation

```swift
extension Array where Element == Int {

  public mutating func radixSort() {

  }
}

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

extension을 통해 radixSort 메소드를 추가해줍니다. 

1. 이 인스턴스에서는 10진법을 전제로 정렬하는 것입니다. 
이 값을 여러번 사용할 것이기 때문에, let으로 저장합니다.
2. 프로그레스를 추적하기 위해 두 변수를 선언합니다. 기수 정렬은 여러 단계에서 동작하기 때문에, 
done은 정렬이 완료되었는지 확인할 수 있도록 해줍니다. 

다음으론, 각각의 요소를 버킷으로 정렬하는 로직(Bucket sort)에 대해 설명할 것입니다.

### Bucket Sort

while문 안에 식을 넣어줍니다. 

```swift
extension Array where Element == Int {

  public mutating func radixSort() {

  }
}

public mutating func radixSort() {
  // 1
  let base = 10
  // 2
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

1. 인스턴스 버킷을 2차원으로 만듭니다.
2. 올바른 버킷에 값들을 넣습니다.
3. 검사할 다음 자릿수로 숫자를 업데이트하고 버킷의 내용을 사용하여 배열을 업데이트 합니다. 
만약 버킷을 비우지 않는다면, flatMap은 2차원 배열을 1차원으로 만들어줄 것입니다.

### When do you stop?

while문이 현재로써는 영원히 실행되기 때문에 어디엔가에 종료 조건이 필요할 것입니다. 

1. while의 시작 때, `done = true` 를 추가해줍니다.
2. forEach의 클로저 안에, 해당 식을 추가해줍니다.
    
    ```swift
    if remainingPart > 0 {
    	done = false
    }
    ```
    
    forEach가 모든 정수 안에서 반복되기 때문에, 만약 정렬되지 않은 자릿수가 있는 한 계속해서 정렬을 진행해야 합니다.
    
    ```swift
    example(of: "radix sort") {
      var array = [88, 410, 1772, 20]
      print("Original array: \(array)")
      array.radixSort()
      print("Radix sorted: \(array)")
    }
    
    ---Example of: radix sort---
    Original: [88, 410, 1772, 20]
    Radix sorted: [20, 88, 410, 1772]
    ```
    
    기수 정렬은 가장 빠른 정렬 알고리즘 중 하나입니다. 
    기수 정렬의 시간 복잡도는 O(k *n)으로, k는 숫자의 자릿수이고, n은 배열에 있는 정수의 개수입니다.
    
    기수 정렬은 k가 정수일 때 가장 잘 동작하는데, 이는 배열의 모든 숫자들이 같은 자릿수를 갖는 경우입니다. 이럴 때의 시간 복잡도는 O(n)이 됩니다. 
    
    기수 정렬의 공간 복잡도는 O(n)으로, 각각의 버킷을 담을 공간이 필요하기 때문입니다.
    
    ## Key points
    
    - 이전 장에서 보던 정렬과는 달리 기수 정렬은 두 값을 비교하지 않습니다. 
    기수 정렬은 버킷 정렬을 사용하는데, 이는 값을 필터링하는 체와 같습니다. 
    마치 세탁기가 동전을 크기에 따라 구분하는 것을 생각해보면 도움이 될 것입니다.
    - 기수 정렬은 위치 표기법으로 값을 정렬하는 가장 빠른 정렬 알고리즘 중 하나입니다.
    - 이번 장에서는 최하위 자릿수에 대한 기수 정렬(least significant digit)에 대해 다뤘습니다. 
    기수 정렬을 실행하는 다른 방법은 최상위 자릿수에 대한 기수 정렬(most significant digit)형식입니다.
    이는 작은 숫자보다 큰 숫자를 우선시하여 정렬하여 문자열 유형의 정렬 동작을 가장 잘 보여줍니다.
