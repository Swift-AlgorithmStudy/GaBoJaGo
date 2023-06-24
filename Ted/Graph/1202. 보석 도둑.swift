/***
전략 : 가방은 오름차순, 보석 무게도 오름차순으로 시작하고, 큐에서는 보석의 가격으로 정렬
1. 보석과 가방을 저장한다.
2. 보석과 가방을 오름차순으로 정렬한다. 보석은 무게 순으로 오름차순 정렬한다.
3. 큐에서는 보석의 가격을 기준으로 내림차순 정렬함
4. 가방을 순회하며 가방에 들어갈 수 있는 모든 보석을 큐에 넣는다.
   가방에 들어갈 수 있는 보석은 인덱스가 보석의 개수보다 작거나 bag보다 값이 작은 것들이 들어갈 수 있다.
5. 만약 큐가 비어있지 않다면, 큐를 pop하면서 값을 더해준다.
6. 값을 기준으로 정렬되어 있기 때문에 pop된 값이 가장 큰 값들이다.
*/

let NK = readLine()!.split(separator: " ").map { Int($0)! }
let N = NK[0]
let K = NK[1]
var jewel = [(Int, Int)]()
var bags = [Int]()
var result = 0

for _ in 0..<N {
    let info = readLine()!.split(separator: " ").map { Int($0)! }
    jewel.append((info[0], info[1]))
}
jewel.sort { $0.0 < $1.0 }

for _ in 0..<K {
    bags.append(Int(readLine()!)!)
}
bags.sort { $0 < $1 }

var queue = PQ<(Int, Int)>(sort: {$0.1 > $1.1})
var index = 0

for bag in bags {
    while index < jewel.count && jewel[index].0 <= bag {
        queue.push(jewel[index])
        index += 1
    }
    
    if !queue.isEmpty() {
        result += queue.pop()!.1
    }
}

print(result)



// 우선순위큐 구조체
public struct PQ<T> {
    private var arr: [T] = []
    let order: (T, T) -> Bool

    init(sort: @escaping (T, T) -> Bool) {
        self.order = sort
    }

    func isEmpty() -> Bool {
        return arr.isEmpty
    }

    mutating func push(_ element: T) {
        arr.append(element)
        bottomUp()
    }

    mutating func pop() -> T? {
        if arr.isEmpty {
            return nil
        }
        arr.swapAt(0, arr.count - 1)
        let last = arr.removeLast()

        topDown()

        return last
    }

    mutating func bottomUp() {
        var index = arr.count - 1
        while index > 0 {
            let next = (index - 1) / 2
            if !order(arr[index], arr[next]) {
                break
            }

            arr.swapAt(index, next)
            index = next
        }
    }

    mutating func topDown() {
        if arr.count <= 1 {
            return
        }

        var index = 0

        while 2 * index + 1 < arr.count {
            var next = 2 * index + 1

            if next < arr.count - 1 && order(arr[next + 1], arr[next]) {
                next = next + 1
            }

            if !order(arr[next], arr[index]) {
                break
            }

            arr.swapAt(index, next)
            index = next
        }
    }
}
