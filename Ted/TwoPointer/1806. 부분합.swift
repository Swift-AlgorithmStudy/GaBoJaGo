let NS = readLine()!.split(separator: " ").map { Int($0)! }
let (N, S) = (NS[0], NS[1])
let subSum = readLine()!.split(separator: " ").map { Int($0)! }
var (start, end, sum, ans) = (0, 0, subSum.first!, 100001)

while true {
    
    if sum < S {    // 합이 S보다 작을 때 -> end 증가
        end += 1
        
        if end == N {   // index out of range
            break
        }
        
        sum += subSum[end]
    }
    
    else {  // 합이 S보다 크거나 같을 때 -> start 증가
        sum -= subSum[start]
        ans = min(ans, end - start + 1)
        start += 1
    }
    
}

print(ans != 100001 ? ans : 0)  // 만약 100001이면 전체를 더해도 S 미만이기 때문에 0 출력
