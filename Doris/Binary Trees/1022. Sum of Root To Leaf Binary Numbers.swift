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

 // 이거 진짜 모르겠어요 ㅜㅜㅜㅜㅜㅜ

class Solution {
    func sumRootToLeaf(_ root: TreeNode?) -> Int {

        guard let root = root else { return 0 } 
        var res: Int = 0

        func path(_ tmp: String, _ res: Int, _ root: TreeNode?) {
            guard let root = root else { return }
            var tmp: String = ""
            var res = res
            tmp += "\(root.val)"

            if root.left == nil && root.right == nil {
                res += Int(tmp, radix: 2) ?? 0
            } else {
                path("", res, root.left)
                path("", res, root.right)
            }
        }
        return res
    }
}


