/*
 https://www.acmicpc.net/problem/1806
 */

let input = readLine()!.split(separator: " ").map({Int($0)!})
let (N, S) = (input[0], input[1])
var sequence = readLine()!.split(separator: " ").map({Int($0)!})
sequence.append(0)
var sum = sequence[0]
var minLength = N + 1
var left = 0, right = 0

while left <= right, right < N {
    if sum < S {
        right += 1
        sum += sequence[right]
    } else {
        minLength = min(minLength, right - left + 1)
        sum -= sequence[left]
        left += 1
    }
}

if minLength == N + 1 {
    minLength = 0
}

print(minLength)
