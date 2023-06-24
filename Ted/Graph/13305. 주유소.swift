/***
1. 모든 input값을 받는다.
2. 최소 비용인 min을 pay[0]으로 선정한다. (시작을 처음부터 해야하기 때문)
3. for문을 지나면서 pay에 있는 값과 min을 비교해서 만약 최소값이 나타나면 min을 교체해준다.
4. (최소값) * (거리)를 더해준다.
*/

let N = Int(readLine()!)!
var distance = readLine()!.split(separator: " ").map { Int($0)! }
var pay = readLine()!.split(separator: " ").map { Int($0)! }
var result = 0
var min = pay[0]

for i in 0..<N-1 {
    if pay[i] < min {
        min = pay[i]
    }
    result += min * distance[i]
}

print(result)
