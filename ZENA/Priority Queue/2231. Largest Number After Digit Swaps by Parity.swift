/*
 https://leetcode.com/problems/largest-number-after-digit-swaps-by-parity/description/?envType=list&envId=ren7fpc7
 3ms
 같은 parity이고, 두 숫자를 swap해서 가장 큰 숫자를 반환하는 문제
 사실 내가 안풀었다 ... 베낀건데 이해도 안됨 ..... 스터디 전에 다시 확인해보기
 */

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
    
    func peek() -> Element? {
        elements.first
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
        guard !isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
    
    mutating func remove(at index: Int) -> Element? {
        guard index < elements.count else { return nil }
        if index == elements.count - 1 {
            return elements.removeLast()
        } else {
            elements.swapAt(index, elements.count - 1)
            defer {
                siftDown(from: index)
                siftUp(from: index)
            }
            return elements.removeLast()
        }
    }
    
    mutating func siftDown(from index: Int) {
        var parent = index
        while true {
            let left = leftChildIndex(ofParentAt: parent)
            let right = rightChildIndex(ofParentAt: parent)
            var candidate = parent
            if left < count && sort(elements[left], elements[candidate]) {
                candidate = left
            }
            if right < count && sort(elements[right], elements[candidate]) {
                candidate = right
            }
            if candidate == parent {
                return
            }
            elements.swapAt(parent, candidate)
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
    
    func index(of element: Element, startingAt i: Int) -> Int? {
        if i >= count {
            return nil
        }
        if sort(element, elements[i]) {
            return nil
        }
        if element == elements[i] {
            return i
        }
        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
            return j
        }
        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
            return j
        }
        return nil
    }
}

class Solution {
    func largestInteger(_ num: Int) -> Int {
        var numToArray = Array("\(num)").map { Int(String($0))! }
        var evenHeap = Heap<Int>(sort: >)
        var oddHeap = Heap<Int>(sort: >)

        for element in numToArray {
            if Int(element) % 2 == 0 {
                evenHeap.insert(element)
            } else {
                oddHeap.insert(element)
            }
        }

        var result = ""
        var index = 0
        while (!evenHeap.isEmpty || !oddHeap.isEmpty) && index < numToArray.count {
            if numToArray[index] % 2 == 0 {
                if let removed = evenHeap.remove() {
                    result += "\(removed)"
                }
            } else {
                if let removed = oddHeap.remove() {
                    result += "\(removed)"
                }
            }
            index += 1
        }
        return Int(result)!
    }
}

