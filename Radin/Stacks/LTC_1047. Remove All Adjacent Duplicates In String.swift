import Foundation

class Solution1047 {
    func removeDuplicates(_ s: String) -> String {
        let list = s.map {String($0)}
        var resultList : [String] = []
        for index in 0 ..< list.count {
            if resultList.isEmpty {
                resultList.append(list[index])
            }
            else if resultList[resultList.endIndex-1] == list[index]{
                resultList.popLast()
            }
            else if resultList[resultList.endIndex-1] != list[index]{
                resultList.append(list[index])
            }
        }
        return resultList.joined(separator:"")
    }
}

var solution1047 = Solution1047()
print(solution1047.removeDuplicates("abbaca"))