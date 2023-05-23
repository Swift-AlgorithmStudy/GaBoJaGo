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
    var numbers: [Int] = []
    func minDiffInBST(_ root: TreeNode?) -> Int {
        addNumbers(root)

        var result = 100000
        for i in 0..<numbers.count - 1 {
            result = min(result, numbers[i + 1] - numbers[i])
        }
        return result
    }
    
    func addNumbers(_ node: TreeNode?) {
        guard let cur = node else {return}
        addNumbers(cur.left)
        numbers.append(cur.val)
        addNumbers(cur.right)
    }
}