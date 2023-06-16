/*
 https://www.acmicpc.net/problem/2512
 
 메모리 70024KB, 시간 184ms, 코드길이 597B
 
 정해진 총액 이하에서 가능한 한 최대의 총 예산을 다음과 같은 방법으로 배정한다.

 1. 모든 요청이 배정될 수 있는 경우에는 요청한 금액을 그대로 배정한다.
 2. 모든 요청이 배정될 수 없는 경우에는 특정한 정수 상한액을 계산하여
    그 이상인 예산요청에는 모두 상한액을 배정한다.
    상한액 이하의 예산요청에 대해서는 요청한 금액을 그대로 배정한다.
 */

let numOfProvince = Int(readLine()!)!
let requiredBudgets = readLine()!.split(separator: " ").map({Int(String($0))!}).sorted()
let totalBudget = Int(readLine()!)!

var left = 0, right = requiredBudgets[numOfProvince - 1]
while left <= right {
    let mid = (left + right) / 2
    
    var restBudget = totalBudget
    for requiredBudget in requiredBudgets {
        if requiredBudget < mid {
            restBudget -= requiredBudget
        } else {
            restBudget -= mid
        }
    }
    
    if restBudget < 0 {
        right -= 1
    } else {
        left += 1
    }
}

print(right)
