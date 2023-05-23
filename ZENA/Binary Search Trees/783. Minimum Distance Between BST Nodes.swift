// https://leetcode.com/problems/minimum-distance-between-bst-nodes/submissions/955600643/


class Solution {

    var values = [Int]()

    func minDiffInBST(_ root: TreeNode?) -> Int {
        addValue(root)

        var minDiff = Int.max
        // values = values.sorted()
        for index in 1..<values.count {
            minDiff = min(minDiff, (values[index] - values[index-1]))
        }
        return minDiff
    }

    func addValue(_ node: TreeNode?) {
        guard let node = node else { return }
        
        addValue(node.left)
        values.append(node.val)
        addValue(node.right)
    }
}
