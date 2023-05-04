import Foundation

class Solution1700 {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var resultStudents: [Int] = students
        var resultSandwich: [Int] = sandwiches
        var count = 0
        
        while !resultSandwich.isEmpty {
            if resultSandwich[0] == resultStudents[0] {
                resultSandwich.remove(at: 0)
                resultStudents.remove(at: 0)
                count = 0
            }
            else {
                resultStudents.append(resultStudents[0])
                resultStudents.remove(at: 0)
                count += 1
                if count > resultSandwich.count {
                    break
                }
            }
        }
        return resultSandwich.count
    }
}

var solution1700 = Solution1700()
print(solution1700.countStudents([1,1,0,0], [0,1,0,1]))
