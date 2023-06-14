/*
 https://www.acmicpc.net/problem/9935
 
 메모리 109360KB, 시간 612ms, 코드길이 419B
 그냥 문자열과 폭발 문자열이 주어짐
 그냥 문자열에 폭발 문자열이 포함되어 있으면 터뜨려서 없앤다
 */


let inputString = Array(readLine()!)
let explosion = readLine()!

var rest = [String]()

for word in inputString {
    rest.append("\(word)")

    if rest.count >= explosion.count,
       word == explosion.last!,
       rest[(rest.count - explosion.count)...].joined() == explosion {
        for _ in 0..<explosion.count {
            rest.removeLast()
        }
    }
}

print(rest.isEmpty ? "FRULA" : rest.joined())
ㄴ
