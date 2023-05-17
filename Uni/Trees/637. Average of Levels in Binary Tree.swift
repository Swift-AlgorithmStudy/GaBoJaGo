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
        var numbers = [[Int]](repeating: Array(repeating: 0, count: 0), count: 2000)

        func addNumbers(_ node: TreeNode?, _ depth: Int) {
            guard let cur = node else {return}
            numbers[depth].append(cur.val)
            addNumbers(cur.left, depth + 1)
            addNumbers(cur.right, depth + 1)
        }
        addNumbers(root, 0)

        var averages = [Double]()
        for number in numbers where number.count != 0 {
            let average = Double(number.reduce(0, +)) / Double(number.count)
            averages.append(average)
            print(number.reduce(0, +))
        }
        return averages
    }
}
