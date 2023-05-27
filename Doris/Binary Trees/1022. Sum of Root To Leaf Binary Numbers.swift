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
        var res: Int = 0

        func path(_ node: TreeNode?, _ tmp: String) {
            guard let node = node else { return }
            let newTmp = tmp + "\(node.val)"

            guard node.left == nil && node.right == nil else {
                // 리프노드가 아닐경우에만 실행
                path(node.left, newTmp)
                path(node.right, newTmp)
                return
            }

            res += Int(newTmp, radix: 2) ?? 0
        }

        path(root, "")
        return res
    }
}


