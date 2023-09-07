/*
 https://www.acmicpc.net/problem/22945
 */

import Foundation
let N = Int(readLine()!)!
var maxAbility = 0
// 두명이면 사이에 존재하는 개발자 수가 0이므로
if N == 2 {
    print(maxAbility)
    exit(0)
}
let ability = readLine()!.split(separator: " ").map{Int($0)!}
var low = 0, high = N - 1

while low < high {
    let currentAbility = (high - low - 1) * min(ability[low], ability[high])
    maxAbility = max(maxAbility, currentAbility)
    
    if ability[low] < ability[high] {
        low += 1
    } else {
        high -= 1
    }
}

print(maxAbility)
