public struct PriorityQueue<T> {
    var nodes: [T] = []
    let comparer: (T,T) -> Bool

    var isEmpty: Bool {
        return nodes.isEmpty
    }
    var count: Int {
        return nodes.count
    }

    init(comparer: @escaping (T,T) -> Bool) {
        self.comparer = comparer
    }

    func peek() -> T? {
        return nodes.first
    }

    mutating func push(_ element: T) {
        var index = nodes.count
        nodes.append(element)
        while index > 0, !comparer(nodes[index],nodes[(index - 1) / 2]) {
            nodes.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }

    mutating func pop() -> T? {
        guard !nodes.isEmpty else {
            return nil
        }

        if nodes.count == 1 {
            return nodes.removeFirst()
        }

        let result = nodes.first
        nodes.swapAt(0, nodes.count-1)
        _ = nodes.popLast()

        var index = 0
        while index < nodes.count {
            let left = index * 2 + 1, right = left + 1

            if right < nodes.count {
                if comparer(nodes[left], nodes[right]), !comparer(nodes[right], nodes[index]) {
                    nodes.swapAt(right, index)
                    index = right
                } else if !comparer(nodes[left], nodes[index]){
                    nodes.swapAt(left, index)
                    index = left
                } else {
                    break
                }
            } else if left < nodes.count {
                if !comparer(nodes[left], nodes[index]) {
                    nodes.swapAt(left, index)
                    index = left
                } else {
                    break
                }
            } else {
                break
            }
        }
        return result
    }
}

extension PriorityQueue where T: Comparable {
    init() {
        self.init(comparer: <)
    }
}

struct Data {
    var score: Int
    var index: Int
    
    init(_ score: Int, _ index: Int) {
        self.score = score
        self.index = index
    }
}

extension Data: Comparable {
    static func < (lhs: Data, rhs: Data) -> Bool {
        if lhs.score == rhs.score {
            return lhs.index < rhs.index
        }
        return lhs.score < rhs.score
    }
}

class Solution {
    func kWeakestRows(_ mat: [[Int]], _ k: Int) -> [Int] {
        var pq = PriorityQueue<Data>(comparer: >)
        for (i, row) in mat.enumerated() {
            let sum = row.reduce(0, +)
            pq.push(Data(sum, i))
        }
        var result = [Int]()
        for _ in 0..<k {
            let row = pq.pop()!
            result.append(row.index)
        }
        return result
    }
}