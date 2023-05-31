
이분 탐색은 탐색 알고리즘 중 O(log n)의 시간복잡도를 가지는 가장 효율적인 알고리즘 중 하나이다.  이는 balanced binary search tree에서 요소를 탐색하는 것과 비슷하다

이분 탐색의 사용 조건으로 두가지가 있다.

- 컬렉션은 일정 시간에 **인덱스를 조작**할 수 있어야 한다. 이는 컬렉션이 **RandomAccessCollection**이라는 것을 의미한다.
- 컬렉션은 **정렬**되어 있어야 한다.

## Example

이분 탐색의 이점은 선형 탐색과 비교했을 때 가장 잘 나타난다. 스위프트의 배열은 선형 탐색을 이용해 finstIndex(of:) 메소드를 구현하도록 되어있다. 이는 컬렉션 전체나 첫 요소를 찾을 때까지 탐색을 수행한다.

<img width="519" alt="스크린샷 2023-05-31 오전 9 31 54" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/00cd491b-11c7-4a2c-8ce3-d530c3efc997">

이분 탐색은 컬렉션이 이미 저장되어 있는 컬렉션이라는 이점을 사용해 다르게 처리한다.

아래는 31이라는 값을 찾기위해 이분탐색을 적용한 예이다.

<img width="520" alt="스크린샷 2023-05-31 오전 9 32 02" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/94442acc-313f-4cb2-b7c2-d09dba4483f0">

(31의 인덱스는 7)

8단계를 거치지 않고, 단 세 단계만을 거쳐 31을 찾아낸다. 이는 다음과 같이 동작한 것이다.

### Step 1: Find middle index

컬렉션의 중간 인덱스를 찾는 것이 첫 단계이다. 중간 인덱스 찾는 건 쉽다.

<img width="519" alt="스크린샷 2023-05-31 오전 9 32 08" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/56b7b8e3-a86b-432e-a6dd-a62e8671fc11">

### Step 2: Check the element at the middle index

다음 단계는 그 중간 인덱스의 값을 확인하는 것이다. 내가 찾는 값과 일치하면 해당 인덱스를 반환하고, 아니라면 다음 step 3로 넘어간다.

### Step 3: Recursively call binary search

마지막 스텝은 이분 탐색을 재귀적으로 호출하는 것이다. 하지만 이번에는 찾는 값에 따라 중간 인덱스의 왼쪽 또는 오른쪽만 고려하면 된다. 찾고 있는 값이 중간 인덱스의 값보다 작다면 왼쪽 시퀀스에 대해서만 찾으면 된다. 찾는 값이  중간 인덱스의 값보다 크면 오른쪽 시퀀스에 대해 탐색하면 된다.

<img width="518" alt="스크린샷 2023-05-31 오전 9 32 17" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/d2f9ff94-46d0-4838-a4f4-56eb66ca653c">

각각의 스텝은 수행해야하는 비교 연산을 반으로 효과적으로 줄여준다.

31이라는 값을 찾는 예시에서는 right subsequence에 대해 이분 탐색을 진행하면 된다.

이 세가지 스텝을 더이상 컬렉션을 left와 right로 나눌 수 없거나 값을 찾을 때까지 계속한다.

이분 탐색은 이러한 방식으로 O(log n)이라는 시간 복잡도를 가지는 것이다.

## Implementation

```swift
// 1
public extension RandomAccessCollection where Element: Comparable {
  // 2
  func binarySearch(for value: Element, in range: Range<Index>? = nil)
      -> Index? {
    // more to come
  }
}
```

1. 이분 탐색은 `RandomAccessCollection`을 따르는 타입에 대해서만 동작하기 때문에, `RandomAccessCollection`의 extension 내에 메소드를 추가한다. 이 extension은 비교 가능한 요소이도록 제약을 걸어준다.
2. 이분 탐색은 재귀적이므로 탐색할 범위를 넘겨주어야 한다. `range` 파라미터는 옵셔널이기 때문에, 범위를 특정하지 않아도 탐색을 시작할 수 있다. `range`가 nil인 경우, 컬렉션 전체를 탐색하게 된다.

다음으로 binarySearch 구현을 아래와 같이 계속한다.

```swift
// 1
let range = range ?? startIndex..<endIndex
// 2
guard range.lowerBound < range.upperBound else { return nil }
// 3
let size = distance(from: range.lowerBound, to: range.upperBound)
let middle = index(range.lowerBound, offsetBy: size / 2)
// 4
if self[middle] == value {
  return middle
// 5
} else if self[middle] > value {
  return binarySearch(for: value, in: range.lowerBound..<middle)
} else {
  return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
}
```

1. 먼저, `range`가 `nil`인지를 먼저 확인하고, `nil`이라면, 컬렉션 전체를 다룰 수 있는 범위를 설정한다.
2. range가 최소 하나 이상의 요소를 포함하는지 확인하고, 그렇지 않다면 탐색이 실패한 것이므로 `nil`을 반환한다.
3. range내에 요소가 있다는 것을 확인했다면, 해당 범위의 중간 인덱스를 찾는다.
4. 그런 다음 중간 인덱스의 값이 내가 찾으려는 값인지 비교한다. 내가 찾던 값과 일치한다면 중간 인덱스를 반환한다.
5. 내가 찾던 값과 일치하지 않는다면, 컬렉션의 왼쪽 또는 오른쪽 나머지 반에 대해 재귀적으로 탐색한다.

이분 탐색 구현 끝! 테스트해보자

```swift
let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]

let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)

print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")
```

## 🔑 Key points

- 이분 탐색은 **정렬된 컬렉션**에 한해 유효한 알고리즘이다.
- 때때로 요소를 찾기 위한 이분 탐색을 활용하기 위해 컬렉션을 정렬하는 것이 이득일 수 있다.
- 시퀀스에 대해 firstIndex(of:)는 O(n)의 시간복잡도를 가지는 선형탐색을 이용한다.
    
    이분 탐색은 O(log n)의 시간복잡도를 가지며, 엄청 큰 데이터셋에 대해 반복적인 탐색이 이뤄질 때 훨씬 나은 방법이다.
