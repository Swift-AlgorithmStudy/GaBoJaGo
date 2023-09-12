/*
 https://www.acmicpc.net/problem/2137
 */

let n = Int(readLine()!)!
var bulb = Array(readLine()!).map({Int(String($0))!})
var target = Array(readLine()!).map({Int(String($0))!})

func switchBulb(current: [Int], target: [Int]) -> Int {
    var copyCurrent = current
    var press = 0
    for index in 1..<n {
        if copyCurrent[index-1] == target[index-1] { continue }
        press += 1
        for side in index-1...index+1 {
            if side < n {
                copyCurrent[side] = 1 - copyCurrent[side]
            }
        }
    }
    if copyCurrent == target {
        return press
    } else {
        return Int.max - 1 // Int.max로 하면 아래에서 전구 스위치를 한 번 누르고 넘겨주는 것 때문에 오버플로우남
    }
}
// 첫번째 전구의 스위치를 누르지 않는 경우
var result = switchBulb(current: bulb, target: target)

// 첫번째 전구의 스위치를 누르는 경우
bulb[0] = 1 - bulb[0]
bulb[1] = 1 - bulb[1]
result = min(result, switchBulb(current: bulb, target: target) + 1)

print(result == Int.max - 1 ? -1 : result)
