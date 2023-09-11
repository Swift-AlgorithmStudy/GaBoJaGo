/*
 https://www.acmicpc.net/problem/2812
 */
let input = readLine()!.split(separator: " ").map({Int($0)!})
var (n, k) = (input[0], input[1])
let resultLength = n - k
let number = Array(readLine()!)
var stack = [Character]()

for number in number {
    while k > 0, !stack.isEmpty, stack.last! < number {
        stack.removeLast()
        k -= 1
    }
    stack.append(number)
}

/*
 질문: 고차함수를 체이닝하면 n^2인가요?

 1.
 var result = stack.map({String($0)}
 print(result.reduce("", +))

 2.
 print(stack.map({String($0)}).reduce("", +))
 */
for number in stack[0..<(resultLength)] {
    print(number, terminator: "")
}
