class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var queue: [Character] = []
        var same: [Bool] = []
        for str in s {
            if let index = queue.firstIndex(of: str) {
                queue.append(str)
                same.append(true)
                same[index] = true
            }
            else {
                queue.append(str)
                same.append(false)
            }
        }
        return same.firstIndex(of: false) ?? -1
    }
}