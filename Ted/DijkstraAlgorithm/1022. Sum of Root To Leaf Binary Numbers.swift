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
        guard let root = root else {
            return 0
        }
        
        return dfs(root, 0)
    }
    
    func dfs(_ node: TreeNode?, _ currentSum: Int) -> Int {
        guard let node = node else {
            return 0
        }
        
        //node가 있다는 것은 currentSum의 자리가 한 자리 << 되기 때문에 2를 곱한 뒤 node.val을 더함
        let newSum = currentSum * 2 + node.val
        
        //만약 node의 왼쪽, 오른쪽이 없다면
        if node.left == nil && node.right == nil {
            return newSum
        }
        
        let leftSum = dfs(node.left, newSum)
        let rightSum = dfs(node.right, newSum)
        
        return leftSum + rightSum
    }
}
