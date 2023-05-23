
// https://leetcode.com/problems/search-in-a-binary-search-tree/

class Solution {
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return root }
        var subTree = TreeNode()
        var findNode = false
        dfs(root, &subTree, &findNode)
        
        func dfs(_ root: TreeNode, _ subTree: inout TreeNode, _ findNode: inout Bool) {
            if root.val == val {
                subTree = root
                findNode = true
            }

            if let left = root.left {
                dfs(left, &subTree, &findNode)
            }
            if let right = root.right {
                dfs(right, &subTree, &findNode)
            }
        }

        return findNode ? subTree : nil
    }
}
