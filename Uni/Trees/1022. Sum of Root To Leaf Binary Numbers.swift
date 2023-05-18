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
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        var result = 0

        func sumRootToLeafRecursive(node: TreeNode?, sum: Int) {
            guard let cur = node else {
                return
            }
            let curSum = sum * 2 + cur.val
            if cur.left == nil && cur.right == nil {
                result += curSum
                return
            }
            sumRootToLeafRecursive(node: cur.left, sum: curSum)
            sumRootToLeafRecursive(node: cur.right, sum: curSum)
        }
        sumRootToLeafRecursive(node: root, sum: 0)
        return result
    }
}
