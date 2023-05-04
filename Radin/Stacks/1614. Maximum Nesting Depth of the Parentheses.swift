import Foundation

class Solution1614 {
    func maxDepth(_ s: String) -> Int {
        var depth : Int = 0
        var maxD : Int = 0
        for str in s {
            if str == "(" {
                depth += 1
            }
            else if str == ")" {
                if maxD < depth {
                    maxD = depth
                }
                depth -= 1
            }
        }
        return maxD
    }
}

var solution1614 = Solution1614()
print(solution1614.maxDepth("(1)+((2))+(((3)))"))
