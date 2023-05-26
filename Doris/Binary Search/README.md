# Binary Search

이진 탐색은 `O(log n)`의 시간 복잡도를 가지는 효율적인 검색 알고리즘 중 하나 입니다. </br>
이는 균형 이진 검색 트리에서 요소를 검색하는 것과 유사한 성능을 가집니다. </br>

* 이진 탐색을 사용하려면 두 가지 조건이 필요 합니다. 

1. 컬렉션은 상수 시간 내에 인덱스 조작을 수행할 수 있어야 합니다.
> 컬렉션이 `RandomAccessCollection`이어야 합니다. </br>
> RandomAccessCollection은 컬렉션의 요소에 임의로 접근할 수 있고, 인덱스를 상수 시간 내에 조작할 수 있는 프로토콜입니다. </br>
> 이는 이진 검색에서 효율적인 인덱스 조작이 가능해야 한다는 것을 의미합니다. </br>

2. 컬렉션은 정렬되어 있어야 합니다.
> 이진 검색은 정렬된 데이터에서만 사용할 수 있는 알고리즘입니다. </br>
> 정렬되지 않은 컬렉션에서는 이진 검색을 적용할 수 없습니다. </br>

</br>

## 💡 Example

이진 탐색의 장점은 선형 검색과 비교하여 설명할 수 있습니다. </br>

Swift의 Array 유형은 선형 검색을 사용하여 첫 번째 Index(of: )매서드를 구현합니다. </br>
이 때 아래의 그림처럼 전체 컬렉션을 훑고 지나가거나 첫 번째 요소를 찾을 때까지 이동하게 됩니다. </br>

<img width="70%" height="70%"  alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/c85e328e-ae3f-475e-b72b-1a61a35b9db1">
</br>

하지만 이진 탐색에서는 컬렉션이 이미 정렬되어 있다는 사실을 가정해 다른 방식으로 처리합니다. </br>

<img width="70%" height="70%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/fbe89df7-2d8d-4f8f-99f9-3c7312341054">
</br>

앞선 선형 탐색에서는 31이라는 값을 찾기 위해 8단계가 필요했지만 이진 탐색을 이용하면 3단계 만으로 값을 찾을 수 있습니다. </br>
</br>

**👀 How ?** </br>
> 어떻게 가능할까요 ? ! </br>

### Step 1 : Find middle index
> 중간 인덱스 찾기 ! </br>

<img width="70%" height="70%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/0e002f9a-439b-4275-9041-937048256b78"> </br>


### Step 2 : Check the element at th middle index
> 중간 인덱스에 저장된 요소 확인 ! </br>

만약 이 값이 찾고자 하는 값과 일치한다면 해당 인덱스를 반환합니다. </br>
일치하지 않는다면 Step 3를 진행합니다. </br>

### Step 3 : Recursively call binary search
> 이진 탐색을 재귀적으로 호출 ! </br>

이번 단계에서는 중간 인덱스를 기준으로 왼쪽 또는 오른쪽 부분 시퀀스만을 고려합니다. </br>
만약 찾고 있는 값이 중간 값보다 작다면 `왼쪽 부분 시퀀스`를 검색하고, 중간 값보다 크다면 `오른쪽 부분 시퀀스`를 검색합니다. </br>

* 따라서 검색 범위가 반으로 줄어들며, 검색 속도가 향상됩니다. 

예를 들어 아래의 그림에서 찾고자 하는 값(31)이 중간 요소인 22보다 크므로 오른쪽 부분 시퀀스에 이진 탐색을 적용합니다. </br>

<img width="70%" height="70%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/4057ce91-6b27-42dc-9b46-a2c1b8ee1737">
</br>

이 과정은 반복적으로 수행되며, 원하는 값이나 검색 범위를 찾을 때까지 반복됩니다. </br>
</br>

## 💡 Implementation

```swift
// 이진 검색은 RandomAccessCollection을 준수하는 유형에 대해서만 작동합니다. 
public extension RandomAccessCollection where Element: Comparable {
  
  /* 이진 검색은 재귀적으로 동작하기 때문에 검색할 범위를 전달해야 합니다.
  range 매개변수는 옵셔널로 선언되어 있으므로 범위를 지정하지 않고 검색 가능합니다. 
  range가 nil일 경우, 전체 컬렉션을 검색합니다.
  */
  func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
    
    // range가 nil인지 확인 -> nil이면 전체 컬렉션을 포괄하는 범위 생성
    let range = range ?? startIndex..<endIndex
    
    // range에 적어도 하나의 요소가 있는지 확인 -> 그렇지 않다면 검색이 실패한 것이므로 nil 반환
    guard range.lowerBound < range.upperBound else {
        return nil
    }

    // 범위에 요소가 반드시 존재하므로 범위에서 중간 인덱스 찾기
    let size = distance(from: range.lowerBound, to: range.upperBound)
    let middle = index(range.lowerBound, offsetBy: size / 2)
    
    // 인덱스의 값과 찾고 있는 값을 비교하고, 값이 일치하면 중간 인덱스를 반환
    if self[middle] == value {
        return middle
    
    // 값이 일치하지 않는 경우, 컬렉션의 왼쪽 또는 오른쪽 절반을 재귀적으로 검색
    } else if self[middle] > value {
        return binarySearch(for: value, in: range.lowerBound..<middle)
    } else {
        return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
    }
  }
}
```

</br>
</br>

* `정렬된 배열이 주어진다 ...`와 같은 문제를 읽을 때, 이진 탐색 알고리즘을 사용할 수 있습니다.
* O(n^2)의 검색 비용이 예상되는 문제가 주어지는 경우, 사전에 정렬을 수행하여 이진 탐색을 사용해 검색 비용을 정렬의 O(n log n) 으로 줄일 수 있는지 고려해야 합니다. 

</br>
</br>

## 💡 Key Points 
> 중요 중요 중요 ! </br>

* 이진 검색은 `정렬된 컬렉션`에서만 유효한 알고리즘입니다.

* 요소를 찾는 작업에서 이진 검색을 활용하기 위해서는 컬렉션을 미리 정렬해야 합니다. 

* 시퀀스의 firstIndex(of:) 매서드는 선형 검색을 사용하며 `O(n)`의 시간 복잡도를 가집니다.

* 이진 검색은 O(log n)의 시간 복잡도를 가지며, 큰 데이터 세트에서 반복적인 조회 작업을 수행할 때 더 효율적입니다.