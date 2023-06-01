// https://leetcode.com/problems/intersection-of-two-arrays-ii/
// 20ms

class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var sortedNums1 = nums1.sorted()
        var sortedNums2 = nums2.sorted()
        var result = [Int]()
        var (compareNums, targetNums) = sortedNums1.count < sortedNums2.count ? (sortedNums2, sortedNums1) : (sortedNums1, sortedNums2)
        
        func binarySearch(_ compareNums: [Int], _ target: Int, _ result: inout [Int]) -> Bool {
            guard compareNums.count > 0 else { return false }
            let mid = compareNums.count / 2
            if compareNums[mid] == target {
                result.append(target)
                return true
            } else if compareNums[mid] > target {
                var halfCompareNums = Array(compareNums[0..<mid])
                return binarySearch(halfCompareNums, target, &result)
            } else {
                var halfCompareNums = Array(compareNums[(mid+1)..<compareNums.count])
                return binarySearch(halfCompareNums, target, &result)
            }
        }

        targetNums.forEach { target in
            if binarySearch(compareNums, target, &result) {
                compareNums.remove(at: compareNums.firstIndex(of: target)!)
            }
        }
        return result
    }
}
