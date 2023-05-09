class Solution {
    func firstUniqChar(_ s: String) -> Int {
        let a = 97
        var count = [Int](repeating: 0, count: 26)

        for c in s.utf8 {
            count[Int(c) - a] += 1
        }
        for (index, c) in s.utf8.enumerated() {
            if count[Int(c) - a] == 1 {
                return index
            }
        }
        return -1
    }
}