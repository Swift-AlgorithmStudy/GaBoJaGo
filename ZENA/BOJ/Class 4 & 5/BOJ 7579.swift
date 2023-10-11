/*
 https://www.acmicpc.net/problem/7579
 */
var input = readLine()!.split(separator: " ").map { Int($0)! }
let (N, M) = (input[0], input[1])
let memory = readLine()!.split(separator: " ").map { Int($0)! }
let cost = readLine()!.split(separator: " ").map { Int($0)! }


/*
 MARK: - dp
 dp[m] -> m 바이트의 메모리를 사용할 때의 최소비용
 */

//let sumOfMemory = memory.reduce(0, +)
//var dp = Array(repeating: Int.max / 2, count: sumOfMemory + 1)
//dp[0] = 0
//dp[memory[0]] = cost[0]
//for count in 1..<N {
//    for next in stride(from: sumOfMemory, to: memory[count], by: -1) {
//        dp[next] = min(dp[next], dp[next - memory[count]] + cost[count])
//    }
//}
//print(dp[M..<sumOfMemory].min()!)



/*
 MARK: - knapsack
 dp[N][C] = 앱의 개수가 n, 코스트가 c일 때 최대메모리
 */
let sumOfCost = cost.reduce(0, +)
var dp = Array(repeating: Array(repeating: 0, count: 10_001), count: 101)
dp[0][cost[0]] = memory[0]
for count in 1..<N {
    for currentCost in 0...sumOfCost {
        dp[count][currentCost] = dp[count - 1][currentCost]
        if currentCost - cost[count] < 0 { continue }
        dp[count][currentCost] = max(dp[count][currentCost],
                                     dp[count - 1][currentCost - cost[count]] + memory[count])
    }
}

print(dp[N-1].firstIndex(where: {$0 >= M})!)
