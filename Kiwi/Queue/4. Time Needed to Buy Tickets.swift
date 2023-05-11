//
//  4. Time Needed to Buy Tickets.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/11.
//

func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
    tickets.enumerated().reduce(0) { $0 + min(tickets[k], $1.1) + ($1.1 >= tickets[k] && $1.0 > k ? -1 : 0) }
}
