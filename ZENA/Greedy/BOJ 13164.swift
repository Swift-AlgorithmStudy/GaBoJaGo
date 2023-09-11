/*
 https://www.acmicpc.net/problem/13164
 */

let input = readLine()!.split(separator: " ").map{Int($0)!}
let (N, K) = (input[0], input[1])
let heights = readLine()!.split(separator: " ").map{Int($0)!}
var diff = Array(repeating: 0, count: N-1)
for n in 0..<diff.count {
    diff[n] = heights[n+1] - heights[n]
}
diff.sort()
print(diff[0..<N-K].reduce(0,+))
