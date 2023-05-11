class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var ticket = tickets
        var currentIndex = 0
        var time = 0
        
        while true {
            //만약 해당 인덱스의 사람이 티켓을 살 필요가 없을 때 시간을 반환한다.
            if ticket[k] == 0 {
                return time
            }
            
            //살 티켓이 남아있을 때, 시간을 추가해주고, 인덱스를 옮긴다.
            if ticket[currentIndex] > 0 {
                ticket[currentIndex] -= 1
                currentIndex += 1
                time += 1
            } else {
                currentIndex += 1
            }
            
            //만약 끝까지 돌았다면 다시 처음으로 온다.
            if currentIndex == ticket.count {
                currentIndex = 0
            }
        }
        
    }
}
