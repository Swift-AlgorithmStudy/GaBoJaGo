
// https://leetcode.com/problems/subtree-of-another-tree/

extension TreeNode: Equatable {
     public static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
         return lhs.val == rhs.val && (lhs.left == rhs.left) && (lhs.right == rhs.right)
     }
 }
 
class Solution {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {

        guard let root = root else {
            if subRoot == nil { return true }
            return false
        }
        guard let subRoot = subRoot else { return false }

        var queue = [TreeNode]()
        queue.append(root)

        while !queue.isEmpty {
            let node = queue.removeLast()
            if node == subRoot {
                return true
            }
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
        return false
    }
}
