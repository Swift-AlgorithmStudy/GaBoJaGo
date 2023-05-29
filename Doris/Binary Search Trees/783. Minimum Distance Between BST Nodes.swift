class Solution {
    func minDiffInBST(_ root: TreeNode?) -> Int {
        var prev: TreeNode?
        var res = Int.max

        func dfs(_ node: TreeNode?) {
            if node == nil { return }

            dfs(node?.left)
            if prev != nil {
                res = min(res, node!.val - prev!.val)
            }
            prev = node
            dfs(node?.right)
        }
        dfs(root)
        return res
    }
}