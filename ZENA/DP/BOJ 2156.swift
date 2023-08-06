let N = Int(readLine()!)!
var wine = Array(repeating: 0, count: 10_001)
for n in 1...N {
    wine[n] = Int(readLine()!)!
}

var dp = Array(repeating: 0, count: 10_001)
dp[1] = wine[1]
dp[2] = wine[1] + wine[2]
dp[3] = max(wine[1] + wine[2],
        max(wine[2] + wine[3],
            wine[3] + wine[1]))
if N > 3 {
    for n in 4...N {
        dp[n] = max(dp[n-1],
                max(dp[n-2] + wine[n],
                    dp[n-3] + wine[n-1] + wine[n]))
    }
}

print(dp[N])
