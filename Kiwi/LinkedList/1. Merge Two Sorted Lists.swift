//
//  1. Merge Two Sorted Lists.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/07.
//

func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    if list1 == nil {
        return list2
    } else if list2 == nil {
        return list1
    }
    
    var head: ListNode?
    var tail: ListNode?
    
    if list1!.val < list2!.val {
        head = list1
        tail = mergeTwoLists(list1!.next, list2)
    } else {
        head = list2
        tail = mergeTwoLists(list1, list2!.next)
    }
    head!.next = tail
    
    return head
}
