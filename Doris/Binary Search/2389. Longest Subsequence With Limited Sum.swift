class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {

        let nums = nums.sorted()
        var result = [Int]()
        
        for query in queries {
            var sum: Int = 0
            var tmp: Int = 0
            for i in nums {
                sum += i
                if sum <= query {
                    tmp += 1 
                } else {
                    break
                }
            }
            result.append(tmp)
        }
        return result
    }
}