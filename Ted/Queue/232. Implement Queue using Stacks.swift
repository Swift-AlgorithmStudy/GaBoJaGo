class MyQueue {

    var queue: [Int]
    var tmpQueue: [Int]
    
    init() {
        queue = [Int]()
        tmpQueue = [Int]()
    }
    
    func push(_ x: Int) {
        queue.append(x)
    }
    
    func pop() -> Int {
        return queue.isEmpty ? -1 : queue.removeFirst()
    }
    
    func peek() -> Int {

        return queue.isEmpty ? -1 : queue[0]
    }
    
    func empty() -> Bool {
        return queue.isEmpty ? true : false
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */
