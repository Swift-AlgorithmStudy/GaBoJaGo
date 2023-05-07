import Foundation

class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func getDecimalValue(_ head: ListNode?) -> Int {
        var currentNode = head
        
        var maxIndex: Float = 0.0
        var result: Int = 0
        
        while currentNode!.next != nil {
            maxIndex += 1
            currentNode = currentNode!.next
        }
        
        currentNode = head
        
        for i in 0...Int(maxIndex) {
            if currentNode!.val == 1 {
                result += Int(pow(2.0, maxIndex - Float(i)))
            }
            currentNode = currentNode!.next
        }
        return result
    }
}