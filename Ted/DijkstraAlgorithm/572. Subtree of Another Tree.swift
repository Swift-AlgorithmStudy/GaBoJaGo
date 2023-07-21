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
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        //root값이 없다면
        if root == nil {
            return false
        } else if isSame(root, subRoot) {   //만약 root와 subRoot가 같다면
            return true
        } else {    //root와 subRoot가 같지 않다면
            return isSubtree(root?.left, subRoot) || isSubtree(root?.right, subRoot)
        }   //만약 왼쪽 서브트리와 오른쪽 서브트리 중 하나라도 일치하면 true를 반환
    }
    
    private func isSame(_ nodeA: TreeNode?, _ nodeB: TreeNode?) -> Bool {
        //두 노드 중 하나라도 nil이라면
        if nodeA == nil || nodeB == nil {
            return nodeA == nil && nodeB == nil //-> 둘 다 nil이면 true, 아니면 false
        } else if nodeA?.val == nodeB?.val {    //만약 두 노드의 값이 같다면
            return isSame(nodeA?.left, nodeB?.left) && isSame(nodeA?.right, nodeB?.right)   //자식 노드의 값을 비교한다.
         } else {
            return false
        }
    }
}
