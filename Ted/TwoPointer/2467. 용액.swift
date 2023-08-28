let N = Int(readLine()!)!
let material = readLine()!.split(separator: " ").map { Int($0)! }
var (start, end, ans, diff) = (0, material.count-1, [0, 0], Int.max)

for _ in 0..<N {

    if start >= end {
        break
    }
    
    let sum = material[start] + material[end]
        
    if sum == 0 {   // 0이 나왔을 때
        ans = [material[start], material[end]]
        
        break
    }
    
    if abs(sum) < diff {    // 새로 들어온 것의 절대값이 더 작을 때
        diff = abs(sum)
        ans = [material[start], material[end]]
    }
    
    
    if sum < 0 {   // 음수일 때
        start += 1
    }
    
    else if sum > 0 {   // 양수일 때
        end -= 1
    }
    
}

print(ans.first!, ans.last!)
