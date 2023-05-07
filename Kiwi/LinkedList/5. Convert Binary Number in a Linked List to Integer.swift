//
//  5. Convert Binary Number in a Linked List to Integer.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/07.
//

func getDecimalValue(_ head: ListNode?) -> Int {
   var node = head
   var result = ""
   
   while node != nil {
       result.append(String(node?.val ?? 0))
       node = node?.next
   }
   
   return Int(result, radix: 2)!
}
