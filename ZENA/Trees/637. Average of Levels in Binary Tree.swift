class Solution {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        var averages = [Double]()
        guard let root = root else { return averages }
        var queue = [TreeNode]()
        queue.append(root)

        while !queue.isEmpty {
            let sum = queue.reduce(0) { $0 + Double($1.val)}
            averages.append(sum / Double(queue.count))
            for node in queue {
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
                queue.removeFirst()
            }
        }
        return averages
    }
}

