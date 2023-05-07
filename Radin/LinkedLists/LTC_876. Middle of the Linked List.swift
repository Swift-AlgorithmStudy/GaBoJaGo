import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution1 {
     func middleNode(_ head: ListNode?) -> ListNode? {
        var headList = head
        
        var currentNode = head
        var currentIndex = 0
      
        guard let head = headList else {
            return headList
        }
        
        while currentNode != nil {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        if currentIndex % 2 == 0{
            currentIndex += 1
        }
        
        for i in 0..<(currentIndex/2){
            headList = headList!.next
        }
        
        return headList
    }
}
