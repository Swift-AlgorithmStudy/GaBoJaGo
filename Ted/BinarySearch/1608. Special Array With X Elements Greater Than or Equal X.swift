/**
1. 배열의 길이값과 정렬된 배열을 지정한다.
2. x보다 크거나 같은 값이 x개 있을 때, 그 값을 반환하는 것이다.
3. 이진 탐색으로 찾기 위해 배열 길이 - 중간 인덱스 값을 x로 지정
4. 만약 배열의 중간값이 x보다 크거나 같다면,
4-1. 만약 mid == 0 이거나 array[mid - 1]가 x보다 작다면 현재 x값이 정답이기 때문에
    x를 반환한다.
4-2. 만약 4-1이 아니라면 왼쪽을 탐색하여 값을 찾는다.
5. 만약 배열의 중간값이 x보다 작다면 오른쪽을 탐색한다.
6. 없다면 -1을 반환한다.
*/

class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        let count = nums.count, array = nums.sorted()
        var left = 0, right = count - 1
        
        while left <= right {
            let mid = left + (right - left) / 2
            let x = count - mid
            
            if array[mid] >= x {
                if mid == 0 || array[mid - 1] < x {
                    return x
                } else {
                    right = mid - 1
                }
            } else {
                left = mid + 1
            }
        }
        return -1
    }
}
