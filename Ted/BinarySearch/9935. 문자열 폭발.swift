/***
1. 스택에 입력받은 값(input)을 추가한다.
2. 만약 추가된 값이 bomb의 마지막 값과 같다면, 스택의 길이를 count로 정의한다.
3. 만약 스택의 길이가 bomb의 길이보다 크거나 같고, 스택에 들어있는 문자열이 bomb와 같다면
   bomb의 길이만큼 스택에서 pop해준다.
4. 만약 스택에 아무 값도 없으면 "FRULA"를, 아니라면 스택을 반환한다.
*/
var input = String(readLine()!)
let bomb = String(readLine()!)

var stack = [Character]()

for i in input {
    stack.append(i)
    
    if i == bomb.last! {
        let count = stack.count
        
        if count >= bomb.count && String(stack[(count - bomb.count)...]) == bomb {
            (0..<bomb.count).forEach { _ in
                stack.popLast()
            }
        }
    }
    
}
print(stack.isEmpty ? "FRULA" : String(stack))
