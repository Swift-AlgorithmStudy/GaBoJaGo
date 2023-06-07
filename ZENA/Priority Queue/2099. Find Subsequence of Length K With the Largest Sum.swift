/*
 https://leetcode.com/problems/find-subsequence-of-length-k-with-the-largest-sum/description/?envType=list&envId=ren7fpc7
 28ms
 k개의 숫자를 모두 더했을 때 가장 큰 값이 나오는 배열의 subsequences들을 반환하는데, 순서는 Nums 내에 포함되어야 한다.
 */

class Solution {
    func maxSubsequence(_ nums: [Int], _ k: Int) -> [Int] {
        var maxSubsequence = Array(nums.sorted().reversed()[0..<k])
        return nums.filter {
            if maxSubsequence.contains($0) {
                maxSubsequence.remove(at: maxSubsequence.firstIndex(of: $0)!)
                return true
            } else { return false }
        }
    }
}
