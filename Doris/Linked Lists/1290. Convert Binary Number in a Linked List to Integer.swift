class Solution {
    func getDecimalValue(_ head: ListNode?) -> Int {
        
        var node = head
        var result = ""

        while node != nil {
            result += "\(node!.val)"
            node = node?.next
        }
        if let decimal = Int(result, radix: 2) {
            return decimal
        }
        return 0
    }
}

/*
> 풀이과정 
❗️ radix : 진수변환 파라미터
ex) let number = Int("1010", radix: 2)
위의 코드는 "1010"이 2진수임을 알려주고 이를 10진수로 변환한 값을 number에 저장하는 것
❗️ ㅑㅜ
*/