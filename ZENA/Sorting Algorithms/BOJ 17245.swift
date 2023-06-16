/*
 https://www.acmicpc.net/problem/17245
 
 메모리 87540KB, 시간 476ms, 코드길이 647B
 
 첫줄에 정수 N이 주어진다
 서버실에는 N*N개의 칸에 컴퓨터가 몇대씩 쌓여있고 다음 N*N개의 입력으로 몇대인지 주어진다
 1분에 1층씩 차가운공기가 올라온다고 할 때
 몇분이 되어야 50% 이상의 컴퓨터가 동작할까
 
 end와 start 포인트 값을 어떻게 정해주는지 어려움 ,,
 */

import Foundation
let N = Int(readLine()!)!
var computers = [[Int]]()
var start = 0, end = 0, total = 0

for n in 0..<N {
    computers.append(readLine()!.split(separator: " ").map({ Int($0)! }))
    if computers[n].max()! > end {
        end = computers[n].max()!
    }
    total += computers[n].reduce(0,+)
}

// start와 end가 1차이 나는 순간 무한 루프가 돌아버리므로
while start + 1 < end {
    let mid = (start + end) / 2
    var turnedOn = 0
    for n in 0..<N {
        computers[n].forEach { computer in
            turnedOn += computer > mid ? mid : computer
        }
    }

    // turnedOn >= Int(Double(total) * 0.5)
    // 이걸로 조건문 달았었는데 Int형으로 짜르면서 값이 달라졌는지 계속 틀렸었다
    if (Double(turnedOn) / Double(total)) >= 0.5 {
        end = mid
    } else {
        start = mid
    }
}

print(end)


/*
 5
 1 4 0 2 1
 0 0 5 6 3
 8 4 7 2 0
 7 1 0 5 3
 4 5 7 9 1
 */
