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
        return traverse(root, root, k)
    }
    func traverse(_ root: TreeNode?, _ node: TreeNode?, _ k: Int) -> Bool{
        guard let node = node else { return false }
        var key: Int = k - node.val
        if key != node.val && find(root, key) {
            return true
        }
        return traverse(root, node.left, k) || traverse(root, node.right, k)
    }
    
    func find(_ root:TreeNode?, _ key: Int) -> Bool{
        guard let root = root else {return false}
        
        if root.val == key { return true}
        else if root.val > key {
            return find(root.left, key)
        }
        else {
            return find(root.right, key)
        }
    }
}