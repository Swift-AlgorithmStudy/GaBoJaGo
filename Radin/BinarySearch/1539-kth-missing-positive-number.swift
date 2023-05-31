class Solution {
    func findKthPositive(_ arr: [Int], _ k: Int) -> Int {
        var missing: [Int] = []
        var num = 0 

        guard arr[arr.count-1] != arr.count else {
            return arr.count + k
        }
        
        while missing.count < k+1 {
            if !arr.contains(num) {
                missing.append(num)
            }
            num += 1
        }
        return missing[k]
    }
}