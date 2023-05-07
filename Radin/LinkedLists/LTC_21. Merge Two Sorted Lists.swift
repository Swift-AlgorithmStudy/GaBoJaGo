import Foundation

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}


class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        if list1 == nil { return list2 }
        if list2 == nil { return list1 }

        var result: ListNode? = ListNode()
        var tmp = result
        
        var l1 = list1
        var l2 = list2
        
        while l1 != nil && l2 != nil {
            if l1!.val >= l2!.val { 
                tmp!.next = l2!
                l2 = l2!.next
                tmp = tmp!.next
            }
            else { 
                tmp!.next = l1!
                l1 = l1!.next
                tmp = tmp!.next
            }
            if l1 == nil {
                tmp!.next = l2
            } 
            else if l2 == nil{
                tmp!.next = l1
            }
        }
        return result!.next
    }
}