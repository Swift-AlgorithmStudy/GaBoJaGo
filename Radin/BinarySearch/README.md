## Binary Search

이진 탐색은 O(log n)의 시간 복잡도를 가진 가장 효율적인 검색 알고리즘 중 하나이다. 
이것은 균형 잡힌 이진탐색트리 내에서 요소를 검색하는 것과 비슷하다.

이진 탐색을 사용하기 전에 충족해야 하는 두 가지 조건

- 컬렉션은 일정한 시간에 인덱스 조작을 수행할 수 있어야 한다.
*(컬렉션이 RandomAccessCollection이어야 한다는 것을 의미)*
- 컬렉션은 정렬되어야 한다.

<br></br>
## Example

이진 탐색의 이점은 선형 탐색과 비교하여 가장 잘 설명할 수 있습니다. 

- **선형 탐색**
    
    Swift의 Array 유형은 firstIndex(of:) 메서드를 구현하기 위해서 선형 탐색을 사용합니다. 
    이는 전체 컬렉션을 통과하거나 첫 번째 요소를 찾을 때까지 이동합니다.
  
  
![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/2fc7e1e0-1e70-43ea-847a-d32fbef76cba)


- **이진 탐색**
    
    이진 탐색은 컬렉션이 이미 정렬되어 있다는 사실을 이용하여 상황을 다르게 처리합니다.
    
    ### Step 1: 중간 인덱스 찾기
    
    첫 번째 단계는 컬렉션의 중간 인덱스를 찾는 것이다. 
    
    ### Step 2: 중간 인덱스 요소 확인하기
    
    다음 단계는 중간 인덱스에 저장된 요소를 확인하는 것이다. 
    그것이 찾고 있는 값과 일치한다면, 인덱스를 반환하세요.
    일치하지 않는다면, 3단계로 넘어가세요.
    
    ### Step 3: 재귀적으로 이진탐색 호출
    
    마지막 단계는 이진 탐색을 재귀적으로 호출하는 것이다. 
    찾고 있는 값에 따라 중간 인덱스의 왼쪽이나 오른쪽에 있는 요소만 고려할 것입니다. 
    찾고 있는 값이 중간 값보다 작으면, 왼쪽 하위 시퀀스를 검색합니다. 
    중간 값보다 크면, 오른쪽 하위 시퀀스를 검색합니다.
    > 각 단계는 그렇지 않으면 수행해야 할 비교의 절반을 효과적으로 제거합니다.
    
    ### Step 4: 반복
    
    더 이상 컬렉션을 **왼쪽과 오른쪽 절반으로 나눌 수 없거나** **컬렉션 내부의 값을 찾을 때**까지 이 세 단계를 반복합니다.
    
    > 이진 탐색은 이런 식으로 O(log n) 시간 복잡성을 달성한다.
    
<br></br>
## Implementation

```swift
//BinarySearch.swift
// 1
public extension RandomAccessCollection where Element: Comparable {
  // 2
  func binarySearch(for value: Element, in range: Range<Index>? = nil)
      -> Index? {
		// 3
		let range = range ?? startIndex..<endIndex
		// 4
		guard range.lowerBound < range.upperBound else {
		  return nil
		}
		// 5
		let size = distance(from: range.lowerBound, to: range.upperBound)
		let middle = index(range.lowerBound, offsetBy: size / 2)
		// 6
		if self[middle] == value {
		  return middle
		// 7
		} else if self[middle] > value {
		  return binarySearch(for: value, in: range.lowerBound..<middle)
		} else {
		  return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
		}
  }
}
```

1. 이진 탐색은 RandomAccessCollection을 준수하는 유형에서만 작동하기 때문에, RandomAccessCollection의 확장 프로그램에 메소드를 추가합니다. 이 확장은 요소를 비교할 수 있어야 하기 때문에 제한됩니다.
2. 이진 탐색은 재귀적이므로, 검색하려면 범위를 통과해야 합니다. 매개 변수 범위는 옵셔널이므로, 범위를 지정하지 않고도 검색을 시작할 수 있습니다. 범위가 nil인 경우, 전체 컬렉션이 검색될 것이다.
3. 먼저, 범위가 nil인지 확인하세요. 그렇다면 전체 컬렉션을 포함하는 범위를 만듭니다.
4. 그런 다음, 범위에 적어도 하나의 요소가 포함되어 있는지 확인하세요. 그렇지 않으면, 검색이 실패했고, nil을 반환합니다.
5. 이제 범위에 요소가 있다고 확신했으므로, 범위에서 중간 인덱스를 찾을 수 있습니다.
6. 그런 다음 이 인덱스의 값을 찾고 있는 값과 비교합니다. 값이 일치하면, 중간 인덱스를 반환합니다.
7. 그렇지 않다면, 컬렉션의 왼쪽이나 오른쪽 절반을 재귀적으로 검색합니다.

<aside>
💡 이진 검색은 배워야 할 강력한 알고리즘으로, 프로그래밍 면접에서 자주 나타납니다. 
"정렬된 배열이 주어졌을 때..."와 같은 내용을 읽을 때는 이진 검색 알고리즘을 사용하는 것을 고려해보세요. 또한, O(n²)으로 보이는 문제가 주어지면 사전에 정렬을 수행하여 이진 검색을 사용하여 정렬 비용인 O(n log n)으로 줄일 수 있는지 고려해보세요.

