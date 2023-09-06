import Foundation

final class FileIO {
    @inline(__always) private var buffer: [UInt8] = Array(FileHandle.standardInput.readDataToEndOfFile()) + [0], index = 0

    @inline(__always) private func read() -> UInt8 {
        defer { index += 1 }
        return buffer.withUnsafeBufferPointer { $0[index] }
    }

    @inline(__always) func readInt() -> Int {
        var sum: Int = 0, now = read(), isNegative = false
        while now == 10 || now == 32 { now = read() }
        if now == 45 { isNegative = true; now = read() }
        while 48...57 ~= now { sum = sum * 10 + Int(now - 48); now = read() }
        return sum * (isNegative ? -1 : 1)
    }
}



/*
 https://www.acmicpc.net/problem/1202
 
 메모리 KB, 시간 ms, 코드길이 B
 
 입력
 보석 개수와 가방 개수 (N K)
 (0..<N)
 각 보석 무게와 가격 (M V)
 (0..<K)
 가방 최대 용량(무게, C)
 
 출력
 훔칠 수 있는 보석의 최대 가격
 
 */

let fileIO = FileIO()
let (N, K) = (fileIO.readInt(), fileIO.readInt())
var costOfBags = [Int]()
var maxHeap = Heap<Int>(sort: >)

var jewels = [(mass: Int, value: Int)]()
for _ in 0..<N {
    jewels.append((fileIO.readInt(), fileIO.readInt()))
}
jewels = jewels.sorted { $0.mass < $1.mass }

for _ in 0..<K {
    costOfBags.append(fileIO.readInt())
}


costOfBags = costOfBags.sorted()

var stolenValue = 0
var index = 0

for k in 0..<K {
    while index < N,
          jewels[index].mass <= costOfBags[k] {
        maxHeap.insert(jewels[index].value)
        index += 1
    }
    
    if !maxHeap.isEmpty {
        stolenValue += maxHeap.remove()!
    }
}

print(stolenValue)


struct Heap<Element: Equatable> {

    var elements: [Element] = []
    let sort: (Element, Element) -> Bool

    init(sort: @escaping (Element, Element) -> Bool,
         elements: [Element] = []) {
        self.sort = sort
        self.elements = elements

        if !elements.isEmpty {
            for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
                siftDown(from: i)
            }
        }
    }

    var isEmpty: Bool {
        elements.isEmpty
    }

    var count: Int {
        elements.count
    }

    func leftChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 1
    }

    func rightChildIndex(ofParentAt index: Int) -> Int {
        (2 * index) + 2
    }

    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }

    mutating func remove() -> Element? {
        guard !isEmpty else { // 1
            return nil
        }
        elements.swapAt(0, count - 1) // 2
        defer {
            siftDown(from: 0) // 4
        }
        return elements.removeLast() // 3
    }

    mutating func siftDown(from index: Int) {
        var parent = index // 1
        while true { // 2
            let left = leftChildIndex(ofParentAt: parent) // 3
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent // 4
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left // 5
            }
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right // 6
            }
            if candidate == parent {
                return // 7
            }
            elements.swapAt(parent, candidate) // 8
            parent = candidate
        }
    }

    mutating func insert(_ element: Element) {
        elements.append(element)
        siftUp(from: elements.count - 1)
    }

    mutating func siftUp(from index: Int) {
        var child = index
        var parent = parentIndex(ofChildAt: child)
        while child > 0 && sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(ofChildAt: child)
        }
    }
}
