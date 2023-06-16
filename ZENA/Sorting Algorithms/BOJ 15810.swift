/*
 https://www.acmicpc.net/problem/1654
 
 메모리 134300KB, 시간 504ms, 코드길이 497B
 
 첫 줄에는 스태프들의 수와 불어야하는 풍선의 개수가 주어지고,
 다음줄에 스태프들이 풍선을 하나 부는데 걸리는 시간이 주어짐
 불어야하는 풍선의 개수를 모두 부는데 얼마나 걸리는지 최소시간을 출력하는 문제
 
 end와 start 포인트 값을 어떻게 바꿔주는지 잘 모르겠다 항상
 그리고 이번엔 end 최대값 구하는것때문에 계속 틀림 ㅡ.ㅡㅡㅡㅡ
 */

let input = readLine()!.split(separator: " ").map({Int($0)!})
let (_, requiredBalloons) = (input[0], input[1])
let timeForBalloon = readLine()!.split(separator: " ").map({Int($0)!}).sorted()

var start = 0, end = requiredBalloons * timeForBalloon.min()!
while start < end {
    let mid = (start + end) / 2
    let numOfBalloons = timeForBalloon.reduce(0, { $0 + mid / $1 })
    
    if numOfBalloons >= requiredBalloons {
        end = mid
    } else {
        start = mid + 1
    }
}

print(end)
