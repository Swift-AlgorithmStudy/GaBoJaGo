
// https://leetcode.com/problems/construct-string-from-binary-tree/

class Solution {
    func tree2str(_ root: TreeNode?) -> String {
        guard let root = root else { return "" }
        var str = [String]()
        str.append("\(root.val)")

        if root.left == nil && root.right != nil {
            str.append("()")
        } else {
            if let left = root.left {
                dfs(&str, left)
            }
        }

        if let right = root.right {
            dfs(&str, right)
        }

        return str.joined()
    }

    func dfs(_ str: inout [String], _ root: TreeNode) {
        str.append("(\(root.val)")

        if root.left == nil && root.right != nil {
            str.append("()")
        } else {
            if let left = root.left {
                dfs(&str, left)
            }
        }

        if let right = root.right {
            dfs(&str, right)
        }
        str.append(")")
    }
}

