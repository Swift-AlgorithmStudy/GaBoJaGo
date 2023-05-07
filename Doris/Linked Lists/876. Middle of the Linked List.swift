public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init() { self.val = 0; self.next = nil; }
    public init(_ val: Int) { self.val = val; self.next = nil; }
    public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
}

class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
    }
}


/*
> 몰랐던 것
❗️ 두개의 포인터로 중간 노드 찾는 법 ❗️
*/


// count / 2 로 중간지점 찾은 뒤 날리기
class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        
        
        // count 해서 head가 총 얼마짜리 리스트인ㅇ지파악
        // count / 2 의 자리 수 return 
        var node = head
        var count = 0

        while node?.next != nil {
            count += 1
            node = node?.next
        }
        // node = 맨 마지막 가리키고 있음
        let mid = count / 2 
        node = head
        // 다시 head로 초기화

        if count % 2 == 0{
            for i in 0..<mid {
            node = node?.next
            }
        } else {
            for i in 0...mid {
            node = node?.next
        }
    }
    
        return node
    }
}

// ... : 끝 값 포함
// ..< : 끝 값 포함 X