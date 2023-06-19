let N = Int(readLine()!)!
var budgets = readLine()!.split(separator: " ").map{ Int($0)!}.sorted(by: <)   //오름차순으로 정렬
var start = 1
var end = budgets.max()!
var result = 0

let M = Int(readLine()!)!

while start <= end {
    let mid = (start + end) / 2
    var sum = 0
    
    for budget in budgets {
        sum += min(budget, mid)
    }
    
    if sum <= M {
        result = mid
        start = mid + 1
    } else {
        end = mid - 1
    }
}

print(result)
