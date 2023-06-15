# Radix Sort

기수 정렬(Radix sort)은 정수를 정렬하기 위한 알고리즘 중 하나입니다. 기수 정렬은 비교에 의존하지 않고 정수의 자릿수를 활용하여 정렬을 수행하는 특징을 갖고 있습니다.

기수 정렬은 각 정수를 자릿수 단위로 쪼개어 정렬하는 방식을 취합니다. 일반적으로 십진법(10진법)을 기반으로 하여 수행되며, 가장 낮은 자릿수부터 시작하여 가장 높은 자릿수까지 반복적으로 정렬 작업을 수행합니다.

기수 정렬은 다음과 같은 단계로 수행됩니다:

1. 가장 낮은 자릿수부터 시작하여 각 정수를 해당 자릿수에 따라 그룹으로 분류합니다.
2. 분류된 그룹 내에서는 정렬 순서를 유지한 채로 정수들을 재배치합니다.
3. 가장 낮은 자릿수에 대한 정렬이 완료되면, 다음 자릿수로 이동하여 위의 과정을 반복합니다.
4. 가장 높은 자릿수까지 위의 과정을 반복하여 모든 자릿수에 대한 정렬을 완료합니다.

기수 정렬은 비교 연산을 하지 않고 자릿수별로 분류하고 재배치하는 과정을 반복하기 때문에 선형 시간(O(n))에 정렬을 수행할 수 있습니다. 그러나 정렬할 정수의 자릿수가 많거나 정수의 범위가 큰 경우에는 추가적인 공간과 시간이 필요할 수 있습니다.

## 예시

### 1의 자리
![](https://hackmd.io/_uploads/rktRblDv3.png)
- array = [410, 20, 1772, 88]

### 10의 자리
![](https://hackmd.io/_uploads/HkN1Mevwn.png)

### 100의 자리
![](https://hackmd.io/_uploads/S16kMxDPh.png)
- array = [20, 88, 410, 1772]

### 1000의 자리
![](https://hackmd.io/_uploads/H1VezxwD2.png)
- array = [20, 88, 410, 1772]

## 구현

```swift

extension Array where Element == Int {
  
  public mutating func radixSort() {
    let base = 10
    var done = false
    var digits = 1
    while !done {
      done = true
      var buckets: [[Int]] = .init(repeating: [], count: base)
      forEach {
        number in
        let remainingPart = number / digits
        let digit = remainingPart % base
        buckets[digit].append(number)
        if remainingPart > 0 {
          done = false
        }
      }
      digits *= base
      self = buckets.flatMap { $0 }
    }
  }
}

```
