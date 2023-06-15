//배열에 넣고 제거하는 식으로 진행하지 않고, print만 찍는다는 생각하기!
//1. N을 입력받음
//2. 0인 경우, 빈 배열인지 확인하고, 비어있다면 0을 출력
//3. 최대값과 최대값의 인덱스를 찾는다.
//4. 최대값을 0으로 만들어버리고 (최대값을 삭제한 것과 비슷한 효과를 주기 위해), 최대값을 출력
//5. 0이 아니라면 배열에 값을 추가한다.

let N = Int(readLine()!)!
var arr = [Int]()

for _ in 0..<N {
    let x = Int(readLine()!)!
    if x == 0 {
        if arr.count == 0 { print(0) }
        else {
            var max = 0, maxIndex = 0
            for i in 0..<arr.count {
                if max < arr[i] {
                    max = arr[i]
                    maxIndex = i
                }
            }
            arr[maxIndex] = 0
            print(max)
        }
    } else {
        arr.append(x)
    }
}
