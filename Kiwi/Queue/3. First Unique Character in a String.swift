//
//  3. First Unique Character in a String.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/11.
//

func firstUniqChar(_ s: String) -> Int {
    var array: [String] = []
    var result: [String] = []
    var index = 0
    
    for i in s {
        array.append(String(i))
    }
    
    for i in array {
        array.remove(at: index)
        result = array
        
        if result.contains(i) {
            array.insert(i, at: index)
            index += 1
            continue
        } else {
            return index
        }
    }
    
    if index == array.count {
        return -1
    }
    
    return index
}
