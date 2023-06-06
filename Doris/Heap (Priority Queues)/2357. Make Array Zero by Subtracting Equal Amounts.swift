class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        var res = 0
        var heap = nums.sorted { $0 > $1 }

        while heap[0] > 0 {
            if let val = heap.last, val > 0 {
                res += 1 
                heap = heap.map { $0 - val }
            } else {
                let val = heap.removeLast()
            }
        }
        return res
    }
}