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
    var find: TreeNode? = nil
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        searchBSTRecursive(root, val)
        return find
    }
    
    func searchBSTRecursive(_ node: TreeNode?, _ val: Int) {
        guard let cur = node else {return}
        if val == cur.val {
            find = cur
        } else if val < cur.val {
            searchBSTRecursive(cur.left, val)
        } else {
            searchBSTRecursive(cur.right, val)
        }
    }
}