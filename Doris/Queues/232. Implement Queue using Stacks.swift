class MyQueue {

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
        
        return Int(leftStack.popLast()!)
    }
    
    func peek() -> Int {
        !leftStack.isEmpty ? leftStack.last! : rightStack.first!
    }
    
    func empty() -> Bool {
        leftStack.isEmpty && rightStack.isEmpty
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

 /*

 ❗️ 왜 냐 면 ❗️
 Stack에는 removeLast() 메서드가 없으니깐 ! 
 대신에 popLast() 써야됨

⭐️ Swift에서 Stack 자료구조는 일반적으로 배열(Array)을 이용하여 구현되는데
Stack에서 원소를 제거할 때, 배열의 popLast() 메소드를 사용하여 구현함 ⭐️
 */