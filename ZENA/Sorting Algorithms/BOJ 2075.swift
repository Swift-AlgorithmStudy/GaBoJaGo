/*
 https://www.acmicpc.net/problem/2075
 
 메모리 149924KB, 시간 372ms, 코드길이 2360B
 N번째 큰 수
 N * N개의 수가 주어지고, 여기서 N번째로 큰 수를 구하는 문제
 N*N개의 숫자를 최대힙에 삽입하고, N-1만큼 remove해준 후 N번째에 remove되는 값을 출력
 */

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


struct Heap {
    var elements = [Int]()
    let sort: (Int, Int) -> Bool
    
    init(elements: [Int] = [Int](),
         sort: @escaping (Int, Int) -> Bool) {
        self.elements = elements
        self.sort = sort
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    mutating func remove() -> Int? {
        guard !isEmpty else { return 0 }
        
        if count == 1 {
            return elements.removeFirst()
        }
        
        elements.swapAt(0, count-1)
        
        defer {
            var index = 0
            while true {
                let left = index * 2 + 1, right = left + 1
                var candidate = index
                if left < count && sort(elements[left], elements[candidate]) {
                    candidate = left
                }
                if right < count && sort(elements[right], elements[candidate]) {
                    candidate = right
                }
                if candidate == index { break }
                elements.swapAt(index, candidate)
                index = candidate
            }
        }
        
        return elements.removeLast()
    }
    
    mutating func insert(_ element: Int) {
        var index = count
        elements.append(element)
        while index > 0 && sort(elements[index], elements[(index - 1) / 2]) {
            elements.swapAt(index, (index - 1) / 2)
            index = (index - 1) / 2
        }
    }
}

let file = FileIO()
let N = file.readInt()
var maxHeap = Heap(sort: >)
for _ in 0..<N * N {
    maxHeap.insert(file.readInt())
}

for _ in 0..<N-1 {
    _ = maxHeap.remove()
}

print(maxHeap.remove()!)
