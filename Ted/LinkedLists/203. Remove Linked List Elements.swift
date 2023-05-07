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
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        //만약 head에 값이 없다면 nil을 리턴
        guard let head = head else {
            return nil
        }
        
        
        var current: ListNode? = head
        
        
        //첫 번째 노드가 val일 경우
        while current != nil && current!.val == val {
            current = current!.next
        }
        
        // 메모 !
        //head 참조를 저장하기 위해 변수 하나 지정
        var prev: ListNode? = current
        
        while current != nil {
            
            //다음 노드가 존재하는데, 그 노드가 val일 때 val을 건너뛴다.
            while current!.next != nil && current!.next!.val == val {
                current!.next = current!.next!.next
            }
            
            //마지막 노드가 val인 경우에는 건너 뛰어도 val이 남아있음
            if current!.next?.val == val {
                current!.next = nil
            }
            current = current?.next
        }
        return prev
    }
}
