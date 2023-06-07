/*
 https://leetcode.com/problems/minimum-amount-of-time-to-fill-cups/description/?envType=list&envId=ren7fpc7
 8ms
 세 개의 컵(cold, warm, hot)의 용량이 주어지는데, 한 번에 두 개의 컵씩 1만큼 채울 때 모든 물컵을 용량에 맞게 모두 채우려면 몇 번 반복해야하는지 리턴한다
 나머지 두 컵은 모두 채워졌고 한 컵만 채우면 되더라도 한 번에 1씩만 채울 수 있음
 */

class Solution {
    func fillCups(_ amount: [Int]) -> Int {
        var restAmount = amount.sorted(by: >)
        var repeatCount = 0
        while restAmount[0] > 0 {
            restAmount[0] -= 1
            restAmount[1] -= 1
            repeatCount += 1
            restAmount = restAmount.sorted(by: >)
        }
        return repeatCount
    }
}
