/*
 https://www.acmicpc.net/problem/19539
 */

let n = Int(readLine()!)!
let trees = readLine()!.split(separator: " ").map{Int($0)!}
let sumOfTrees = trees.reduce(0, +)

if  sumOfTrees % 3 == 0 {
    if trees.map({$0 / 2}).reduce(0, +) >= sumOfTrees / 3 {
        print("YES")
    } else {
        print("NO")
    }
} else {
    print("NO")
}

/*
 1 또는 2씩
 3씩
 
 1. 나무의 총합이 3의 배수가 아니면 NO
 2. 3의 배수라면
 2-1. 2씩 (전체 나무 높이의 합 / 3)번 이상 물을 줘서 키울 수 있다
 === 전체 나무 높이의 합 / 3 = 물뿌리개 사용 횟수 = 2를 사용해야 하는 횟수
 */
