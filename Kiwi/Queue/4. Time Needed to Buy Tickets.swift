//
//  4. Time Needed to Buy Tickets.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/11.
//

func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var ticket: [Int] = tickets
        var count: Int = 0
        
        while true {
            for i in 0 ..< ticket.count {
                if ticket[i] > 0 {
                    ticket[i] -= 1
                    count += 1
                }
                if ticket[k] == 0 {
                    return count
                }
            }
        }
    }
