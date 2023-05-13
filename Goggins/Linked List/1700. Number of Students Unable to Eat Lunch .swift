//
//  1700. Number of Students Unable to Eat Lunch .swift
//  Swift Algorithm
//
//  Created by David Goggins on 2023/05/12.
//
// 점심을 먹지 못하는 학생의 수
import Foundation // 이해 더 필요

class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var ctrs: [Int] = [0, 0] // [first, second] / first = 0의 개수, second = 1 개수
        // count zeros and ones in students
        ctrs[1] = students.reduce(0, +) // reduce로 배열의 모든 원소의 값 더하기
        ctrs[0] = students.count - ctrs[1] // 0 의 개수는 모든 개수에서 모든 원소의 값을 뺴면 나오게 됩니다. ex/ 5개중에 1이 2개 있다면, 5 - 2 = 3 == 0의개수
        // go over the sandwiches queue
        for s in sandwiches { // 모든 샌드위치 탐색하면서,
            if ctrs[s] == 0 { // s 번째 인덱스가 0 이라면 멈추고 / 아니라면
                break  // stop if there is no student of the kind left
            }
            ctrs[s] -= 1  // decrement number of students of the kind
        }
        // return number of students left
        return Int(max(ctrs[0], ctrs[1]))
    }
}

//주어진 두 개의 배열 "students"와 "sandwiches"를 사용하여 "sandwiches"의 순서대로 학생들이 샌드위치를 먹는 시뮬레이션을 수행하고, 마지막으로 먹지 못한 학생의 수를 반환하는 함수 "countStudents"를 구현합니다.
//
//우선, 변수 "ctrs"를 생성하고, 이 변수에는 0과 1의 개수를 저장할 것입니다. "students" 배열에서 1의 개수를 "reduce" 함수를 사용하여 구하고, 이를 "ctrs[1]"에 저장합니다. "ctrs[0]"에는 전체 학생 수에서 1의 개수를 뺀 나머지 0의 개수를 저장합니다.
//
//그 다음, "sandwiches" 배열에서 순서대로 반복문을 수행합니다. 만약 현재 샌드위치 종류에 해당하는 학생이 더 이상 남아있지 않다면 반복문을 중지하고, 그렇지 않으면 해당 샌드위치 종류에 해당하는 학생 수 "ctrs[s]"에서 1을 빼줍니다.
//
//마지막으로, "ctrs[0]"과 "ctrs[1]" 중 더 큰 값을 반환하여 마지막으로 먹지 못한 학생의 수를 반환합니다.
