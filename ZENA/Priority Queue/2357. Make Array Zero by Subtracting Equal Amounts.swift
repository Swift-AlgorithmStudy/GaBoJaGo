/*
 https://leetcode.com/problems/make-array-zero-by-subtracting-equal-amounts/description/?envType=list&envId=ren7fpc7
 9ms
 주어진 배열에 0이 아닌 가장 작은 양수의 값으로 각 배열의 값들을 뺀다고 할 때, 모든 값이 0이 될 때까지 반복한 횟수를 반환하는 문제
 */

class Solution {
    func minimumOperations(_ nums: [Int]) -> Int {
        var sortedArray = nums.sorted()
        var subtractingCount = 0
        while sortedArray[nums.count - 1] > 0 {
            let hasValue = sortedArray.filter { $0 > 0 }.sorted()
            let subtractValue = hasValue[0]
            sortedArray = sortedArray.map{
                if $0 - subtractValue < 0 {
                    return 0
                }
                return $0 - subtractValue
            }
            subtractingCount += 1
        }
        return subtractingCount
    }
}
