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
        guard let root = root else { return 0 }
        return sumRootToLeafPrev(root, 0)
    }

    func sumRootToLeafPrev(_ node: TreeNode, _ prevSum: Int) -> Int {
        let sum = 2 * prevSum + node.val
         if node.left == nil && node.right == nil {
            return sum
        }
         var result = 0
        if let left = node.left {
            result += sumRootToLeafPrev(left, sum)
        }
        if let right = node.right {
            result += sumRootToLeafPrev(right, sum)
        }
       
        
        return result
    }
}