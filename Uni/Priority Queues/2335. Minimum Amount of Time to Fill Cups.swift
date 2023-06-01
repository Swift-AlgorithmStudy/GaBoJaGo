class Solution {
    func fillCups(_ amount: [Int]) -> Int {
        return max(amount.max()!, (amount.reduce(0, +) + 1) / 2)
    }
}