//
//  3. Reverse Linked List .swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/07.
//

func reverseList(_ head: ListNode?) -> ListNode? {
    guard let head = head else { return nil }
    guard var current = head.next else { return head }
    var previous = head
    previous.next = nil
    
    while let next = head.next {
        current.next = previous
        previous = current
        current = next
    }
    current.next = previous

    return current
}
