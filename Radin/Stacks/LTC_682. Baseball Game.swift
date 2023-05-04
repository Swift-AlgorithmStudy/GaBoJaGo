import Foundation

class Solution682 {
    func calPoints(_ operations: [String]) -> Int {
        var record: [Int] = []
        var sum : Int = 0
        for i in operations {
            if i == "C" {
                record.popLast()
            }
            else if i == "D" {
                record.append(record[record.endIndex - 1] * 2)
            }
            else if i == "+" {
                var cal = 0
                cal = record[record.endIndex - 1] + record[record.endIndex - 2]
                record.append(cal)
            }
            else {
                guard let intOps = Int(i) else { break}
                record.append(intOps)
                print(record)
            }
        }
        for j in record {
            sum += j
        }
        return sum
    }
}
let operations : [String] = ["5","-2","4","C","D","9","+","+"]
let solution = Solution682()
print(solution.calPoints(operations))