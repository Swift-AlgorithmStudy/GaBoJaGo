//
//  1.  Implement Queue using Stacks.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/11.
//

class Stack {
    var array = [Int]()
    
    func push(_ x: Int) {
        array.append(x)
    }
    
    func pop() -> Int {
        array.removeFirst()
    }
    
    func peek() -> Int {
        array[0]
    }
    
    func empty() -> Bool {
        array.isEmpty
    }
}

class MyQueue {
    var stack1 = Stack()
    var stack2 = Stack()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        if stack2.empty() {
            stack1.push(x)
        } else {
            while !stack2.empty() {
                stack1.push(stack2.pop())
            }
            stack1.push(x)
        }
    }
    
    func pop() -> Int {
        if stack1.empty() {
            return stack2.pop()
        } else {
            while !stack1.empty() {
                stack2.push(stack1.pop())
            }
            return stack2.pop()
        }
    }
    
    func peek() -> Int {
        if stack2.empty() {
            
            return stack1.peek()
        } else {
            while !stack2.empty() {
                stack1.push(stack2.pop())
            }
            return stack1.peek()
        }
    }
    
    func empty() -> Bool {
        if stack1.empty() && stack2.empty() {
            return true
        } else  {
            return false
        }
    }
}
