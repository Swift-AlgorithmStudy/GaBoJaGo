
// https://leetcode.com/problems/sum-of-root-to-leaf-binary-numbers/

class Solution {
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }
        var sum = 0
        dfs("", &sum, root)
        return sum
    }

    func dfs(_ path: String, _ sum: inout Int, _ root: TreeNode) {
        var path = path + "\(root.val)"
        if root.left == nil && root.right == nil {
            sum += Int(path, radix: 2) ?? 0
        } else {
            if let left = root.left {
                dfs(path, &sum, left)
            }
            if let right = root.right {
                dfs(path, &sum, right)
            }
        }
    }
    // 비트연산으로도 풀어보기
}
