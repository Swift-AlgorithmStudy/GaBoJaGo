class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        var result = [Int]()
        var nums = nums.sorted()
        for i in 0 ..< nums.count - 1 {
            nums[i + 1] += nums[i]
        }
        for query in queries {
            var start = 0, end = nums.count - 1
            while start <= end {
                let mid = (start + end) / 2
                if query >= nums[mid] {
                    start = mid + 1
                } else {
                    end = mid - 1
                }
            }
            result.append(start)
        }
        return result
    }
}