class Solution {
    func firstUniqChar(_ s: String) -> Int {
    
        let characters = Array(s)
        
        for char in characters {
            //처음 인덱스와 마지막 인덱스 값이 같다는 것은 해당값이 하나만 있다는 의미
            if characters.firstIndex(of: char) == characters.lastIndex(of: char) {
                return characters.firstIndex(of: char) ?? -1
            }
        }
        return -1
    }
}
