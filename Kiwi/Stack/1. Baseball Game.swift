//
//  1. Baseball Game.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/04.
//

func calPoints(_ operations: [String]) -> Int {
    return solution(elements: operations)
}

func solution(elements: [String]) -> Int {
    var convertedArray: [Int] = []
    
    for element in elements {
        if let number = Int(element) {
            convertedArray.append(number)
        } else if element == "D" {
            var lastNumber = (convertedArray.last ?? 0) * 2
            convertedArray.append(lastNumber)
        } else if element == "C" {
            convertedArray.popLast()
        } else if element == "+" {
            convertedArray.append((convertedArray.last ?? 0) + convertedArray[convertedArray.count - 2])
        }
    }
    
    return convertedArray.reduce(0) { $0 + $1 }
}

