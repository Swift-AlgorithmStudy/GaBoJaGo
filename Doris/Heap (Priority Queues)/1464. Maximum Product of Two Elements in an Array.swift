class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        let heap = nums.sorted { $0 > $1 }
        return (heap[0] - 1) * (heap[1] - 1)
    }
}