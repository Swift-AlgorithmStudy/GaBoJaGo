class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if let root = root {
            var queue = [TreeNode]()
            queue.append(root)
            
            while !queue.isEmpty {
                var cur = queue.removeLast()
                var tmp = cur.left
                cur.left = cur.right
                cur.right = tmp
                
                if let left = cur.left {
                    queue.append(left)
                }
                if let right = cur.right {
                    queue.append(right)
                }
            }
        }
        return root
    }
}


