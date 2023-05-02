class Solution {
    func calPoints(_ operations: [String]) -> Int {

        var arrList = [Int]()

        for i in operations {
            if i == "C" {
                arrList.removeLast()
            } else if i == "D" {
                arrList.append(arrList[arrList.count-1] * 2)
            } else if i  == "+" {
                arrList.append(arrList[arrList.count-1] + arrList[arrList.count-2])
            } else {
                arrList.append(Int(i)!)
            }
        }
        return arrList.reduce(0, +)
    }
}