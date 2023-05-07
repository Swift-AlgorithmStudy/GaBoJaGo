/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init() { self.val = 0; self.next = nil; }
 *     public init(_ val: Int) { self.val = val; self.next = nil; }
 *     public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
 * }
 */
class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        
        var countIndex: Int = 0
        var headForCount = head
        
        //value 개수를 센다.
        while headForCount != nil {
            countIndex += 1
            headForCount = headForCount!.next
        }
        
        var index = countIndex / 2
        var result = head
        
        //index가 0일 때 중간으로 node의 중간 지점이기 때문에, 그 이후부터 반환을 해주면 된다,
        while index != 0 {
            result = result?.next
            index -= 1
        }
        
        return result
        
    }
}
