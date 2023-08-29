/*
 https://www.acmicpc.net/problem/1940
 */

let N = Int(readLine()!)!
let M = Int(readLine()!)!
var material = readLine()!.split(separator: " ").map({Int($0)!}).sorted()
var left = 0, right = material.count - 1
var total = 0
while left < right {
    let totalValue = material[left] + material[right]
    if totalValue == M {
        left += 1
        right -= 1
        total += 1
    } else if totalValue < M {
        left += 1
    } else {
        right -= 1
    }
}

print(total)
