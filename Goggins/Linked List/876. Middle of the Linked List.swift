//
//  876. Middle of the Linked List.swift
//  Swift Algorithm
//

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
