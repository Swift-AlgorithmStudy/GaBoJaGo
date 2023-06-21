/*
 https://www.acmicpc.net/problem/1931
 
 메모리 73544KB, 시간 160ms, 코드길이 845B
 회의 시작시간, 종료시간이 주어지며 한 회의실에 최대한 많은 회의를 진행한다고 하면 최대 몇 개의 회의가 진행될 수 있을지 구하는 문제
 */

let N = Int(readLine()!)!
var meetings = [Meeting]()

for _ in 0..<N {
    let input = readLine()!.split(separator: " ").map({ Int($0)! })
    meetings.append(Meeting(input[0], input[1]))
}

// 정렬해서 종료시간이 작은 것부터 회의실에 배정함. 현재 currentTime은 마지막 회의 종료시간이 되며, 현 시간 이후로 startTime인 회의가 있으면 종료시간이 적은 것부터 다시 배정
meetings = meetings.sorted()

var countEnableMeetings = 0
var currentTime = 0

for meeting in meetings {
    if meeting.startTime >= currentTime {
        currentTime = meeting.endTime
        countEnableMeetings += 1
    }
}

print(countEnableMeetings)


struct Meeting: Comparable {
    let startTime: Int
    let endTime: Int
    
    init(_ startTime: Int, _ endTime: Int) {
        self.startTime = startTime
        self.endTime = endTime
    }
    
    // 종료시간이 작은 순서대로 정렬, 종료시간이 같으면 시작시간이 작은 순서대로 정렬
    static func <(lhs: Self, rhs: Self) -> Bool {
        if lhs.endTime == rhs.endTime {
            return lhs.startTime < rhs.startTime
        }
        return lhs.endTime < rhs.endTime
    }
}
