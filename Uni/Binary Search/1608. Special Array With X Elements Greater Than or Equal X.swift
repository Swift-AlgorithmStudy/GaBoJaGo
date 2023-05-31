class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        var count = Array(repeating: 0, count: 102)
        for num in nums {
            count[num > 100 ? 100 : num] += 1
        }
        for i in stride(from: 100, to: 0, by: -1) {
            count[i] += count[i + 1]
            if count[i] == i {
                return i
            }
        }
        return -1
    }
}