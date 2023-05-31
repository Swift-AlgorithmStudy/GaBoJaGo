class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var n1 = nums1.sorted()
        var n2 = nums2.sorted()
        var result: [Int] = []
         
        if nums1.count > nums2.count {
            for n in n2 {
                if let index = same(n1, 0..<n1.count, n) {
                    result.append(n1[index])
                    n1.remove(at: index)
                }
            }
        } 
        else {
            for n in n1 {
                if let index = same(n2, 0..<n2.count, n) {
                    result.append(n2[index])
                    n2.remove(at: index)
                }
            }
        }
        return result
    }
    
    func same(_ arr: [Int?], _ range: Range<Int>, _ val: Int) -> Int? {
        guard range.lowerBound < range.upperBound else {
            return nil
        } 
        let size = range.count
        let middle = range.lowerBound + (size / 2)
              
        if arr[middle] == val {
            return middle
        }
        else if arr[middle]! > val {
            return same(arr, range.lowerBound..<middle, val)
        }
        else {
            return same(arr, (middle+1)..<range.upperBound, val)
        }
    }
}
