/*
 https://www.acmicpc.net/problem/3273
 */
let n = Int(readLine()!)!
let sequence = readLine()!.split(separator: " ").map({Int($0)!}).sorted()
let x = Int(readLine()!)!
/*
 n: 수열의 크기
 sequence: 수열
 x: a[left] + a[right] = x를 만족하는 자연수
 */
var left = 0, right = n-1
var result = 0
while left < right {
    let total = sequence[left] + sequence[right]
    if total == x {
        left += 1
        right -= 1
        result += 1
    } else if total < x {
        left += 1
    } else {
        right -= 1
    }
}
print(result)
