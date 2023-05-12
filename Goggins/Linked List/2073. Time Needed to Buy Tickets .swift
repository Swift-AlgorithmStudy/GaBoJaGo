//
//  File.swift
//  Swift Algorithm
//
//  Created by David Goggins on 2023/05/12.
//

import Foundation

class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        
        var n = tickets.count
        var tickets = tickets
        var counter = 0
        var incrementer = 0
        var queue = Queue<Int>()
        
        //주어진 티켓 목록을 사용하여 k번째 사람이 티켓을 살 때까지 걸리는 시간을 계산하는 함수를 구현

        


        
        
        while(tickets.count>0){ //첫 번째 루프에서는 tickets 배열의 모든 요소를 queue라는 큐에 추가하며, 이 때 큐에 추가된 요소는 dequeue() 메서드를 사용하여 제거
            queue.enqueue(value:tickets.removeFirst())
        }
        
        while(!queue.isEmpty){ // 두 번째 루프에서 queue에서 요소를 하나씩 꺼내어(dequeue()) temp라는 변수에 할당합니다. temp가 0보다 큰 경우, incrementer 변수를 1씩 증가시킵니다. counter 변수는 항상 1씩 증가합니다. temp에서 1을 뺀 값을 다시 queue에 추가합니다(enqueue()).
            
            var temp = queue.dequeue()
            if(temp! > 0){
                incrementer += 1
            }
            counter += 1
            temp! -= 1
            
            // 마지막으로, counter가 n의 배수가 되면, temp가 0인 경우(if (temp == 0)) 반복문을 중단합니다. 그리고 incrementer를 반환합니다.

            if(((counter-1)%n)==k){
                if(temp == 0){
                    break
                }
            }
            
            queue.enqueue(value: temp!)
            
            
        }
        //클래스 Queue는 Swift에서 제공하는 제네릭 타입을 사용하여 정의된 큐 자료구조의 구현입니다. 큐의 구현은 내부적으로 배열을 사용하며, enqueue() 메서드를 사용하여 값을 큐에 추가하고 dequeue() 메서드를 사용하여 값을 큐에서 삭제합니다. peek와 isEmpty 메서드는 각각 큐의 첫 번째 요소를 반환하고, 큐가 비어있는지 여부를 확인합니다.
        
        return incrementer
    }
}

class Queue<Element> {
    
    var val = [Element]()
    
    var peek : Element? {
        return val.first
    }
    
    var isEmpty : Bool {
        return val.count > 0 ? false : true
    }
    
    func enqueue(value:Element) -> Bool {
        val.append(value)
        return true
    }
    
    func dequeue() -> Element? {
        return isEmpty ? nil : val.removeFirst()
    }
    
}
