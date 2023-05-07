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
    func middleNode(_ head: ListNode?) -> ListNode? {
        guard head != nil else {return nil}
        var cur = head, count = 0
        while cur != nil {
            count += 1
            cur = cur!.next
        }
        let middle = Int(count / 2)
        cur = head
        var index = 0
        while cur != nil {
            if index >= middle {
                break
            }
            cur = cur!.next
            index += 1
        }
        return cur
    }
}