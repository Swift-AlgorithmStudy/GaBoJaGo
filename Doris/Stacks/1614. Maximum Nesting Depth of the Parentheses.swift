class Solution {
    func maxDepth(_ s: String) -> Int {
        var count = 0
        var aList: [Int] = [0]

        for i in s {
            if i == "(" {
                count += 1
                aList.append(count)
                
            } else if i == ")" {
                count -= 1
                aList.append(count)
            }
        }

        return Int(aList.max()!)
    }
}