
/* https://leetcode.com/problems/special-array-with-x-elements-greater-than-or-equal-x/
 * 17ms, 이분탐색으로 풀지않음
 * 0부터 nums의 최댓값까지 반복문돌리면서 해당 값과 그 개수가 일치하는 것 중 최대값을 반환
 */

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
