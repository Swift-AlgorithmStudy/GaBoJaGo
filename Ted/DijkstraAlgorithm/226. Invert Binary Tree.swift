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

// 튜플 할당
// 여러 값을 한 번에 할당하는 방법으로 소괄호를 사용하여 값을 묶어 튜플을 생성하고, 변수나 상수에 할당할 수 있음

class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        
        guard let root = root else {
            return nil
        }
        
        //원래 노드의 오른쪽 값을 root.left에, 원래 노드의 왼쪽 값을 root.right에 대입해줌
        (root.left, root.right) = (invertTree(root.right), invertTree(root.left))
        
        return root
        
    }
}
