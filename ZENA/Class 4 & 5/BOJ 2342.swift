/*
 https://www.acmicpc.net/problem/2342
 */
// 0은 수열의 마지막을 의미만 하는 값이므로 버림
let order = readLine()!.split(separator: " ").map {Int($0)!}.dropLast()
var count = order.count
var dp = Array(repeating: Array(repeating: Array(repeating: Int.max, count: 5), count: 5), count: 100_001)

if count == 0 {
    print(0)
} else {
    print(cost(before: 0, after: order[0])
          + min(ddr(index: 1, left: order[0], right: 0),
                ddr(index: 1, left: 0, right: order[0]))
    )
}

/*
 index: 지시 사항 순서
 left: 왼쪽발 위치
 right: 오른쪽발 위치
 */
func ddr(index: Int, left: Int, right: Int) -> Int {
    if index == count { return 0 }
    
    var result = dp[index][left][right]
    if result != Int.max { return result }
    
    let next = order[index]
    if right != next { // move left
        result = min(
            result,
            cost(before: left, after: next)
            + ddr(index: index + 1, left: next, right: right))
    }
    if left != next { // move right
        result = min(
            result,
            cost(before: right, after: next)
            + ddr(index: index + 1, left: left, right: next))
    }
    dp[index][left][right] = result
    return result
}

func cost(before: Int, after: Int) -> Int {
    switch before {
    case 0: // move from center
        return 2
    case after: // stay
        return 1
    case after - 2, after + 2: // move to the other side
        return 4
    default: // move
        return 3
    }
}
