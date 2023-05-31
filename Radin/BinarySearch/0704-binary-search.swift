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