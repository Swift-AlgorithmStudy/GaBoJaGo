/*
1. score 정렬 
2. 딕셔너리 key 값에 정렬된 score 넣어줌
3. score배열 길이만큼 list 만들어줌
4. dict의 key값과 score을 비교해 value res에 추가
5. res 출력
*/


class Solution {
    func findRelativeRanks(_ score: [Int]) -> [String] {

        let heap = score.sorted { $0 > $1 }
        var dict: [Int: String] = [:]
        var list = ["Gold Medal", "Silver Medal", "Bronze Medal"]
        var num = 4

        if score.count >= 4 {
            for i in 0..<score.count - 3 {
                list.append(String(num))
                num += 1
            }
        }
        
        for i in 0..<score.count {
            dict[heap[i]] = list[i]
        }
        
        var res: [String] = []

        for i in score {
            if let rank = dict[i] {
                res.append(rank)
            }
        }
        
        return res
        
    }
}

/*
PriorityQueue 
*/