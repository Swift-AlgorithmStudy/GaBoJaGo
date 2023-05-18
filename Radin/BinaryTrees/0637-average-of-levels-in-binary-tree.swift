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
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let root = root else {return []}
        
        var result: [Double] = []
        var queue = [root]
        var sum : Int
        
        while queue.count != 0 {
            var sum = 0
            let count = queue.count
            
            for i in 0..<count {
                let node = queue.removeFirst()
                sum += node.val
            
                if let left = node.left {
                    queue.append(left)
                }

                if let right = node.right {
                    queue.append(right)
                }
               
            }
            result.append(Double(sum)/Double(count))
        }
        return result
    }
}