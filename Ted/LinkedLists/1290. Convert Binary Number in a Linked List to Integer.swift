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
    func getDecimalValue(_ head: ListNode?) -> Int {
        
        var binaryArray: [Int] = []
        var countArray: ListNode? = head
        var decimal: Int = 0
        var power: Int = 0
        
        //배열에 값들 삽입
        while countArray != nil {
            binaryArray.append(countArray!.val)
            countArray = countArray!.next
        }
        
        //배열 거꾸로 설정
        binaryArray.reverse()
        
        //첫 번째부터 value * 2의 0승 .. 으로 값 더하기
        for i in binaryArray {
            decimal += i * Int(pow(2, Double(power)))
            power += 1
        }
        
        return decimal
    }
}
