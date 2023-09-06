/*
 https://www.acmicpc.net/problem/13305
 
 메모리 79612KB, 시간 96ms, 코드길이 443B
 
 입력
 도시의 개수
 도시간 도로의 길이
 도시별 주유비
 
 출력
 왼쪽에서 오른쪽까지 가는데 주유비의 최소비용
 
 선형 순회로 풀이 가능
 (5) --2-- (2) --3-- (4) --1-- (1)일 때,
 // minCost = 5, sumCost = 10
 // minCost = 2, sumCost = 10 + 6
 // minCost = 2, sumCost = 10 + 6 + 2
 // 마지막 도시의 주유비는 얼마이든 상관없음. 어차피 이미 도착해서 더 이동을 하지 않으므로 기름을 넣지 않는다.

 */


let N = Int(readLine()!)!
let roads = readLine()!.split(separator: " ").map{ Int($0)! }
let gasCost = readLine()!.split(separator: " ").map{ Int($0)! }

// 현재 와있는 도시의 주유비가 이전 도시의 주유비보다 비싸면 여기서 기름 X
var minCost = Int.max
var sumCost = 0
for n in 0..<N-1 {
    if gasCost[n] < minCost {
        minCost = gasCost[n]
    }
    sumCost += minCost * roads[n]
}
print(sumCost)
