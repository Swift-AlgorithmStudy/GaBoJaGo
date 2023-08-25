/***
1. permutation 함수에 current 배열을 선언하면서 시작한다.
2. current 배열의 길이가 n과 같아진다면 모든 요소를 프린트 한다.
3-1. 아니라면 배열을 순환한다.
3-2. 만약 방문하지 않았다면 true로 변경하고 current에서 추가로 array[i]를 추가한 배열을 가지고 permutation을 진행한다.
3-3. 방문 표시를 false로 변경하여 array[i]가 다른 순열에서 다시 사용될 수 있도록 한다.
*/

let N = Int(readLine()!)!
var numbers = Array(1...N)

func permutation<T>(array: [T], n: Int) {
    
    var visited = [Bool](repeating: false, count: array.count)
    
    func permutation(current: [T]) {
        if current.count == n {

            for i in 0..<n {
                print(current[i], terminator: " ")
            }
            print()
            return
        }
        
        for i in 0..<array.count {
            if !visited[i] {
                visited[i] = true
                permutation(current: current + [array[i]])
                visited[i] = false
            }
        }
    }
    permutation(current: [])
}

permutation(array: numbers, n: N)
