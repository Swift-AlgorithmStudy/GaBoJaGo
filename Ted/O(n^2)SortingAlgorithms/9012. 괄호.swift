//1. 테스트 케이스 개수를 받아온다.
//2. "("를 1, ")"를 -1로 둔다.
//3. 만약 -1이 된다는 것은 괄호가 이상한 것이기 때문에 NO를 반환
//4. 0일 때 YES, 아닐 때 NO를 반환

import Foundation

let T = Int(readLine()!)!

for _ in 0..<T {
    let input = readLine()!
    var count = 0
    
    for char in input {
        if char == "(" {
            count += 1
        } else if char == ")" {
            count -= 1
            
            if count < 0 {
                break
            }
        }
    }
    print(count == 0 ? "YES" : "NO")
}
