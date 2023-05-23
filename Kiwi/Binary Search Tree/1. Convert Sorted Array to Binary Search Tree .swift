//
//  1. Convert Sorted Array to Binary Search Tree .swift
//  문제풀이
//
//  Created by 송기원 on 2023/05/23.
//

func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    guard nums.count > 0 else { return nil }
    let mid = nums.count / 2
    var newNode = TreeNode(nums[mid])
    newNode.left = sortedArrayToBST(Array(nums[0..<mid]))
    newNode.right = sortedArrayToBST(Array(nums[mid+1..<nums.count]))
    return newNode
}
