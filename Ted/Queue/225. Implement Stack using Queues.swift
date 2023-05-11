class MyStack {

    var queue: [Int]
    
    init() {
        queue = [Int]()
    }
    
    func push(_ x: Int) {
        queue.append(x)
    }
    
    func pop() -> Int {
        return queue.isEmpty ? -1 : queue.removeLast()
    }
    
    func top() -> Int {
        return queue.isEmpty ? -1 : queue.last!
    }
    
    func empty() -> Bool {
        return queue.isEmpty
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * let obj = MyStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Bool = obj.empty()
 */
