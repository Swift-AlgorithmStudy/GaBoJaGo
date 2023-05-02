class Solution {
    func minOperations(_ logs: [String]) -> Int {
        
        var count = 0
        
        for i in logs {
            if  i == "./" {
                count == count
                } 
            else if i == "../" {
                if count == 0 {
                    count = 0
                } else {
                    count -= 1
                }
            } 
            else {
                count += 1
            }
        }
        return count 
    }
}