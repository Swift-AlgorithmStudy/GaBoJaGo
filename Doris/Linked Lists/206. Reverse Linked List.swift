// Iterative Approach
class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        var prev = head, node = head?.next
        prev?.next = nil
        while node != nil {
            let next = node!.next
            node!.next = prev
            prev = node
            node = next
        }
        return prev
    }
}

/*
해석 >

* 연결 리스트는 기본적으로 현재 노드의 값과 다음 노드를 가리키는 포인터를 가지고 있다.

head = 연결리스트의 첫 번쨰 노드를 가리키는 포인터
prev = 현재 노드의 이전 노드를 가리키는 포인터
node = 현재 노드를 가리키는 포인터

prev?.next = nil을 써줌으로써 연결리스트에서 해당 노드를 제거하게 된다.

while의 조건은 node = nil 즉, 더 이상 가리킬 다음 노드가 존재하지 않을 때까지 반복하게 된다.
next = 현재 node의 다음 노드
node!.next = prev : 현재 노드의 next포인터를 이전 노드 (prev)를 가리키도록 한 다음

prev = node
node = next
한칸씩 옮겨 다음 노드로 이동

-> 
결과적으로 prev 포인터가 가장 마지막 노드를 가리키고 있으므로, 
prev를 반환하면 뒤집어진 연결리스트의 첫 번째 노드를 가리키는 포인터가 반환

*/