</aside>

<br></br>
## 🗝️ Key points

- 이진 탐색은 정렬된 컬렉션에서만 유효한 알고리즘이다.
- 요소를 찾을 때 **이진 검색 기능을 활용하기 위해 컬렉션을 정렬하는 것이 도움**이 될 수 있습니다.
- 시퀀스의 firstIndex(of:) 방법은 O(n) 시간 복잡도과 함께 선형 검색을 사용합니다. 
이진 검색은 O(log n) 시간 복잡도를 가지고 있으며, 
반복적인 조회를 하는 경우 대규모 데이터 세트에 대해 훨씬 더 잘 확장됩니다.

<br></br>
## **350. Intersection of Two Arrays II**

```swift
class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var n1 = nums1.sorted()
        var n2 = nums2.sorted()
        var result: [Int] = []
        //아래 조건을 없애는게 리트코드에서 런타임이 더 빨랐다 
        if nums1.count > nums2.count {
            for n in n2 {
                if let index = same(n1, 0..<n1.count, n) {
                    result.append(n1[index])
                    n1.remove(at: index)
                }
            }
        } 
        else {
            for n in n1 {
                if let index = same(n2, 0..<n2.count, n) {
                    result.append(n2[index])
                    n2.remove(at: index)
                }
            }
        }
        return result
    }
    
    func same(_ arr: [Int?], _ range: Range<Int>, _ val: Int) -> Int? {
        guard range.lowerBound < range.upperBound else {
            return nil
        } 
        let size = range.count
        let middle = range.lowerBound + (size / 2)
              
        if arr[middle] == val {
            return middle
        }
        else if arr[middle]! > val {
            return same(arr, range.lowerBound..<middle, val)
        }
        else {
            return same(arr, (middle+1)..<range.upperBound, val)
        }
    }
}
```

이진탐색으로 두 배열을 비교 > 같은 값을 가진 놈은 결과 배열에 넣고 비교하는 배열에서 삭제하는 방식

삭제 말고 다른 방법으로 해보고 싶은데요..

## **704. Binary Search**

```swift
class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
       return helper(nums, target, 0, nums.count-1)
    }
    func helper(_ nums: [Int], _ target: Int, _ start: Int, _ end: Int) -> Int {
        let mid : Int = (start + end)  / 2
        if end < start {
            return -1
        }
        if nums[mid] == target {
            return mid
        } else if nums[mid] > target {
            return helper(nums, target, start, mid-1)
        } else {
            return helper(nums, target, mid+1, end)
        }
    }
}
```

## **1539. Kth Missing Positive Number**

```swift
class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var missing: [Int] = []
        var num = 0 
        
        while missing.count <= k { 
            if !arr.contains(num) {
                missing.append(num)
            }
            num += 1
        }
        return missing[k]
    }
}
```

반복문으로 num을 1씩 증가시키면서 arr가 contain을 가지고 있지 않으면 missing 배열에 num 추가

```swift
//이런 방법도 있드라!
class Solution {
    func findKthPositive(_ nums: [Int], _ k: Int) -> Int {
        var start = 0, end = nums.count-1
        while start <= end {
            let mid = start + (end-start) / 2
            let missingNums = nums[mid] - (mid+1)
            if missingNums < k {
                start = mid+1
            } else {
                end = mid-1
            }
        }
        return start+k
    }
}
```

## **1608. Special Array With X Elements Greater Than or Equal X**

```swift
class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        let num = nums.sorted()
        
        for i in 0..<num.last!+1 { // 0부터 num의 최댓값까지 반복
            if i == find(num, i, 0, num.count-1) { // 이진 탐색 함수의 반환값이 i와 일치하는지 비교 
                return i // i가 특별한 배열의 값이라면 i를 반환
            }
        }
        return -1 // 특별한 배열의 값이 없다면 -1 반환
    }
    
    func find(_ nums: [Int], _ k: Int, _ low: Int, _ high: Int) -> Int{
        let mid: Int =  low + (high - low) / 2
        guard low <= high else { return nums.count - low } // 범위를 벗어난 경우 현재 위치 반환
        
        if nums[mid] < k {
            return find(nums, k, mid+1, high)
        } else {
            return find(nums, k, low, mid-1)
        }
    }
}
```

## **2389. Longest Subsequence With Limited Sum**

```swift
class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let num = nums.sorted()
        var sum: [Int] = [0]
        var result: [Int] = []

				//num돌면서 누적sum을 모아두는 배열 만들기
        for n in num {
            sum.append(sum.last! + n)
        }
        //쿼리를 돌면서,
        for query in 0..<queries.count {
            let count = find(sum, queries[query], 0, sum.count-1) // 이진 탐색으로 누적 합 배열에서 적절한 위치 찾기
            result.append(count-1) //최대 크기의 부분 배열의 길이를 결과 배열에 추가
        }
        return result
    }
    
    func find(_ query: [Int], _ key: Int, _ low: Int, _ high: Int) -> Int {
        let mid: Int = low + (high - low)/2
        
        guard low <= high else { return low } // 범위를 벗어난 경우 현재 위치 반환
        
        if query[mid] <= key {
            return find(query, key, mid + 1, high)
        } else {
            return find(query, key, low, mid - 1)
        }
    }
}
```
