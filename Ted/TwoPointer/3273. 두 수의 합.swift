let n = Int(readLine()!)!
let material = readLine()!.split(separator: " ").map { Int($0)! }.sorted()
let x = Int(readLine()!)!
var (start, end, ans) = (0, material.count-1, 0)

for _ in 0..<n {

    if start >= end {
        break
    }

    if (material[start] + material[end]) == x {     // 값이 같을 때
        ans += 1
        start += 1
        end -= 1
    }

    else if (material[start] + material[end]) < x {     // 더한 값이 M보다 더 작을 때 -> start 옮기기
        start += 1
    }

    else if (material[start] + material[end] > x) {     // 더한 값이 M보다 더 클 때 -> end 옮기기
        end -= 1
    }
}

print(ans)
