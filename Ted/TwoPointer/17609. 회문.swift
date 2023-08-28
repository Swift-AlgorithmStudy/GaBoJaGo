import Foundation

// check = 0: 회문 판단, check = 1: 유사회문 판단
func palindrome(_ s: String, _ check: Int) -> Int {
    var left = 0
    var right = s.count - 1
    
    let sArray = Array(s)
    
    while left < right {
        if sArray[left] != sArray[right] {
            if check == 0 {
                // 유사 회문인지 판단
                let len = right - left
                if palindrome(String(sArray[left + 1...left + len]), 1) == 0 || palindrome(String(sArray[left...left + len - 1]), 1) == 0 {
                    return 1 // 유사 회문
                } else {
                    return 2 // 유사 회문이 아님
                }
            } else {
                return 2
            }
        }
        
        left += 1
        right -= 1
    }
    
    return 0
}

if let T = Int(readLine()!) {
    for _ in 0..<T {
        if let s = readLine() {
            print(palindrome(s, 0))
        }
    }
}
