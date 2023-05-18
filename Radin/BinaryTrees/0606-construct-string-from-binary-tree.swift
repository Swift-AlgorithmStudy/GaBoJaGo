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
    func tree2str(_ root: TreeNode?) -> String {
        guard let root = root else {return ""}
        var result : String = String(root.val)
        
        if root.left != nil  {
            result.append("(\(tree2str(root.left)))")
        }
        else if root.left == nil && root.right != nil {
            result.append("()")
        }
        if root.right != nil {
            result.append("(\(tree2str(root.right)))")
        }
        return result
    }
}