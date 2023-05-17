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
        guard let root = root else { return [] }
        /*
        너비 우선 탐색 -> 큐 사용 
        */
        var queue = [TreeNode]()
        queue.append(root)
        var result = [Double]()

        while !queue.isEmpty {
            let count = queue.count // 줄 당 개수
            var sum = 0
            for i in 0..<count{
                let val = queue.removeFirst()
                sum += val.val

                if let left = val.left {
                    queue.append(left)
                } 
                if let right = val.right {
                    queue.append(right)
                }
            }
            result.append(Double(sum) / Double(count)) 
        }
        return result
    }
}