/*
 https://www.acmicpc.net/problem/1654
 
 메모리 69244KB, 시간 16ms, 코드길이 581B
 
 내가 가진 랜선 개수 numOfCableLAN과 필요한 랜선 개수가 주어지고,
 numOfCableLAN만큼 각 랜선의 길이가 주어진다
 최대한 길게 같은 길이로 잘라서 필요한 랜선의 개수로 맞추면 되는 문제
 
 첫 문제부터 자꾸 정렬을 안해서 런타임 에러가 떴다
 */

let input = readLine()!.split(separator: " ").map({Int($0)!})
let numOfCableLAN = input[0], requiredCableLAN = input[1]

var cableLAN: [Int] = []
for _ in 0..<numOfCableLAN {
    cableLAN.append(Int(readLine()!)!)
}
cableLAN = cableLAN.sorted()

var start = 1, end = cableLAN.reduce(0,+) / numOfCableLAN
while start <= end {
    let mid = (start + end) / 2
    var enableCableSum = 0
    for LAN in cableLAN {
        enableCableSum += (LAN / mid)
    }
    
    if enableCableSum < requiredCableLAN {
        end = mid - 1
    } else {
        start = mid + 1
    }
}

print(end)
