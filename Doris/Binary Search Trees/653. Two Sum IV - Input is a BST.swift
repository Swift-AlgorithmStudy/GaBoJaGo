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
    
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
    
        var values = Set<Int>()
        
        func rec(_ node: TreeNode?) -> Bool {
            guard let node = node else { return false }
            
            if values.contains(k - node.val) { return true }    
            values.insert(node.val)
            
            return rec(node.left) || rec(node.right)
        }
        
        return rec(root)
    }
}