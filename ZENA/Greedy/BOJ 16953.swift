/*
 https://www.acmicpc.net/problem/16953
 */
import Foundation
let input = readLine()!.split(separator: " ").map{Int($0)!}
var (A, B) = (input[0], input[1])
var queue = [(value: A, depth: 1)]

while !queue.isEmpty {
    let next = queue.removeFirst()
    if next.value == B {
        print(next.depth)
        exit(0)
    }
    if next.value * 2 <= B {
        queue.append((next.value * 2, next.depth + 1))
    }
    if next.value * 10 + 1 <= B {
        queue.append((next.value * 10 + 1, next.depth + 1))
    }
    
    print(queue)
}

print(-1)
