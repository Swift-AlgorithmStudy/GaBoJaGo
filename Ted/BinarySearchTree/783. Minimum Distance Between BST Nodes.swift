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
    var prev: TreeNode? //이전 노드를 저장하기 위한 변수
    var minDiff: Int    //최소 차이값을 저장하기 위한 변수
    
    init() {    //초기화
        prev = nil
        minDiff = Int.max
    }
    func minDiffInBST(_ root: TreeNode?) -> Int {
        inorderTraversal(root)
        
        return minDiff
    }
    
    func inorderTraversal(_ root: TreeNode?) {
        guard let node = root else {
            return
        }
        
        //현재 노드의 왼쪽 서브트리를 중위순회
        inorderTraversal(node.left)
        
        //prev에는 이전에 방문한 노드가 저장되어 있음
        //min을 통해 이전 값 중 최소값(minDiff)과 현재 노드의 값 - 이전 노드의 값의 차이를 비교한 뒤 최소값 저장
        if let prevNode = prev {
            minDiff = min(minDiff, node.val - prevNode.val)
        }
        
        //현재 노드를 이전 노드로 설정하여 다음 계산을 할 수 있도록 함
        prev = node
        
        //오른쪽 서브트리 중위 순회
        inorderTraversal(node.right)
    }
}   
