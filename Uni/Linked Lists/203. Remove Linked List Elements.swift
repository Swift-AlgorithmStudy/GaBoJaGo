/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let answer = ListNode()
        var cur = head, dummy = answer
        while cur != nil {
            if cur!.val != val {
                dummy.next = ListNode(cur!.val)
                dummy = dummy.next!
            }
            cur = cur!.next
        }
        return answer.next
    }
}