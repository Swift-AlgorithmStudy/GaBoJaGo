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
    func reverseList(_ head: ListNode?) -> ListNode? {
        
        //만약 head에 값이 없다면 nil 리턴
        guard let head = head else {
            return nil
        }
        
        var listToArray: [Int] = []
        var current:ListNode? = head
        
        //배열에 노드값을 추가한다.
        while current != nil {
            listToArray.append(current!.val)
            current = current!.next
        }
        
        //배열을 뒤집어서 값들을 정렬한다.
        listToArray.reverse()
    
        var result: ListNode? = nil
        var prev: ListNode? = nil
        
        for val in listToArray {
            
            //노드에 값을 추가한다.
            let node = ListNode(val)
            
            //링크드 리스트가 비어있을 때
            if prev == nil {
                result = node
            } else {
                //참조하고 있기 때문에 사실상 prev의 값이 바뀌어도 node의 값이 변경된다.
                prev!.next = node
            }
            prev = node
        }
        
        //prev와 함께 node를 참고하고 있기 때문에 result의 값 또한 node의 영향을 받는다.
        return result
    }
}
