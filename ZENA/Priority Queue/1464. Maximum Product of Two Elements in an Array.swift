/*
 https://leetcode.com/problems/maximum-product-of-two-elements-in-an-array/description/?envType=list&envId=ren7fpc7
 nums에서 가장 큰 숫자 max와 다음으로 큰 숫자 secondMax 값에 각각 1씩 뺀 두 값을 곱한 값을 리턴
 22ms
 */

class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        let max = nums.max()!
        var removeMaxNums = nums
        removeMaxNums.remove(at: nums.firstIndex(of: max)!)
        let secondMax = removeMaxNums.max()!
        return (max - 1) * (secondMax - 1)
    }
}
