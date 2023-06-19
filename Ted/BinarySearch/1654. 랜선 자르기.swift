/***
1. K와 N을 입력받는다.
2. 배열에 값을 추가받는다.
3. 최소 길이(start)와 최대 길이(end)를 설정한다. (사실상 left, right임)
4. mid를 찾은 뒤, mid로 나눈 값들을 더하여 임시 선의 개수(temp)를 저장한다.
5. 만약 temp가 N보다 크거나 같을 때(최소 개수 만족),
5-1. 만약 result가 mid보다 작으면 result를 mid값으로 바꾼다.
5-2. 만약 아니라면 오른쪽 부분을 탐색한다.
6. 만약 temp가 작다면 왼쪽 부분을 탐색한다.
*/

let input = readLine()!.split(separator: " ").map({ Int($0)!})
let K = input[0]
let N = input[1]
var result = 0
var lines = [Int]()

for _ in 0..<K {
    lines.append(Int(readLine()!)!)
}

var start = 1 //최소 길이
var end = lines.max()!  //최대 길이

while start <= end {
    let mid = (start + end) / 2
    var temp = 0
    
    for line in lines {
        temp += line / mid
    }
    
    if temp >= N {
        if result < mid {
            result = mid
        }
        start = mid + 1
    } else {
        end = mid - 1
    }
    
}

print(result)
