/**
1. 배열들을 정렬한다.
2. 두 배열의 크기를 비교한다.
3. 배열의 크기가 작은 것의 값들을 큰 배열에 비교한다.
4. 일치하는 값을 배열에서 제거해줌 (계속 append하는 것 방지)
*/

class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var first = nums1.sorted(), second = nums2.sorted()
        var res = [Int]()
        
        if first.count > second.count {
            for element in second {
                if let index = binarySearch(first, element) {
                    res.append(element)
                    first.remove(at: index)
                }
            }
        } else {
            for element in first {
                if let index = binarySearch(second, element) {
                    res.append(element)
                    second.remove(at: index)
                }
            }
        }
        return res
    }
    
    func binarySearch(_ nums: [Int], _ target: Int) -> Int? {
        var left = 0
        var right = nums.count - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            
            if nums[mid] == target {
                return mid
            } else if nums[mid] < target {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return nil
    }
}
