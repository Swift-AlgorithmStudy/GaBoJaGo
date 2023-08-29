/*
 https://www.acmicpc.net/problem/17609
 */

let T = Int(readLine()!)!
for _ in 0..<T {
    let input = Array(readLine()!)
    print(isPalindrome(input, from: 0, to: input.count - 1, recursive: true))
}

/*
 T: 문자열의 개수
 sentences: 회문을 판별할 문자열들
 */

enum Palindrome: Int {
    case palindrome = 0
    case similar = 1
    case plain = 2
}

func isPalindrome(_ sentence: Array<Character>, from: Int, to: Int, recursive: Bool) -> Int {
    var left = from, right = to
    var enableToDelete = recursive // 이미 하나 삭제했으면 false
    while left < right {
        if sentence[left] == sentence[right] {
            left += 1
            right -= 1
        } else {
            if enableToDelete {
                enableToDelete = false
                if isPalindrome(sentence, from: left, to: right - 1, recursive: enableToDelete) != 2 {
                    right -= 1
                } else {
                    left += 1
                }
            } else {
                return Palindrome.plain.rawValue
            }
        }
    }
    return enableToDelete ? Palindrome.palindrome.rawValue : Palindrome.similar.rawValue
}
