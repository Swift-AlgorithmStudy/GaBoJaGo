
// https://leetcode.com/problems/two-sum-iv-input-is-a-bst/


class Solution {
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {

        func dfs(_ root: TreeNode, _ existTwoSum: inout Bool, _ values: inout [Int: Int]) {
            if values[k - root.val] != nil {
                existTwoSum = true
                return
            } else {
                values[root.val] = 1
            }

            if let left = root.left {
                dfs(left, &existTwoSum, &values)
            }
            if let right = root.right {
                dfs(right, &existTwoSum, &values)
            }
        }

        guard let root = root else { return false }
        var values: [Int: Int] = [:]
        var existTwoSum = false
        dfs(root, &existTwoSum, &values)

        return existTwoSum
    }
}
