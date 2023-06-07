/*
 https://leetcode.com/problems/the-k-weakest-rows-in-a-matrix/?envType=list&envId=ren7fpc7
 72ms
 한 행의 1의 개수가 군인의 수이며 그 수의 합이 적을수록 weak하다. weakest한 순서대로 그 행을 k개만큼 반환하는 문제
 */
class Solution {
    func kWeakestRows(_ mat: [[Int]], _ k: Int) -> [Int] {
        var soldierCount: [Int: Int] = [:]
        for row in 0..<mat.count {
            soldierCount[row] = mat[row].reduce(0,+)
        }
        var sortedSoldierCount = soldierCount.sorted {
            if $0.1 == $1.1 {
                return $0.0 < $1.0
            }
            return $0.1 < $1.1
        }
        var result = [Int]()
        for index in 0..<k {
            result.append(sortedSoldierCount.first!.key)
            sortedSoldierCount.remove(at: sortedSoldierCount.startIndex)
        }
        return result
    }
}
