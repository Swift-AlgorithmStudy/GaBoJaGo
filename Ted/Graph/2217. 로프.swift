/***
1. N을 입력받고, ropes에 값을 추가한 뒤, 내림차순으로 정렬한다.
2. 병렬적으로 놓는 것이 나은지를 확인하기 위해,
   가장 큰 값부터(내림차순을 사용한 이유) 차례대로 계산한다.
3. 가장 큰 값만 사용하는 것과 옆에 있는 값을 추가하여 병렬적으로 놓는 것 중 선택하여 max 값을 추출하는 것을 반복한다.
*/

let N = Int(readLine()!)!
var ropes = [Int]()
var result = 0

for _ in 0..<N {
    ropes.append(Int(readLine()!)!)
}
ropes.sort(by: >)   //내림차순

for i in 0..<N {
    result = max(result, ropes[i] * (i + 1))
}
print(result)
