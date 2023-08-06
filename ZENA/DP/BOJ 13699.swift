let n = Int(readLine()!)!
var dp = Array(repeating: 0, count: 36)

dp[0] = 1
dp[1] = 1

if n > 1 {
    for target in 2...n {
        for ignitionN in 1...target {
            dp[target] += dp[ignitionN-1] * dp[target-ignitionN]
        }
    }
}

print(dp[n])
