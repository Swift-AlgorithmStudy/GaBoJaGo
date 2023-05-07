import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? { //내 next가 참조할 놈은 나
         if head == nil || head!.next == nil {
            return head
        }
        var cur: ListNode? = head             
        var next: ListNode? = cur!.next
       
        var result: ListNode? = reverseList(next)
        next!.next = cur
        cur!.next = nil
        return result
    } 
}
