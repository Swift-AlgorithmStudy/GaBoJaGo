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
    var numbers = [Int: Bool]()
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        guard let cur = root else {
            return false
        }
        if let complement = numbers[k - cur.val], complement {
            return true
        }
        numbers[cur.val] = true
        return findTarget(cur.left, k) || findTarget(cur.right, k)
    }
}