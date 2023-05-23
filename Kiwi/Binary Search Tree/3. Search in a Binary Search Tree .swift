//
//  3. Search in a Binary Search Tree .swift
//  문제풀이
//
//  Created by 송기원 on 2023/05/23.
//

func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let node = root else { return nil }
    if val > node.val {
        return searchBST(node.right, val)
    } else if val < node.val {
        return searchBST(node.left, val)
    } else {
        return node
    }
}
