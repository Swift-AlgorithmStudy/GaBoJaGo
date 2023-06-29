/***
 1. input들 받기
 2. 2차원 배열을 생성하여, 만약 좌표처럼 만든다.
 3. 순회하며 만약 1이라면(그림이 그려져있다면), bfs를 통해 width를 반환하며 count를 늘려준다.
 4. width와 maxWidth를 비교하여 최대값을 찾는다.
 
 */
let nm = readLine()!.split(separator: " ").map { Int($0)! }
let n = nm[0]
let m = nm[1]
var papers = [[Int]]()
var count = 0
var maxWidth = 0

//상하좌우 탐색
let dx = [0, 0, 1, -1]
let dy = [1, -1, 0, 0]

for _ in 0..<n {
    papers.append(readLine()!.split(separator: " ").map { Int($0)! })
}

for i in 0..<n {
    for j in 0..<m {
        if papers[i][j] == 1 {
            let width = bfs(i, j)
            count += 1
            maxWidth = max(maxWidth, width)
        }
    }
}

private func bfs(_ sx: Int, _ sy: Int) -> Int {
    var width = 1
    papers[sx][sy] = 0  //시작 좌표를 0으로 초기화함 -> 방문한 영역을 중복해서 탐색하지 않기 위함
    
    var index = 0
    var queue = [(sx, sy)]
    
    while queue.count > index { //큐가 비어있지 않는 동안 반복함
        let (cx, cy) = queue[index]     //현재 위치(좌표)를 가져옴
        index += 1
        
        for i in 0..<4 {    //상하좌우 확인
            let nx = cx + dx[i]
            let ny = cy + dy[i]
            
            if (0..<n) ~= nx && (0..<m) ~= ny && papers[nx][ny] == 1 {  //(nx, ny)가 배열의 유효한 범위 내에 있고, 해당 위치가 1로 표시되었을 때
                papers[nx][ny] = 0  //0으로 초기화
                queue.append((nx, ny))  //큐에 추가 (index를 가지고 불러옴)
                width += 1  //상하좌우에 있는 것이기 때문에 width 추가
            }
        }
    }
    return width
}

print(count)
print(maxWidth)
