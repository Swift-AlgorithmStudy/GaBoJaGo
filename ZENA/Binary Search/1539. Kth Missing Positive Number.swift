
// https://leetcode.com/problems/kth-missing-positive-number
// 21ms

class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        return binarySearch(arr, 0..<arr.count, k)
    }

    func binarySearch(_ arr: [Int], _ range: Range<Int>, _ k: Int) -> Int {
        guard range.lowerBound < range.upperBound else { return range.lowerBound + k}
        let mid = (range.lowerBound + range.upperBound) / 2

        if arr[mid] - mid - 1 < k {
            return binarySearch(arr, mid+1..<range.upperBound, k)
        } else {
            return binarySearch(arr, range.lowerBound..<mid, k)
        }
    }
}
