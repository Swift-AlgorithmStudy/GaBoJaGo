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
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var l1 = list1
        var l2 = list2

        var head: ListNode = ListNode(0)    //새로운 linked list 생성
        var current = head

        while l1 != nil && l2 != nil {  //l1과 l2가 nil일 때까지 반복
            let l1Value = l1!.val   //! 붙이기
            let l2Value = l2!.val

            if l1Value < l2Value {
                current.next = l1!  //l1과 l2 중에 더 작은 것이 바로 다음으로 오게 하고,
                                    //큰 값은 내버려 둔다.
                l1 = l1?.next
            } else {
                current.next = l2!
                l2 = l2?.next
            }
            current = current.next!
        }

        //메모 !
        //nil 병합 연산자를 사용하여 두 리스트 중 다른 리스트가 먼저 끝나는 경우를 처리해주기 위함
        current.next = l1 ?? l2

        return head.next
    }
}
