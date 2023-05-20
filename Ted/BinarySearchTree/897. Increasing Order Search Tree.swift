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

/**
1. node를 queue에 넣는다.
2. 중위순회를 통해 queue에 값을 추가하게 되면 오름차순으로 정렬된다.
3. queue에서 값을 가져오면서 TreeNode의 오른쪽에 계속 추가한다.
*/

class Solution {
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        var queue: [Int] = []
        inorderTraversal(root, &queue)
        
        let res = TreeNode(0)
        var cur: TreeNode? = res
        
        for val in queue {
            cur?.right = TreeNode(val)
            cur = cur?.right
        }
        return res.right
    }
    
    func inorderTraversal(_ root: TreeNode?, _ queue: inout[Int]) {
        guard let node = root else {
            return
        }
        inorderTraversal(node.left, &queue)
        queue.append(node.val)
        inorderTraversal(node.right, &queue)
    }
}
