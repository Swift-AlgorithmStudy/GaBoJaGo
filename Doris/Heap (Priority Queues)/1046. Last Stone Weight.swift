class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {

        var heap = stones.sorted{ $0 > $1 }

        while heap.count > 1 {
            if let a = heap.popFirst(), let b = heap.popFirst(), a != b {
                heap.append(a-b)
                heap.sort(by: >)
            } else if heap.count == 0 {
                return 0
            }
        }

        return heap[0]    
    }
}

extension Array {
    mutating func popFirst() -> Element? {
        return self[self.indices].popFirst()
    }
}