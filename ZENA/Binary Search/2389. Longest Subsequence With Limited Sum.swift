

// https://leetcode.com/problems/longest-subsequence-with-limited-sum/
// 87ms

class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        var sortedNums = nums.sorted()
        for (index, _) in sortedNums.enumerated() {
            if index == 0 { continue }
            sortedNums[index] += sortedNums[index - 1]
        }
        var result = [Int]()
        for query in queries {
            result.append(binarySearch(sortedNums, 0..<sortedNums.count, query))
        }
        return result
        
    }

    func binarySearch(_ sortedNums: [Int], _ range: Range<Int>, _ query: Int) -> Int {
        guard range.lowerBound < range.upperBound else { return range.lowerBound }
        let mid = (range.lowerBound + range.upperBound) / 2
        
        if sortedNums[mid] <= query {
            return binarySearch(sortedNums, mid+1..<range.upperBound, query)
        } else {
            return binarySearch(sortedNums, range.lowerBound..<mid, query)
        }
    }
}
