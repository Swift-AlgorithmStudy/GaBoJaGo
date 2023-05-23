
// https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/

class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        if nums.isEmpty {
            return nil
        }
        var node = TreeNode()
        let mid = Int(nums.count/2)
        node.val = nums[mid]
        node.left = sortedArrayToBST(Array(nums[0..<mid]))
        node.right = sortedArrayToBST(Array(nums[mid+1..<nums.count]))
        return node
    }
}
