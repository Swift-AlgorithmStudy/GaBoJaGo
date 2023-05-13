class MyStack {

    var leftStack: [Int] = []
    var rightStack: [Int] = []

    init() {}
    
    func push(_ x: Int) {
        rightStack.append(x)
    }
    
    func pop() -> Int {
        
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        } 

        return Int(leftStack.removeFirst())
    }
    
    func top() -> Int {
        !leftStack.isEmpty ? leftStack.first! : rightStack.last!
    }
    
    func empty() -> Bool {
        leftStack.isEmpty && rightStack.isEmpty
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



 /*
 
 ❓ pop() 할 때 꼭 leftStack을 rightStack의 반대로 정의하는 이유
 
 leftStack = rightStack으로 두고
 반환받는 값을 leftStack.removeLast()로 했는데 안됨 



 */