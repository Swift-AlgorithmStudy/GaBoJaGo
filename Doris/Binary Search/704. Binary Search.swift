// 재귀

class Solution {

    func search(_ nums: [Int], _ target: Int) -> Int {
        return recursive(nums, target: target, left: 0, right: nums.count - 1)
    }

    func recursive(_ nums: [Int], target: Int, left: Int, right: Int) -> Int {
        if left > right {
            return -1 
        }
    
        let mid = (left + right) / 2
    
        if nums[mid] == target {
            return mid
        } else if nums[mid] < target {
            return recursive(nums, target: target, left: mid + 1, right: right)
        } else {
            return recursive(nums, target: target, left: left, right: mid - 1)
        }
    }
}


// 반복문 사용 -> 시간 초과 오류 남

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        
        var left = 0
        var right = nums.count - 1

        while left <= right {
            let mid = (left + right) / 2
            if target == nums[mid] {
                return mid
            } else if nums[mid] < target {
                left = mid - 1
            } else {
                right = mid + 1
            }
        }
        return -1
    }
}