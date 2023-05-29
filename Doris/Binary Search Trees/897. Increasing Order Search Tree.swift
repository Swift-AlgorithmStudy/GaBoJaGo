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

    var nodes: [Int] = []
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        // 중위순회로 노드들 저장 (왼->현->오)
        // 순서대로 오른쪽에 저장
        inorderTraversal(root)
        var res = TreeNode()
        var tmp: TreeNode? = res
        for x in nodes {
            tmp?.right = TreeNode(x)
            tmp = tmp?.right
        }
        return res.right
        
    }

    func inorderTraversal(_ node: TreeNode?) {
            guard let node = node else {
                return
            }
            inorderTraversal(node.left)
            nodes.append(node.val)
            inorderTraversal(node.right)
            
        }
}


//

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
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        
        var nodes: [Int] = []

        func traverse(_ node: TreeNode?) {
            guard let node = node else {
                return
            }
            traverse(node.left)
            nodes.append(node.val)
            traverse(node.right)
        }
        traverse(root)
        
        var res = TreeNode()
        var tmp: TreeNode? = res
        for x in nodes {
            tmp?.right = TreeNode(x)
            tmp = tmp?.right
        }
        return res.right
        
    }
}

// 

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
    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        
        var nodes: [Int] = []

        func traverse(_ node: TreeNode?) {
            guard let node = node else {
                return
            }
            traverse(node.left)
            nodes.append(node.val)
            traverse(node.right)
        }
        traverse(root)
        
        var res = TreeNode(nodes[0])
        var tmp = res
        for x in nodes[1...] {
            tmp.right = TreeNode(x)
            tmp = tmp.right!
        }
        return res
        
    }
}