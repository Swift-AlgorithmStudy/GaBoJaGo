/*
 https://www.acmicpc.net/problem/11399
 */

let N = Int(readLine()!)!
var time = readLine()!.split(separator: " ").map{Int($0)!}.sorted()
for index in 1..<time.count {
    time[index] += time[index - 1]
}
print(time.reduce(0, +))
