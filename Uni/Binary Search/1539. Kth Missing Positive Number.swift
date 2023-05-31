class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var start = 0, end = arr.count - 1
        while start <= end {
            let mid = (start + end) / 2
            if k > arr[mid] - mid - 1 {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        return start + k
    }
}