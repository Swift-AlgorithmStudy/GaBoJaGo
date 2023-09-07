/*
 https://www.acmicpc.net/problem/2407
 */

let N = Int(readLine()!)!
let liquid = readLine()!.split(separator: " ").map{Int($0)!}.sorted()

var low = 0, high = N - 1
var mostZero = 2_000_000_000
var (left, right) = (liquid[low], liquid[high])

while low < high {
    let sum = liquid[low] + liquid[high]
    if mostZero > abs(sum) {
        mostZero = abs(sum)
        (left, right) = (liquid[low], liquid[high])
    }
    if sum > 0 {
        high -= 1
    } else {
        low += 1
    }
}
print(left, right)
