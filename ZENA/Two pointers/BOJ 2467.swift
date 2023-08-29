/*
 https://www.acmicpc.net/problem/2467
 */
let N = Int(readLine()!)!
let liquid = readLine()!.split(separator: " ").map({Int($0)!}).sorted()
/*
 n: 전체 용액의 수 (2 <= N <= 100_000)
 liquid: 산성, 알칼리성 용액의 특성값
 */
var left = 0, right = N-1
var result = (liquid[left], liquid[right])
while left < right {
    let total = liquid[left] + liquid[right]
    let absoluteResultTotal = abs(result.0 + result.1)
    if abs(total) < absoluteResultTotal {
        result = (liquid[left], liquid[right])
    }
    if total < 0 {
        left += 1
    } else {
        right -= 1
    }
}
print(result.0, result.1)
