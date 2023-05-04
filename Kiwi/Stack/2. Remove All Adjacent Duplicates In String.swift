//
//  2. Remove All Adjacent Duplicates In String.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/04.
//

func removeDuplicates(_ s: String) -> String {
    var result = ""
    
    for i in s {
        if result.last != i {
            result.append(i)
        } else {
            result.popLast()
        }
    }
    
    return result
}
