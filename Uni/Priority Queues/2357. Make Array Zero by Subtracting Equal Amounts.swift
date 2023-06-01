class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        let nums = Set(nums)
        return nums.contains(0) ? nums.count - 1 : nums.count
    }
}