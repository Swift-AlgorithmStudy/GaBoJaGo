/**
 * Definition for a binary tree node.
 * public class TreeNode {
 *     public var val: Int
 *     public var left: TreeNode?
 *     public var right: TreeNode?
 *     public init() { self.val = 0; self.left = nil; self.right = nil; }
 *     public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 *     public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
 *         self.val = val
 *         self.left = left
 *         self.right = right
 *     }
 * }
 */
class Solution {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard let root = root else {
            return false
        }
        if isSameTree(root, subRoot) {
            return true
        }
        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }

    func isSameTree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil || subRoot == nil {
            return root == nil && subRoot == nil
        }
        if root?.val == subRoot?.val {
            return isSameTree(root?.right, subRoot?.right) && isSameTree(root?.left, subRoot?.left)
        }
        return false
    }
}
