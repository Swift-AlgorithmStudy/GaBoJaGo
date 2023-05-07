//
//  4. Middle of the Linked List.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/07.
//

func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
    }

    return slow
}
