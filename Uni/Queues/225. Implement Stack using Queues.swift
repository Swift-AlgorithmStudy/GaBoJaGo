class MyStack {
    var stack: [Int]

    init() {
        stack = []
    }

    func push(_ x: Int) {
        stack.append(x)
    }

    func pop() -> Int {
        defer {
            stack.removeLast()
        }
        return stack.last!
    }

    func top() -> Int {
        return stack.last!
    }

    func empty() -> Bool {
        return stack.isEmpty
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