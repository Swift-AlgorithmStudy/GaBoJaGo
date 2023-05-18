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
        guard let root = root else { return false }
        guard let subRoot = subRoot else { return false }

        if isEqual(root, subRoot) {
            return true
        }

        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }

    func isEqual(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        if root == nil && subRoot == nil {
            return true
        }
        if root == nil || subRoot == nil {
            return false
        }
        if root!.val != subRoot!.val {
            return false
        }    
        return isEqual(root!.left, subRoot!.left) && isEqual(root!.right, subRoot!.right)
    }
}



// 오답

class Solution {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        guard let root = root else { return false }
        guard let subRoot = subRoot else { return false }
       
        var rootVal: TreeNode? = nil

        if root.left?.val == subRoot.val {
            rootVal = root.left
        } else if root.right?.val == subRoot.val {
            rootVal = root.right
        }

        // if rootVal?.val == subRoot.val,
        //     isSubtree(rootVal?.left, subRoot.left),
        //     isSubtree(rootVal?.right, subRoot.right) {
        //         return true
        // }

        if rootVal?.val == subRoot.val {
            isSubtree(rootVal?.left, subRoot.left) || isSubtree(rootVal?.right, subRoot.right)
        }    
    
        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }
}

/*

rootVal 변수는 subRoot와 값이 일치하는 root의 서브노드를 가리키도록 하는 것이 목적입니다. 
그러나 현재 코드에서는 rootVal 변수를 선언한 후, 첫 번째로 일치하는 노드를 할당하고 있습니다. 
그런 다음, 해당 rootVal 노드의 자식 노드들과 subRoot의 자식 노드들을 비교하는 재귀 호출을 수행합니다. 
하지만 이러한 구현은 root의 서브트리 구조를 유지하지 못하고, 단순히 값이 일치하는 노드들끼리만 비교하게 됩니다.
예를 들어, root가 [3,4,5,1,2]이고 subRoot가 [4,1,2]일 때, rootVal 변수에는 4가 할당됩니다. 
그러나 이후의 재귀 호출에서는 rootVal 노드의 자식 노드들과 subRoot의 자식 노드들을 비교하는데, 
이는 실제로는 rootVal 노드의 부모인 3을 제외한 나머지 노드들과 subRoot를 비교하게 됩니다. 
이로 인해 올바른 서브트리 비교가 이루어지지 않고, 잘못된 결과를 반환할 수 있습니다.

*/