// class Solution {
//     func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
    
//         var res = 0 
//         var myTickets = tickets
//         var target = myTickets[k]
//         myTickets.sort(by: >)
//         var length = myTickets.count

//         while length > 0 && target > 0 {
//             if  myTickets.contains(0) {
//                 myTickets.removeAll { $0 == 0 }
//                 length = myTickets.count             
//             } else {
//                 myTickets = myTickets.map { $0 - 1 }
//                 res += length
//                 target -= 1
//             }  
//         }
//         return res 
//     }
// }

class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var res = 0
        var myTickets = tickets
        var target = myTickets[k]
        var length = myTickets.count

        while myTickets[k] > 0 {
            for i in 0..<length {
                if myTickets[i] > 0 {
                    res += 1
                    myTickets[i] -= 1
                    if i == k {
                        target -= 1
                    }
                    if target == 0 {
                        return res
                    }
                }
            }
        }

        return res
    }
}

// 모든 요소를 -1 하는 법 
// numbers = numbers.map { $0 - 1 }

// 특정 값 제거하는 법
// myArray.removeAll { $0 == targetValue }
