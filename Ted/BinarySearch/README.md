# Binary Search

이진 탐색(Binary Search)은 탐색 알고리즘 중 가장 효율적인 알고리즘으로, O(log n)의 시간 복잡도를 가지고 있습니다. 이는 균형잡힌 BST에서 탐색을 하는 것과 견줄 수 있습니다.

이진 탐색을 사용하기 전에 두 가지 조건이 선행되어야 합니다.

- 컬렉션은 상수의 시간 안에 인덱스 조작을 수행할 수 있어야 합니다. 
이는 컬렉션이 RandomAccessCollection이어야 한다는 것을 의미합니다.
    - RandomAccess는 인덱스를 통해 컬렉션의 요소에 직접 액세스하는 기능을 말하는데, 
    이는 O(1)의 시간 복잡도로 원하는 위치에 있는 요소에 접근할 수 있도록 해줍니다.
    - 인덱스를 사용하여 컬렉션 내부에서 요소를 조회, 수정, 삭제하거나 새 요소를 삽입할 수 있는 경우가 예시입니다.
    - 이를 위해서 RandomAccessCollection 프로토콜을 준수해야 합니다.
- 컬렉션은 정렬되어 있어야 합니다.

## Example

이진 탐색의 이점은 선형 탐색과 비교하면서 잘 설명될 수 있습니다. 
스위프트의 배열은 firstIndex(of:)메소드를 통해 선형 탐색을 사용합니다. 

이는 첫 번쨰 요소를 찾을 때까지 모든 컬렉션 요소를 탐색합니다.

<img width="394" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/12cc1a47-bcfb-44fe-96d2-bec2ad7d8d75">

이진 탐색은 컬렉션이 이미 정렬되어 있다는 점에 기반하여 다르게 탐색할 수 있습니다.

<img width="398" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/401d90fd-8f24-4629-ac2a-3dcbb5c2ed82">

### Step 1: Find middle index

첫 번째 단계는 컬렉션의 중간 인덱스를 찾는 것입니다. 찾는 방법은 꽤 직관적입니다.

<img width="415" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/10b65566-499c-45ca-8680-5290b83cd23a">

### Step 2: Check the element at the middle index

중간 인덱스의 값을 확인한 뒤, 만약 찾고 있는 값과 일치한다면 해당 인덱스를 반환하고, 아니라면 Step 3을 진행합니다.

### Step 3: Recursive call binary search

마지막 단계는 이진 탐색을 재귀적으로 호출하는 것입니다. 하지만 찾고 있는 값을 기반으로 요소의 왼쪽이나 오른쪽 둘 중 하나에 대해서만 고려하면 됩니다. 
만약 찾는 값이 중간 인덱스보다 작으면 왼쪽만 탐색하면 되고, 크다면 오른쪽만 탐색하면 됩니다.

각각의 단계는 비교할 대상을 반으로 줄여줌으로써 효율적으로 탐색할 수 있도록 합니다.

더 이상 컬렉션이 왼쪽, 오른쪽으로 쪼개지지 않거나(하나만 남을 때까지), 값을 찾을 때까지 진행합니다.

이 방법은 O(log n)의 시간 복잡도를 가집니다.

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

1. 이진 탐색은 RandomACcessCollection을 준수하는 경우에만 가능하므로,  해당 메소드에 extension을 해줍니다. 
2. 이진 탐색은 재귀적이기 때문에, 탐색을 할 때 범위를 넘겨줘야 합니다. range 변수는 옵셔널이기 때문에 특정 범위를 지정하지 않고 시작할 수 있습니다. range가 nil인 경우엔 모든 컬렉션에 대해 탐색할 것입니다. 

```swift
// 1
let range = range ?? startIndex..<endIndex
// 2
guard range.lowerBound < range.upperBound else {
  return nil
}
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

1. range가 nil인지 확인합니다. 만약 nil이라면, 전체 컬렉션을 포함하는 range를 생성합니다.
2. 그리고, range가 적어도 하나의 요소를 포함하고 있는지 확인합니다. 만약 포함하지 않는다면 nil을 반환합니다.
3. 이제 range안에 요소가 있다는 것이 확인되었으므로, range의 중간 인덱스를 찾습니다.
4. 그리고 해당 값과 찾고 있는 값을 비교합니다. 만약 값이 일치하다면, 중간 인덱스(해당 인덱스)를 반환합니다.
5. 만약 그렇지 않다면, 재귀적으로 왼쪽이나 오른쪽 컬렉션을 탐색합니다.

 

```swift
let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]

let search31 = array.firstIndex(of: 31)
let binarySearch31 = array.binarySearch(for: 31)

print("firstIndex(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")

index(of:): Optional(7)
binarySearch(for:): Optional(7)
```

이진 탐색은 프로그래밍 면접 등에서도 자주 나오는 강력한 알고리즘입니다. 

만약 “Given a sroted array…(정렬된 배열이 주어진..)”의 문장이 있다면, 이진 탐색 알고리즘을 고려해보십시오. 
또한 탐색하는 데에 O(n^)의 시간이 걸릴 거 같을 때, 이진 탐색을 통해 O(n log n)으로 시간 복잡도를 줄이도록 사전에 정렬(up-front sorting)을 고려해 보십시오.

## Key points

- 이진 탐색은 **정렬된** 컬렉션에서만 타당한 알고리즘입니다.
- 가끔 요소를 찾을 때 컬렉션을 정렬한 뒤 이진 탐색을 사용하는 것이 더욱 이득일 수도 있습니다.
- firstIndex(of:)메소드는 O(n)의 시간 복잡도를 가지는 선형 탐색입니다.
이진 탐색은 O(log n)의 시간을 가지며, 많은 양의 데이터를 반복해서 탐색할 때 좋은 성능을 보입니다.
