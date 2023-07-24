
// MARK: - 입력
let N = Int(readLine()!)!
let M = Int(readLine()!)!

// index가 출발 도시 번호
var buses = Array(repeating: [(destination: Int, cost: Int)](), count: N + 1)
for _ in 0..<M {
    let input = readLine()!.split(separator: " ").map({ Int($0)! })
    buses[input[0]].append((input[1], input[2]))
}

let input = readLine()!.split(separator: " ").map({ Int($0)! })
let (sourceCity, destinationCity) = (input[0], input[1])

// MARK: - 풀이
// 정렬안하면 시간초과남
for n in 1...N {
    buses[n].sort(by: { $0.cost < $1.cost })
}
var distance = Array(repeating: Int.max, count: N + 1) // 경로당 최소비용, 전부 infinity같은 값으로 해놓고
distance[sourceCity] = 0 // 출발지점만 0
var queue = [sourceCity]
var index = 0
while index < queue.count {
    let currentCity = queue[index]
    let currentCost = distance[currentCity]
    
    for bus in buses[currentCity] { // 갈 수 있는 경로를 확인하면서
        let nextCity = bus.destination
        let nextCost = bus.cost
        if distance[nextCity] > (currentCost + nextCost) { // 더 최소비용인 경로가 있으면 갱신
            distance[nextCity] = currentCost + nextCost
            queue.append(nextCity)
        }
    }
    index += 1
}

print(distance[destinationCity])
