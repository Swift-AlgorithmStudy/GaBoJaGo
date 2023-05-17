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
    func tree2str(_ root: TreeNode?) -> String {
        var res = ""
        guard let node = root else {
            return ""
        }
        
        //nil이 아니라 우선 값 추가해줌
        res = "\(node.val)"
        
        //노드의 양쪽이 nil이 아닐 때
        if node.left != nil || node.right != nil {
            let left = tree2str(node.left)
            let right = tree2str(node.right)
            
            if left.isEmpty && right.isEmpty {
                return res
            }
            
            if left.isEmpty {
                res += "()"
            } else {
                res += "(\(left))"
            }
            
            //right는 비어있으면 처리해주지 않음
            if !right.isEmpty {
                res += "(\(right))"
            }
        }
        return res
    }
}
