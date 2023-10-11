/*
 https://www.acmicpc.net/problem/15663
 */

let input = readLine()!.split(separator: " ").map{Int($0)!}
let (N, M) = (input[0], input[1])
var numbers = readLine()!.split(separator: " ").map{Int($0)!}.sorted()

var visited = Array(repeating: false, count: N)
var sequence = Array(repeating: 0, count: N)

func backTracking(count: Int) {
    if count == M {
        for m in 0..<M {
            print(numbers[sequence[m]], terminator: " ")
        }
        print()
        return
    }
    var before = 0
    for n in 0..<N {
        if !visited[n],
           before != numbers[n] { // 중복 예외 처리
            sequence[count] = n
            before = numbers[n]
            visited[n] = true
            backTracking(count: count + 1)
            visited[n] = false
        }
    }
}

backTracking(count: 0)
