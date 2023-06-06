
/* https://leetcode.com/problems/binary-search/
 * target이라는 값이 있다면 해당 인덱스, 없다면 -1을 반환
 * 265ms
 */

class Solution {
    func search(_ nums: [Int], _ target: Int) -> Int {
        return binarySearch(nums, 0..<nums.count, target)
    }

    func binarySearch(_ nums: [Int], _ range: Range<Int>, _ target: Int) -> Int {
        guard range.lowerBound < range.upperBound else { return -1 }
        let mid = (range.lowerBound + range.upperBound) / 2
        if nums[mid] == target {
            return mid
        } else if nums[mid] > target {
            return binarySearch(nums, 0..<mid, target)
        } else {
            return binarySearch(nums, mid+1..<range.upperBound, target)
        }
    }
}
