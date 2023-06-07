
/*
 https://leetcode.com/problems/kth-largest-element-in-a-stream/?envType=list&envId=ren7fpc7
 엄청나게 애먹은 문제
 k값과 초기 elements 배열이 주어지고 그 다음에 주어지는 숫자를 힙에 하나씩 insert하는데, 이때 insert할 때마다 k번째로 큰 숫자를 반환하는 문제
 123ms
 일단 힙이 배열을 이용한다고 해서 트리 구조로 정렬되는 것이 아니라 배열 순서대로 정렬될 것이라 잘못 생각했었다
 그리고 k라는 위치의 값을 힙에서 어떻게 뽑아내는거지에 대한 고민때문에 엄청 애먹은 문젠데, 해결방법은 의외로 간단하다. 힙의 elements 배열의 크기를 k로 고정한다. 처음 힙을 생성할 때는 그 elements의 크기가 k보다 작을 수 있으므로 min(elements.count, k)로 크기를 설정해야 한다.
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

class KthLargest {

    var k: Int
    var heap: Heap<Int>

    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        self.heap = Heap(sort: <, elements: Array(nums.sorted(by: >)[..<min(k, nums.count)]))
    }
    
    func add(_ val: Int) -> Int {
        heap.insert(val)
        if heap.count > k {
            _ = heap.remove()
        }
        return heap.peek()!
    }
}
