public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {

       //  그냥 node.next를 뛰어넘기기  
        var node = head
        var next = node?.next
        
        while node?.next != nil {
            
            if next?.val == val {
                node?.next = node?.next?.next
            } else {
                node = node?.next
            }
            next = node?.next
        }
        return head?.val == val ? head?.next : head
      // 첫 번째 값이 val과 같은 경우 
    }
}
 