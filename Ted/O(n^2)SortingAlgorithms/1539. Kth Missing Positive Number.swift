/**
1. 빈 배열을 생성한다.
2. 원래 있던 배열을 순회하며 만약 없는 값이라면 빈 배열에 추가한다.
3. 빈 배열에서 인덱스를 추출한다.

---Runtime Error---

1. 1부터 배열의 길이 + k만큼 순회한다.
2. 만약 i를 포함하지 않는다면 k -= 1을 한다.
3. 만약 k == 0이 되었을 때 k번째에 해당하는 없는 값이기 때문에 i를 반환한다.

ex. i = 1 -> k = 2
    i = 2 -> k = 2
    ...
    i = 5 -> k = 1 (5가 배열에 없기 때문에 k -= 1)
    i = 6 -> k = 0
    따라서 6을 반환
*/

class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var k = k
        for i in 1...arr.count + k {
            if !arr.contains(i) {
                k -= 1
            }
            if k == 0 {
                return i
            }
        }
        return 0
    }
}
