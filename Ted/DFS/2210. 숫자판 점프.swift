/***
1. array에 5x5 크기의 값을 입력받는다.
2. 만약 depth가 5라면 값(number)을 insert하고 종료시킨다.
3. depth가 5가 아니라면, 상하좌우를 탐색하면서, 배열의 크기를 벗어나지 않는지 확인한 후(if문), 벗어나지 않는다면 dfs를 재귀로 호출한다.
4. dfs를 호출할 때 *10을 해줌으로 숫자(number)를 만들어준다.
5. for문을 통해 배열을 탐색한다.
6. answers의 개수를 확인한다.(중복된 것은 Set으로 인해 어차피 사라지기 때문에 answers의 개수만 확인하면 된다.)
*/
var array = [[Int]]()
var answers = Set<Int>()
var count = 0

//상하좌우
let dx = [0, 0, -1, 1]
let dy = [-1, 1, 0, 0]

for _ in 0..<5 {
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    array.append(input)
}

func dfs(_ row: Int, _ col: Int, _ depth: Int, _ number: Int) {
    if depth == 5 {
        answers.insert(number)
        return
    }
    
    for i in 0..<4 {
        let nx = row + dx[i]
        let ny = col + dy[i]
        
        if (0..<5).contains(nx) && (0..<5).contains(ny) {
            dfs(nx, ny, depth+1, number * 10 + array[nx][ny])
        }
    }
}

for row in 0..<5 {
    for col in 0..<5 {
        dfs(row, col, 0, array[row][col])
    }
}

print(answers.count)
