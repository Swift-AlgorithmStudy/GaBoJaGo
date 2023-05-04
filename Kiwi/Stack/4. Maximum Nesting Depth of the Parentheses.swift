//
//  4. Maximum Nesting Depth of the Parentheses.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/04.
//

func maxDepth(_ s: String) -> Int {
    var result = 0
    var result2 = 0
    
    for i in s {
        if i == "(" {
            result += 1
        } else if i == ")" {
           
            if result > result2 {
                result2 = result
            }
            result -= 1
        }
    }
    
    return result2
}
