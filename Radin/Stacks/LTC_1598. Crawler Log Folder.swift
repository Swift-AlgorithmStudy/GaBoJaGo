import Foundation

class Solution1598 {
    func minOperations(_ logs: [String]) -> Int {
        var list: [String] = []
        for log in logs {
            if log == "../" {
                list.popLast()
            }
            else if log == "./" {
                continue
            }
            else {
                list.append(log)
            }
        }
        return list.count
    }
}

let logs = ["d1/","../","../","../"]
var solution1598 = Solution1598()
print(solution1598.minOperations(logs))