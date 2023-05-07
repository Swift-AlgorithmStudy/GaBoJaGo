//
//  2. Remove Linked List Elements .swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/07.
//

func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    var previous: ListNode? = ListNode(0)
    var result = previous
    var current = head
    previous?.next = current
    
    while current != nil {
        if current?.val == val {
            previous?.next = current?.next
        } else {
            previous = current
        }
        
        current = current?.next
    }
    
    return result?.next
}
