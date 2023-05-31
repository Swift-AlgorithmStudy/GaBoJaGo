class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        let num = nums.sorted()
        
        for i in 0..<num.last!+1 {
            if i == find(num, i, 0, num.count-1) {
                return i
            }
        }
        return -1
    }
    
    func find(_ nums: [Int], _ k: Int, _ low: Int, _ high: Int) -> Int{
        let mid: Int =  low + (high - low) / 2
        guard low <= high else { return nums.count - low }
        
        if nums[mid] < k {
            return find(nums, k, mid+1, high)
        } else {
            return find(nums, k, low, mid-1)
        }
    }
}