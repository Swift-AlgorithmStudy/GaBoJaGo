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
    var node = TreeNode(0)
    var prev: TreeNode?
    
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {return nil}
        prev = node
        insert(root)
        return node.right
    }
    
    func insert(_ root: TreeNode?) {
        guard let root = root else {return}
        
        insert(root.left)
        
        root.left = nil
        prev!.right = root
        prev = prev!.right
         
        insert(root.right)
    }
}