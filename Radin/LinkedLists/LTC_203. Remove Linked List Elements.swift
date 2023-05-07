import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        if head == nil {
            return nil
        }
        var currentNode = head
        
        while currentNode!.next != nil {
            if currentNode!.next?.val == val {
                currentNode!.next =  currentNode!.next!.next
            }
            else {
                currentNode = currentNode!.next
            }
        } 
        return head!.val == val ? head!.next : head!
    }
}
//return값을 head로 하는 걸 몰랐다
//재귀로 다시 풀어보자