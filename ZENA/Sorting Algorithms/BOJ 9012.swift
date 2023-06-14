/*
 https://www.acmicpc.net/problem/9012
 
 메모리 69100KB, 시간 8ms, 코드길이 455B
 괄호가 유효한 것인지 판별하는 문제: 스택 개념으로 해결
 */

let numOfInput = Int(readLine()!)!
for _ in 0..<numOfInput {
    let brackets = Array(readLine()!)
    var stack = [Character]()
    for bracket in brackets {
        if bracket == "(" {
            stack.append(bracket)
        } else {
            if stack.isEmpty {
                stack.append(bracket)
                break
            } else {
                stack.popLast()
            }
        }
    }
    print(stack.isEmpty ? "YES" : "NO")
}

