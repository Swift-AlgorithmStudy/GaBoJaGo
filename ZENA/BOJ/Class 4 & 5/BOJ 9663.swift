/*
 https://www.acmicpc.net/problem/0663
 
 첫 실패: 방문여부를 확인해주지 않아 시간초과 발생
 */

let N = Int(readLine()!)!
var chessBoard = Array(repeating: 0, count: N)
var visited = Array(repeating: false, count: N)
var count = 0

func isPossible(_ currentIndex: Int) ->Bool {
    for index in 0..<currentIndex {
        if chessBoard[currentIndex] == chessBoard[index] ||
           currentIndex - index == abs(chessBoard[currentIndex] - chessBoard[index]) {
            return false
        }
    }
    return true
}

func moveQueen(_ index: Int) {
    if index == N {
        count += 1
        return
    }
    
    for nextPosition in 0..<N {
        if visited[nextPosition] { continue }
        chessBoard[index] = nextPosition
        if isPossible(index) {
            visited[nextPosition] = true
            moveQueen(index + 1)
            visited[nextPosition] = false
        }
    }
}
moveQueen(0)
print (count)
