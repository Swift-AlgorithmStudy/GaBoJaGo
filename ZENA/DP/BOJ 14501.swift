let N = Int(readLine()!)!
var schedule = [(time: Int, price: Int)]()
var maxPrice = Array(repeating: 0, count: N)
for n in 0..<N {
    let input = readLine()!.split(separator: " ").map({ Int($0)! })
    schedule.append((input[0], input[1]))
    maxPrice[n] = n + schedule[n].time > N ? 0 : schedule[n].price
}

for current in 1..<N {
    for prev in 0..<current {
        if current + schedule[current].time > N { continue }
        if current - prev >= schedule[prev].time {
            maxPrice[current] = max(schedule[current].price + maxPrice[prev], maxPrice[current])
        }
    }
}

print(maxPrice.max()!)

/*
 우니, 테드의 조언대로 마지막에 서비스일이 퇴사예정일을 넘어가는지 확인하지 않고 인풋받을 때와 디피 테이블 채워줄 때 처리해주는 것으로 해결했따
 무조건 뒷날짜에 있는 maxPrice값이 클거라고 생각했는데 그렇지 않을 수도 있기 때문이다
 */
/// for n in stride(from: N-1, to: -1, by: -1) {
///    if schedule[n].time + n > N { continue }
///    print(maxPrice[n])
///    break
/// }
