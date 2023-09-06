/*
 https://www.acmicpc.net/problem/1931
 
 메모리 71324KB, 시간 68ms, 코드길이 255B
 로프를 병렬로 연결하면 여기에 걸리는 중량을 w(무게)/k(개의 로프)나눌 수 있다
 주어진 로프들을 이용해 들어올릴 수 있는 최대 중량을 구하는 문제
 */

let N = Int(readLine()!)!
var ropeMaxWeights = [Int]()
for _ in 0..<N {
    ropeMaxWeights.append(Int(readLine()!)!)
}

ropeMaxWeights = ropeMaxWeights.sorted()
var maxWeight = 0

for (index, ropeMaxWeight) in ropeMaxWeights.enumerated() {
    let curMaxWeight = ropeMaxWeight * (N - index)
    maxWeight = max(maxWeight, curMaxWeight)
}

print(maxWeight)

/*
 5  20  35  40  70  110
 30 100 140 120 140 110
 */
