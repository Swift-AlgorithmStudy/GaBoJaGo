import Foundation
let N = Int(readLine()!)!
var dp = Array(repeating: 0, count: 100_001)

for n in 1...N {
    dp[n] = n
    for square in stride(from: 1, to: Int(sqrt(Double(n))) + 1, by: 1) {
        dp[n] = min(dp[n], dp[n - square * square] + 1)
    }
}

print(dp[N])
