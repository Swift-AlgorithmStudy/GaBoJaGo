class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let num = nums.sorted()
        var sum: [Int] = [0]
        var result: [Int] = []

        for n in num {
            sum.append(sum.last! + n)
        }
        
        for query in 0..<queries.count {
            let count = find(sum, queries[query], 0, sum.count-1)
            result.append(count-1)
        }
        return result
    }
    
    func find(_ query: [Int], _ key: Int, _ low: Int, _ high: Int) -> Int {
        
        let mid: Int = low + (high - low)/2
        
        guard low <= high else { return low }
        
        if query[mid] <= key {
            return find(query, key, mid + 1, high)
        } else {
            return find(query, key, low, mid - 1)
        }
    }
}