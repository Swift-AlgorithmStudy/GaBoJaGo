class Solution {
    func removeDuplicates(_ s: String) -> String {
        
        var result = [Character]()
        
        for i in s {
            if let last = result.last, last == i {
                result.removeLast()
            }
            else{
                result.append(i)
            }
        }
        return String(result)
    }
}

