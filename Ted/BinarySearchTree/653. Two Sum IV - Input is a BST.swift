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
inout : 함수 내에서 해당 변수를 수정하고 원래의 값에 반영하기 위해 사용됨
1. node값을 넣을 수 있는 set을 하나 지정
2. 만약 k - node.val이 있다면 true를 반환
3. 만약 없다면 node.val을 추가해두어 나중에 계산할 때 사용할 수 있도록 함
4. node left, right에도 재귀적으로 호출시킴
*/

class Solution {
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        var set = Set<Int>()
        return findValue(root,k, &set)
    }
    
    private func findValue(_ node: TreeNode?, _ k: Int, _ set: inout Set<Int>) -> Bool {
        //base case
        guard let node = node else {
            return false
        }
        
        //만약 set에 k-해당 노드값이 존재한다면
        if set.contains(k - node.val) {
            return true
        }
        
        //set에 k-해당 노드값이 존재하지 않는다면 노드값을 추가해두어 나중에 계산할 때 사용되게끔 함
        set.insert(node.val)
        
        return findValue(node.left, k, &set) || findValue(node.right, k, &set)
    }
}
