/***
1. 값들을 입력받는다.
2. 연결된 값들을 추가하고, 오름차순으로 정렬한다.
3. 시작점(start)으로 시작하여 배열을 순환하면서 만약 방문하지 않은 곳이 있다면 dfs로 방문하고, count += 1을 해준다.
*/

let computerCount = Int(readLine()!)!
let pairs = Int(readLine()!)!
var networks: [[Int]] = Array(repeating: [], count: computerCount + 1)
var visited = Array(repeating: false, count: computerCount + 1)
var count = -1
let start = 1

for _ in 0..<pairs{
    let pair = readLine()!.split(separator: " ").map { Int($0)! }
    let (a, b) = (pair[0], pair[1])
    
    networks[a].append(b)
    networks[b].append(a)
    networks[a].sort()
    networks[b].sort()

}

func dfs(_ start: Int){
    visited[start] = true
    count += 1
    for i in networks[start] {
        if !visited[i] {
            dfs(i)
        }
    }
}

dfs(start)
print(count)
