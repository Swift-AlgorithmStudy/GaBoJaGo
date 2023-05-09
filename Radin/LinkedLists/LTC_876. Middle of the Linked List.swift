import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
     func middleNode(_ head: ListNode?) -> ListNode? {
        var currentNode = head
        var currentIndex = 0
      
        if head == nil { return head }
        
        while  currentNode != nil {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        if currentIndex % 2 == 0{
            currentIndex += 1
        }
        
        currentNode = head
        
        for i in 0..<(currentIndex/2){
            currentNode = currentNode!.next
        }
        
        return currentNode
    }
}
