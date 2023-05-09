public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
    }

class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        // listnode를 두개 합쳐놓고 오름차순으로 정렬
        var l1 = list1
        var l2 = list2
        let result = ListNode(0)
        var node = result
// l1.val < l2.val -> node.next = l1
// reverse -> node.next = l2

        while l1 != nil && l2 != nil {
            if l1!.val < l2!.val {
                node.next = l1
                l1 = l1?.next
            } else {
                node.next = l2
                l2 = l2?.next
            }

            node = node.next!
        } 

        if l1 != nil {
            node.next = l1
        } else {
            node.next = l2
        }

        return result.next
    }
}