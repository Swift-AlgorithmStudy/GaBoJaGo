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
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        
        var values = [Int]()

        func rec(_ node: TreeNode?) -> Array<TreeNode> {
            guard let node = node else { return [] }

            values.insert(node.val, at: 0)
            if values.contains(val) { return [node] }

            return rec(node.left) + rec(node.right)
        }

        return rec(root).first
    }
}