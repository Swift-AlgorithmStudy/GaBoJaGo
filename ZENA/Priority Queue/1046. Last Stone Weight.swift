/*
 https://leetcode.com/problems/last-stone-weight/?envType=list&envId=ren7fpc7
 22ms
 돌게임. 무게가 가장 큰 두 돌을 smash해서 무게를 줄여나가는데, 마지막엔 무게가 한 놈만 남게 된다. 이 돌의 무게를 반환하는 문제. 반복문, 정렬로 풀었따.
 */
class Solution {
    func lastStoneWeight(_ stones: [Int]) -> Int {
        if stones.count == 1 { return stones[0] }
        var lastStones = stones.sorted(by: >)
        while lastStones[1] > 0 {
            let smashWeight = min(lastStones[0], lastStones[1])
            lastStones[0] -= smashWeight
            lastStones[1] -= smashWeight
            lastStones = lastStones.sorted(by: >)
        }
        return lastStones[0]
    }
}
