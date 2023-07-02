/***
1. 큐를 생성한다.
2. 수빈이 위치를 큐에 추가한다.
3. visited(방문 여부 확인)와 depth(초를 구하기 위함)를 생성한다.
4. 큐 안에 있는 값(data)을 제거한다.
5. 만약 제거되는 값이 동생이 있는 위치라면(K), while문을 종료한다.
6. 제거한 값(data)을 기준으로 1)X-1, 2)X+1, 3)2*X 값을 추가한다. (하지만 visited가 된 값은 추가하지 않는다.)
7. 큐에 추가하면서 visited를 true로 변경하고 depth를 +1한다.
8. while문이 종료될 때는 depth 배열에 있는 K인덱스에 있는 값을 반환해준다.
*/

struct Queue {
    var que: [Int] = []
    mutating func push(_ x: Int) {
        que.append(x)
    }
    mutating func pop() -> Int {
        que.reverse()
        if let a = que.popLast() {
            que.reverse()
            return a
        }
        return 0
    }
    func empty() -> Bool {
        return que.isEmpty
    }
    func size() -> Int {
        return que.count
    }
}

func bfs(_ N: Int, _ K: Int) -> Int {
    var queue = Queue()
    queue.push(N)

    var visited: [Bool] = Array(repeating: false, count: 100002)
    var depth: [Int] = Array(repeating: 0, count: 100002)

    while !queue.empty() {
        let data = queue.pop()
        if data == K {
            break
        }
        if data > 0 && !visited[data - 1] {
            queue.push(data - 1)
            visited[data - 1] = true
            depth[data - 1] = depth[data] + 1
        }
        if data < 100000 && !visited[data + 1] {
            queue.push(data + 1)
            visited[data + 1] = true
            depth[data + 1] = depth[data] + 1
        }
        if data * 2 < 100001 && !visited[2 * data] {
            queue.push(2 * data)
            visited[2 * data] = true
            depth[2 * data] = depth[data] + 1
        }
    }

    return depth[K]
}

let input = readLine()!.split(separator: " ").map { Int($0)! }
let (N, K) = (input[0], input[1])
let result = bfs(N, K)
print(result)
