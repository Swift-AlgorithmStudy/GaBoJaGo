/*
 https://www.acmicpc.net/problem/11508
 */
let N = Int(readLine()!)!
var dairy = [Int]()
for _ in 0..<N {
    dairy.append(Int(readLine()!)!)
}
dairy.sort(by: >)

var cost = 0
dairy.indices.forEach { index in
    if (index + 1) % 3 != 0 {
        cost += dairy[index]
    }
}
print(cost)
