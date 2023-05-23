//
//  5. Increasing Order Search Tree.swift
//  문제풀이
//
//  Created by 송기원 on 2023/05/23.
//

func increasingBST(_ root: TreeNode?) -> TreeNode? {
    var arr: [Int] = []
    func traverse(_ node: TreeNode?) {
        guard let node = node else { return }
        traverse(node.left)
        arr.append(node.val)
        traverse(node.right)
    }
    traverse(root)
    let head = TreeNode(arr[0])
    var tail = head
    for n in arr[1...] {
        tail.right = TreeNode(n)
        tail = tail.right!
    }
    return head
}
