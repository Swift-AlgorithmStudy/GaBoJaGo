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
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        invertTreeRecursive(root)
        return root
    }

    func invertTreeRecursive(_ node: TreeNode?) {
        guard let cur = node else {return}
        let tmp = cur.left
        cur.left = cur.right
        cur.right = tmp
        invertTreeRecursive(cur.left)
        invertTreeRecursive(cur.right)
    }
}
