
// https://leetcode.com/problems/special-array-with-x-elements-greater-than-or-equal-x/
// 17ms, 이분탐색으로 풀지않음

class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        let sortedNums = nums.sorted()
        var result = -1
        for x in 0...sortedNums.max()! {
            let count = nums.filter({$0 >= x}).count
            if x == count {
                result = max(result, count)
            }
        }
        return result
    }
}
