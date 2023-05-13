//
//  225. Implement Stack using Queues.swift
//  Swift Algorithm
//
//  Created by David Goggins on 2023/05/12.
//

import Foundation

class MyStack {
    var myArray = [Int]()
    
    func push(_ x: Int) {
        myArray.append(x)
    }
    
    func pop() -> Int {
        }
    
    func top() -> Int {
        myArray.last()
    }
    
    func empty() -> Bool {
        myArray == []

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
