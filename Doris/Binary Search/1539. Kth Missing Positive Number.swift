class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        
        /*
        while res.count == k 가 될때까지
        for i in 1...2000
        if !arr.contains(i) {
            res.append(i)
        }
        */

        guard !arr.isEmpty else {
            return 0
        }

        var res = [Int]()

        while res.count < k {
            for i in 1...2000 {
                if !arr.contains(i) {
                    res.append(i)
                }
            }
        }

        return res[k-1]
    }
}

