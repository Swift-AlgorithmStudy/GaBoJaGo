/***
1. n을 입력받고, 배열을 입력받는다.
2. 배열 안에 있는 값을 전부 더한다. (전체 전력 소비량)
3. 가동된 전력량을 정의하고, power와 mid를 비교하여 최소값을 가동된 전력량에 더한다.
4. 만약 가동된 전력량이 전체의 반 이상이라면, 모든 컴퓨터를 종료할 수 있기 때문에 결과를 갱신하고, 탐색 범위를 오른쪽으로 이동한다.
*/

func findShutdownTime(_ serverRoom: [[Int]]) -> Int {
    let n = serverRoom.count // 서버실의 크기 (행과 열의 개수)
    var totalPower = 0 // 전체 전력 소비량
    
    // 전체 전력 소비량 계산
    for row in serverRoom {
        totalPower += row.reduce(0, +)
    }
    
    var left = 0 // 가능한 최소 종료 시간
    var right = totalPower // 가능한 최대 종료 시간
    var result = 0
    
    while left <= right {
        let mid = (left + right) / 2
        var shutdownPower = 0 // 가동된 전력량
        
        for row in serverRoom {
            for power in row {
                shutdownPower += min(power, mid)
            }
        }
        
        if shutdownPower * 2 >= totalPower {
            // 가동된 전력량이 전체 전력 소비량의 절반 이상인 경우
            // 모든 컴퓨터를 종료할 수 있는 시간이므로 결과 갱신 및 탐색 범위 축소
            result = mid
            right = mid - 1
        } else {
            // 가동된 전력량이 전체 전력 소비량의 절반 미만인 경우
            // 모든 컴퓨터를 종료할 수 없으므로 탐색 범위 확대
            left = mid + 1
        }
    }
    
    return result
}

// 입력 받기
let n = Int(readLine()!)! // 서버실의 크기 (행과 열의 개수)
var serverRoom = [[Int]]()

for _ in 0..<n {
    let row = readLine()!.split(separator: " ").map { Int($0)! }
    serverRoom.append(row)
}

// 종료 시간 계산
let shutdownTime = findShutdownTime(serverRoom)
print(shutdownTime)
