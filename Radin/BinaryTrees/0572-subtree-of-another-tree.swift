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
        guard let root = root, let subRoot = subRoot else { return false }

        if isSameTree(root, subRoot) { return true }

        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }

    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil { return true }
        if p == nil || q == nil { return false }
        if p!.val != q!.val { return false }

        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
}



/*
func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard var root = root, var subRoot = subRoot else {return false}

        while true {
            print(root.val, root.left?.val, root.right?.val)

            if subRoot.val != root.val && subRoot.right?.val != root.right?.val && subRoot.left?.val != root.left?.val {
                
                if isSubtree(root.left, subRoot) && isSubtree(root.right, subRoot) { 
                    return true
                } else {
                    break
                }
            }
            if root.left != nil {
                isSubtree(root.left, subRoot)
            }
            if root.right != nil {
                isSubtree(root.right, subRoot)
            }
            if root.left == nil && root.right == nil{
                break
            }
        }
        return false
    }
    
*/
