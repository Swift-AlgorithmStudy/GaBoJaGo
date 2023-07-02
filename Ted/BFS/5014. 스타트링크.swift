/***
1. F,S,G,U,D의 값을 받아온다.
2. 큐에 시작 층(S)을 넣어놓고, visit를 true로 선언한다.
3. 큐 값을 가지고 cur(현재 층)와 cnt(개수)를 선언한다.
4. 만약 현재 층(cur)이 목표 층(G)에 도달하면 cnt를 반환한다.
5. 다음 위치(nx)를 구하기 위해 현재 위치에서 U만큼 위로 올라간 층과 D만큼 아래로 내려간 층의 범위를 살핀다.
6. 다음 위치(nx)가 건물의 층수 내에 있고(1...F), 방문하지 않았다면(!visited) 해당 위치를 방문했다고 표시한 뒤 큐에 추가합니다.
7. 위 식을 반복합니다.
8. 만약 BFS 탐색이 끝날 때까지 목표 지점에 도착하지 못했다면 -1를 반환합니다.
9. 반환된 값을 기준으로 출력합니다.

*/
let input = readLine()!.split(separator: " ").map{ Int($0)! }
var (F,S,G,U,D) = (input[0],input[1],input[2],input[3],input[4])

func bfs() -> Int {
    var queue = [(S,0)]
    var idx = 0

    var visit = Array(repeating: false, count: F+1)
    visit[S] = true

    while queue.count > idx {
        let (cur,cnt) = queue[idx]
        idx += 1
        
        //목표 지점에 도착했으면 cnt를 return
        if cur == G {
            return cnt
        }

        for nx in [cur+U,cur-D] {
            if (1...F).contains(nx) && !visit[nx] {
                visit[nx] = true
                queue.append((nx,cnt+1))
            }
        }
    }
    //Queue가 빌때까지 못찾았으면 -1 return
    return -1
}

let res = bfs()
print(res == -1 ? "use the stairs" : res)
