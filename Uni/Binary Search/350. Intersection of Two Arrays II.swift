class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var counts1 = Array(repeating: 0, count: 1002)
        for num1 in nums1 {
            counts1[num1] += 1
        }
        var counts2 = Array(repeating: 0, count: 1002)
        for num2 in nums2 {
            counts2[num2] += 1
        }
        var result = [Int]()
        var num = 0
        for (count1, count2) in zip(counts1, counts2) {
            let count = min(count1, count2)
            for _ in 0..<count {
                result.append(num)
            }
            num += 1
        }
        return result
    }
}