/*
 https://www.acmicpc.net/problem/11497
 */
let T = Int(readLine()!)!
for _ in 0..<T {
    // MARK: - 입력
    let N = Int(readLine()!)!
    var log = readLine()!.split(separator: " ").map {Int($0)!}
    
    // MARK: - 정렬
    log.sort()
    
    // MARK: - 지그재그 정렬
    var lowLevelLog = [log.removeLast()]
    var isInsertLastOrder = true /// 앞에 붙일지 뒤에 붙일지
    while !log.isEmpty {
        if isInsertLastOrder {
            lowLevelLog.insert(log.removeLast(), at: lowLevelLog.count)
        } else {lowLevelLog.insert(log.removeLast(), at: 0)
            
        }
        isInsertLastOrder.toggle()
    }
    
    // MARK: - 난이도 측정
    var level = 0
    for index in 0..<N-1 {
        level = max(level, abs(lowLevelLog[index]-lowLevelLog[index+1]))
    }
    print(level)
}
