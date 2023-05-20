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

/**
1. 노드에서 중간값을 구한다.
2. 중간값을 기준으로 TreeNode를 생성한다.
3. 중간값보다 작으면 left, 크면 right에 값을 넣는다.
*/
class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return convertToBST(nums, 0, nums.count - 1)
    }
    
    func convertToBST(_ nums: [Int], _ left: Int, _ right: Int) -> TreeNode? {
        //nums가 존재하지 않을 때
        if left > right {
            return nil
        }
        // nums의 중간 인덱스(중간값) 구하기
        let mid = (left + right) / 2
        let node = TreeNode(nums[mid])
        
        //왼쪽 자식의 left는 가장 끝이고, right는 중간의 바로 전 단계임
        node.left = convertToBST(nums, left, mid - 1)
        node.right = convertToBST(nums, mid + 1, right)
        
        return node
    }
}
