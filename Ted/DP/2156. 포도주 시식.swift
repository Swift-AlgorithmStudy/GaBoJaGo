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
        guard let root = root else {
            return []
        }
        
        var averages: [Double] = []
        var queue: [TreeNode] = [root]
        
        while !queue.isEmpty {
            let size = queue.count
            var levelSum = 0.0
            
            //queue에 들어있는 만큼 순회
            for node in queue {
                //queue에서 값을 제거하고 val을 더함
                let node = queue.removeFirst()
                levelSum += Double(node.val)
                //만약 왼쪽, 오른쪽에 값이 있다면 queue에 다시 추가 -> 값이 없어질 때까지 queue에 추가됨
                if let left = node.left {
                    queue.append(left)
                }
                if let right = node.right {
                    queue.append(right)
                }
            }
            let levelAverage = levelSum / Double(size)
            averages.append(levelAverage)
        }
        return averages
    }
}
