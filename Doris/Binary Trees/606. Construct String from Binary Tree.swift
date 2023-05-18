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
        switch (root!.left, root!.right) {
        
        case (nil, nil):
            return "\(root!.val)"
        
        case (nil, let right):
            return "\(root!.val)()(\(tree2str(right)))"
        
        case (let left, nil):
            return "\(root!.val)(\(tree2str(left)))"
        
        default:
            return "\(root!.val)(\(tree2str(root!.left)))(\(tree2str(root!.right)))"
        }
    }
}