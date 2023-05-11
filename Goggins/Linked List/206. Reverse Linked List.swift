//
//  206. Reverse Linked List.swift
//  Swift Algorithm
//

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
