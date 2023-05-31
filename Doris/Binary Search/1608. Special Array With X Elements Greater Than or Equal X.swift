class Solution {
    func specialArray(_ nums: [Int]) -> Int {
        /*
        1부터 5까지 돌아갈때
        nums[i] >= 1 이면
        1보다 큰수를 res.append()
        res.count == i (1)일때 i 출력
    
        */
        for i in 1...1000 {
            var res = [Int]()
            for x in nums {
                if x >= i {
                    res.append(i)
                }
            } 
            if i == res.count {
                return i
            }
        }  
        return -1 
    }
}