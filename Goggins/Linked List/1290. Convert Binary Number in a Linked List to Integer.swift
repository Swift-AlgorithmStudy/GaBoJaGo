//
//  1290. Convert Binary Number in a Linked List to Integer.swift
//  Swift Algorithm
//

class Solution {
    func getDecimalValue(_ head: ListNode?) -> Int {
        var answer = 0
        var cur = head
        while cur != nil {
            answer *= 2
            answer += cur!.val
            cur = cur!.next
        }
        return answer
    }
}
