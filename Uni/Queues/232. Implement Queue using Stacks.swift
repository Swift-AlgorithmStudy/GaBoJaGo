class MyQueue {
    var queue: [Int]

    init() {
        queue = []
    }

    func push(_ x: Int) {
        queue.append(x)
    }

    func pop() -> Int {
        defer {
            queue.removeFirst()
        }
        return queue[0]
    }

    func peek() -> Int {
        return queue[0]
    }

    func empty() -> Bool {
        return queue.isEmpty
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