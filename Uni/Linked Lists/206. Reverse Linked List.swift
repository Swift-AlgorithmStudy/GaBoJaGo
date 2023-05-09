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
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil else {return nil}
        var answer = ListNode(head!.val)
        var cur = head
        cur = cur!.next
        while cur != nil {
            var dummy = answer
            answer = ListNode(cur!.val)
            answer.next = dummy
            cur = cur!.next
        }
        return answer
    }
}