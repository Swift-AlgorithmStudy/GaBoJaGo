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
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return make(nums, 0, nums.count - 1)
    }
    
    func make(_ nums: [Int], _ first: Int, _ last: Int) -> TreeNode? {
        guard first <= last else { return nil }

        var mid = (first + last) / 2
        
        var node = TreeNode(nums[mid]) //배열의 중간 인덱스 값으로 루트노드 초기화
        
        //트리만들기
        node.left = make(nums, first, mid - 1)
        node.right = make(nums, mid + 1, last)
        return node
    }
}