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
        guard nums.count > 0 else { return nil }
        let mid = nums.count / 2
        var newNode = TreeNode(nums[mid])
        newNode.left = sortedArrayToBST(Array(nums[0..<mid]))
        newNode.right = sortedArrayToBST(Array(nums[mid+1..<nums.count]))
        return newNode
    }
}

/*
균형 잡힌 이진 검색 트리 (Balanced Binary Search Tree)
: 모든 노드에서 왼쪽 서브트리와 오른쪽 서브트리의 높이 차이가 1 이하인 이진 검색 트리

1. 배열 nums의 중간 인덱스를 찾습니다. 이 인덱스의 요소를 기준으로 루트 노드를 생성
2. 중간 인덱스를 기준으로 왼쪽 부분 배열과 오른쪽 부분 배열을 생성
3. 왼쪽 부분 배열을 재귀적으로 처리하여 왼쪽 서브트리를 생성
4. 오른쪽 부분 배열을 재귀적으로 처리하여 오른쪽 서브트리를 생성
5. 생성된 왼쪽 서브트리와 오른쪽 서브트리를 루트 노드의 자식으로 설정

*/