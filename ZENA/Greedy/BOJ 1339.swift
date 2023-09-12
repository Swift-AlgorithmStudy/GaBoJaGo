/*
 https://www.acmicpc.net/problem/1339
 */

let n = Int(readLine()!)!
var voca = [String]()
var cost = [Character: Int]()
for _ in 0..<n {
    voca.append(readLine()!)
    var weight = 1
    for word in voca.last!.reversed() {
        if let _ = cost[word] {
            cost[word]! += weight
        } else {
            cost[word] = weight
        }
        weight *= 10
    }
}

var number = 9
var sum = 0
for result in cost.sorted(by: { $0.value > $1.value }) {
    sum += result.value * number
    number -= 1
}
print(sum)

/*
 2
 GCF    (783)
 ACDEB  (98654)
 99437
 
 우선순위
 1. 최빈값
 2. 높은 자리수
 */
