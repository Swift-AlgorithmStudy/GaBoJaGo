//
//  2. Two Sum IV - Input is a BST .swift
//  문제풀이
//
//  Created by 송기원 on 2023/05/23.
//

func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
    var set = Set<Int>()
    return findSum(root, k, &set)
}

func findSum(_ node: TreeNode?, _ target: Int, _ set: inout Set<Int>) -> Bool {
    guard let node = node else {
        return false
    }
    
    let complement = target - node.val
    
    if set.contains(complement) {
        return true
    }
    
    set.insert(node.val)
    
    return findSum(node.left, target, &set) || findSum(node.right, target, &set)
}
