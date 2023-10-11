/*
 https://www.acmicpc.net/problem/15686
 */
let input = readLine()!.split(separator: " ").map { Int($0)! }
let (N, M) = (input[0], input[1])

/*
 0: blank
 1: house (최소 1개, 최대 2N개)
 2: chicken (M <= chicken < 13)
 */

var roadmap = [[Int]]()
var housePosition = [(x: Int, y: Int)]()
var chickenPosition = [(x: Int, y: Int)]()
for row in 0..<N {
    roadmap.append(readLine()!.split(separator: " ").map { Int($0)! })
    for column in 0..<roadmap[row].count {
        if roadmap[row][column] == 0 { continue }
        roadmap[row][column] == 1 ?
        housePosition.append((row, column))
        : chickenPosition.append((row, column))
    }
}

var closed = Array(repeating: false, count: chickenPosition.count)
var minimumDistance = getMinimumDistance()
backtracking(0, 1)

func getMinimumDistance() -> Int {
    var distance = Array(repeating: Int.max, count: housePosition.count)
    if closed.filter({!$0}).count > M { return Int.max }
    
    for house in 0..<housePosition.count {
        let currentHousePosition = housePosition[house]
        for chicken in 0..<chickenPosition.count {
            
            if closed[chicken] { continue }
            let currentChickenPosition = chickenPosition[chicken]
            distance[house] = min(
                distance[house],
                abs(currentHousePosition.x - currentChickenPosition.x)
                + abs(currentHousePosition.y - currentChickenPosition.y)
            )
        }
    }
    return distance.reduce(0, +)
}

func backtracking(_ selectedIndex: Int, _ closedCount: Int) {
    if closedCount > chickenPosition.count - M {
        minimumDistance = min(minimumDistance, getMinimumDistance())
        return
    }
    
    for index in selectedIndex..<chickenPosition.count {
        if !closed[index] {
            closed[index] = true
            backtracking(index, closedCount + 1)
            closed[index] = false
        }
    }
}

print(minimumDistance)
