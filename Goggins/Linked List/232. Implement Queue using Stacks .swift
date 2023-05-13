//
//  232. Implement Queue using Stacks .swift
//  Swift Algorithm
//
//  Created by David Goggins on 2023/05/12.
//

import Foundation

class MyQueue {
    
    private var queue: [Int] //private?
    
    init() {
        self.queue = []
    }
    
    func push(_ x: Int) {
        queue.append(x)
    }
    
    func pop() -> Int {
        return queue.removeFirst()
    }
    
    func peek() -> Int {
        return queue.first ?? 0
    }
// peek()은 큐(queue)의 맨 앞 요소를 반환하는 함수
// 먼저, "queue.first"로 큐의 맨 앞 요소에 접근합니다. 이 때, 만약 큐가 비어있으면 nil이 반환됩니다. 이를 방지하기 위해 nil 대신 0을 반환하도록 ?? 연산자를 사용
// 따라서, 이 함수는 큐가 비어있지 않을 때, 큐의 맨 앞 요소를 반환하며, 비어있을 때는 0을 반환합니다. 반환되는 값은 Int 타입
    
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
