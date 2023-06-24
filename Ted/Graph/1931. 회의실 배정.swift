/***
전략 : 끝나는 시간을 기준으로 정렬하고, 가장 빨리 끝나는 것을 기준으로 시작 시간이 끝나는 시간보다 늦게 있다면 그 값을 추가하는 형식
1. 모든 input을 입력받는다.
2. 끝나는 시간을 기준으로 오름차순으로 정렬시킨다.
3. 만약 끝나는 시간(endTime)이 같은 것이 있다면 시작 시간을 기준으로 오름차순으로 정렬한다.
4. count는 1부터 시작하고(첫 번째 endTime은 무조건 count를 해야하는 것이기 때문에), 인덱스 1을 기준으로 for문을 진행한다. (첫 번째 것을 제외하고 시작)
5. 시작 시간이 끝나는 시간보다 크거나 같으면, 시작 시간의 끝나는 시간을 endTime으로 지정하고, count +=1을 해준다.
   (시작 시간이 끝나는 시간보다 크면 해당하는 값을 바로 사용할 수 있다.
    endTime을 기준으로 정렬되어 있기 때문에 시작 시간에 대한 조건만 만족한다면 바로 endTime으로 지정할 수 있음)
*/

let N = Int(readLine()!)!
var room = [(Int, Int)]()
var count = 1

for _ in 0..<N {
    let time = readLine()!.split(separator: " ").map { Int($0)! }
    room.append((time[0], time[1]))
}

//endTime 기준으로 정렬시키고 만약 값이 같다면 시작 시간을 기준으로 정렬
room.sort {
    if $0.1 == $1.1 {
        return $0.0 < $1.0
    }
    return $0.1 < $1.1
}


var endTime = room[0].1

for i in 1...N-1 {
    if room[i].0 >= endTime {
        endTime = room[i].1
        count += 1
    }
}

print(count)
