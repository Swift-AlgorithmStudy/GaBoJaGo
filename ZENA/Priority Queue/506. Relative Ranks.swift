
/*
 https://leetcode.com/problems/relative-ranks/description/?envType=list&envId=ren7fpc7
 점수가 높은 순서대로 순위를 부여하는데, 1등은 Gold Medal, 2등은 실버, 3등은 브론즈, 이외에는 순위로 나타내서 반환
 63ms
 */

class Solution {
    func findRelativeRanks(_ score: [Int]) -> [String] {
        let sortedScore = score.sorted().reversed().map{Int($0)}

        return score.map {
            if $0 == sortedScore[0] { return "Gold Medal" }
            else if $0 == sortedScore[1] { return "Silver Medal" }
            else if $0 == sortedScore[2] { return "Bronze Medal" }
            else { return "\(sortedScore.firstIndex(of: $0)! + 1)" }
        }
    }
}
