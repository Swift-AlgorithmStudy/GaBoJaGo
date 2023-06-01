# Binary Search

탐색할 자료를 둘로 나누어, 해당 데이터가 있을 곳을 탐색함 탐색할 자료가 ***정렬되어 있을 때*** 만 사용 가능함

중간값을 구하고 해당 데이터와 값의 크기를 비교해 작다면 왼쪽을 탐색하고 크다면 오른쪽을 탐색한다. O(log n) 시간복잡도를 가진다. 

## 구현

```swift

public extension RandomAccessCollection where Element: Comparable {
  
  func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
    let range = range ?? startIndex..<endIndex
    guard range.lowerBound < range.upperBound else {
      return nil
    }
    let size = distance(from: range.lowerBound, to: range.upperBound)
    let middle = index(range.lowerBound, offsetBy: size / 2)
    if self[middle] == value {
      return middle
    } else if self[middle] > value {
      return binarySearch(for: value, in: range.lowerBound..<middle)
    } else {
      return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
    }
  }
}

```

# 문제풀이

## 1. Intersection of Two Arrays II

### 풀이.

```swift
func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var nums1 = nums1.sorted()
        var nums2 = nums2.sorted()
        var result: [Int] = []
        
        if nums1.count > nums2.count {
            for number in nums2 {
                if let index = getIndexNumber(nums1, target: number, start: 0, end: nums1.count - 1) {
                    result.append(nums1[index])
                    nums1.remove(at: index)
                }
            }
        } else {
            for number in nums1 {
                if let index = getIndexNumber(nums2, target: number, start: 0, end: nums2.count - 1) {
                    result.append(nums2[index])
                    nums2.remove(at: index)
                }
            }
        }
        return result
    }

    func getIndexNumber(_ array: [Int], target: Int, start: Int, end: Int) -> Int? {
        var start = start
        var end = end
        
        while start <= end {
            var mid = (start + end) / 2
            
            if array[mid] == target {
                return mid
            } else if array[mid] > target {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        
        return nil
    }
```

### 설명.

두개의 배열을 오름차순으로 정렬을 한다음, 요소의 개수가 적은쪽에서 많은쪽으로 이진탐색을 진행한다. 그래서 중복되는 요소를 result 배열에 더한다음 반환한다.

### 주의할점.

시간복잡도 고려.

## 2. Binary Search

### 풀이.

```swift
func search(_ nums: [Int], _ target: Int) -> Int {
        var start = 0
        var end = nums.count - 1

        while start <= end {
            var mid = (start + end) / 2

            if nums[mid] == target {
                return mid
            } else if nums[mid] > target {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }

        return -1
    }
```

### 설명.

넘나 쉽다 개꿀

### 주의할점.

갸꿀

## 3. Kth Missing Positive Number

### 풀이.

```swift
   func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var numbers: [Int] = []
        var endIndex = arr.endIndex - 1
        
        for number in 1...arr[endIndex] {
            numbers.append(number)
        }
        
        if numbers != arr {
            for i in arr.reversed() {
                var index = i - 1
                numbers.remove(at: index)
            }
        
            if k - 1 < numbers.count {
                return numbers[k - 1]
            } else {
                return arr[endIndex] + (k - numbers.count)
            }
        } else {
            return arr[endIndex] + k
        }
    }
```

### 설명.

경우를 세가지로 나눴다. arr가 연속적인 요소를 가지고 있는경우(ex. [1,2,3,4]), arr의 최대 요소값 보다 k가 더 큰경우 그리고 이외의 경우.
첫번째 경우는 arr의 마지막 인덱스 값에 k를 더해주고, 두번째는 arr의 요소의 최대값까지의 연속된 수에서 arr의 요소들을 제외한 배열(numbers)의 카운트를 k에서 빼준것을 arr의 마지막요소에 더해준다. 두번쨰는 numbers의 k - 1 인덱스 값을 리턴한다.

### 주의할점.

시간 복잡도. 바이너리 서치

## 4. Special Array With X Elements Greater Than or Equal X

### 풀이.

```swift
func specialArray(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        let c = nums.count
        var max = 0
    
        for i in 0..<c {
            let x = c - i
            if x > max && x <= nums[i] {
                return x
            }
            max = nums[i]
        }
        return -1
    }
```

### 설명.

max는 여태까지 확인한 요소중 최대값을 나타낸다. x는 현재까지의 이후의 배열의 넓이를 나타낸다. x의 크기가 max의 크기보다크고 해당 인덱스의 요소값보다 작거나 같을경우 x를 리턴한다. 이외의 경우는 max를 다음 요소로 대체한다. 이 모든 경우에 해당하지 않는다면 -1을 리턴한다.

### 주의할점.

문제이해하기.

## 5. Longest Subsequence With Limited Sum 

### 풀이.

```swift
 func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let queryCount = queries.count
        var result = [Int]()
        var nums = nums
        let runningSum = nums.sorted().reduce(into: [Int]()) { $0.append(($0.last ?? 0) + $1)}
        for query in queries {
            result.append(binarySearch(runningSum, query))
        }
        return result
    }
    
    private func binarySearch(_ runningSum: [Int], _ query: Int) -> Int {
        var start = 0
        var end = runningSum.count - 1
        while start <= end {
            let mid = (start + end) / 2
            if runningSum[mid] <= query {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        return start
    }
```

### 설명.

이분탐색을 통해 target보다 큰 최대의 요소를 반환하는 함수를 만든다. 거기에 요소의 합의 값을 요소로 가지는 배열을 만들어서 query를 target으로 가지는 이분탐색을 통해 검색한다.

### 주의할점.

nums.sorted().reduce(into: [Int]()) { $0.append(($0.last ?? 0) + $1)} 이거 외우기.
