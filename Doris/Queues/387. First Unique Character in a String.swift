/*
찾아본거 : 문자열에서 특정 문자의 개수 찾기

let str = "Hello, world!"
let charToCount = "l"
let count = str.filter { $0 == Character(charToCount) }.count
print(count) // 출력 결과: 3


*/ 

/*
❌ Time Limit Exceeded ❌
영어 소문자 개수 26개 활용
시간 복잡도 O(n^2)
*/ 
class Solution {
    func firstUniqChar(_ s: String) -> Int {
        
        var list = [Character]()
        let unique = Set(s)

        if unique.count > 25 {
            return -1 
        } else {
            for char in s {
                var count = s.filter { $0 == char }.count
                if count == 1 {
                    return Array(s).firstIndex(of: char)!
                } 
            }
        }
        return -1
    }
}


/*
Dictionary 형태 사용
enumerated()는 Swift에서 문자열, 배열, 사전 등 컬렉션의 각 항목에 대해 index와 함께 iterate하는 데 사용되는 메서드
*/

class Solution {
    func firstUniqChar(_ s: String) -> Int {
        
        var dic: [Character:Int] = [:]

        for char in s {
            dic[char, default: 0] += 1
        }

        for (index, char) in s.enumerated() {
           if dic[char] == 1 {
               return index
           }
        }
        return -1
    }
}


/*
guard let 사용
훨씬 빠름 !! 
*/

class Solution {
    func firstUniqChar(_ s: String) -> Int {
        
        var dic: [Character:Int] = [:]

        for char in s {
            dic[char, default: 0] += 1
        }

        for (index, char) in s.enumerated() {
           guard dic[char] == 1 else { continue }
           
           return index
        }
        return -1
    }
}
