/**
1. nums를 정렬시킨다. (sortNums)
2. query를 순회하면서 sortNums 있는 요소를 확인한다.
3. 만약 query의 요소보다 sum(sortNums의 합) + sortNums가 크거나 같다면, 해당하는 값까지 포함시킬 수 있다는 것이기 때문에, 해당 값을 sum에 더해주고, cnt를 추가해준다.
4. 만약 query를 한 바퀴 순회했다면 cnt을 result라는 배열에 추가해주고, sum과 cnt를 초기화해준다.
5. nums까지 다 순회했다면 result를 반환한다.
*/

class Solution {
    func answerQueries(_ nums: [Int], _ queries: [Int]) -> [Int] {
        let n = nums.count, m = queries.count, sortNums = nums.sorted()
        var sum = 0, cnt = 0, result = [Int]()
        
        for i in 0..<m {
            for j in 0..<n {
                if sum + sortNums[j] <= queries[i] {
                    sum += sortNums[j]
                    cnt += 1
                }
            }
            result.append(cnt)
            sum = 0
            cnt = 0
        }
        return result
    }
}
