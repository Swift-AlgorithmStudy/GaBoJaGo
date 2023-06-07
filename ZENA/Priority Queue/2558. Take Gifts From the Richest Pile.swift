/*
 https://leetcode.com/problems/take-gifts-from-the-richest-pile/description/?envType=list&envId=ren7fpc7
 19ms
 배열과 정수 k가 주어지는데, k만큼 배열의 값을 뽑는다. 뽑은 배열의 값은 제곱근값으로 대치되는데 k번 이후 현재 배열 요소들의 합이 얼마인지 반환하는 문제.
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
            if candidate == parent { return }
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

    mutating func remove() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0)
        }
        return elements.removeLast()
    }
}

class Solution {
    func pickGifts(_ gifts: [Int], _ k: Int) -> Int {
        var heap = Heap(sort: >, elements: gifts)
        for _ in 0..<k {
            heap.insert(Int(sqrt(Double(heap.remove()!))))
        }
        return heap.elements.reduce(0,+)
    }
}
