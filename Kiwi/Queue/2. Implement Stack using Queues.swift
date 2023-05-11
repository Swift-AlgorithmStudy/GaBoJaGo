//
//  2. Implement Stack using Queues.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/11.
//

class Queue {
    var array = [Int]()
    
    func push(_ x: Int) {
        array.append(x)
    }
    
    func pop() -> Int {
        array.removeFirst()
    }
    
    func peek() -> Int {
        array.first!
    }
    
    func empty() -> Bool {
        array.isEmpty
    }
    
    func count() -> Int {
        array.count
    }
}

class MyStack {
    var queue1 = Queue()
    var queue2 = Queue()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        queue1.push(x)
    }
    
    func pop() -> Int {
        if !queue1.empty() {
            while queue1.count() != 1 {
                queue2.push(queue1.pop())
            }
            return queue1.pop()
        } else {
            while queue2.count() != 1 {
                queue1.push(queue2.pop())
            }
            return queue2.pop()
        }
    }
    
    func top() -> Int {
        if !queue1.empty() {
            while queue1.count() != 1 {
                queue2.push(queue1.pop())
            }
            defer {
                queue2.push(queue1.pop())
            }
            return queue1.peek()
        } else {
            while queue2.count() != 1 {
                queue1.push(queue2.pop())
            }
            defer {
                queue1.push(queue2.pop())
            }
            
            return queue2.peek()
        }
    }
    
    func empty() -> Bool {
        if queue1.empty() && queue2.empty() {
            return true
        }
        return false
    }
}
