let input = readLine()!.split(separator: " ").map{ Int($0)!}
let N = input[0]
let M = input[1]
let times = readLine()!.split(separator: " ").map{ Int($0)! }

var min = 0
var max = times.max()! * M
var result = 0

while min <= max {
    let mid = (min + max) / 2
    var cnt = 0
    
    for time in times {
        cnt += mid / time
    }
    
    if cnt >= M {
        result = mid
        max = mid - 1
    } else {
        min = mid + 1
    }
}

print(result)
