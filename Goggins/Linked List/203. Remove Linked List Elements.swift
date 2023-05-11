//
//  203. Remove Linked List Elements.swift
//  Swift Algorithm
//

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
