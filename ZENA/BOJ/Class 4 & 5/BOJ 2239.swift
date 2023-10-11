/*
 https://www.acmicpc.net/problem/2239
 */

import Foundation
var sudoku = [[Int]]()
var blank = [(row: Int, col: Int)]()
for row in 0..<9 {
    sudoku.append(Array(readLine()!).map{Int(String($0))!})
    for col in 0..<9 {
        if sudoku[row][col] == 0 {
            blank.append((row, col))
        }
    }
}

func followRule(row: Int, col: Int, target: Int) -> Bool {
    let rowFrom = row / 3 * 3
    let colFrom = col / 3 * 3
    
    // 1. 같은 영역(3*3)에 동일 숫자가 없어야 함
    for areaRow in rowFrom...rowFrom+2 {
        for areaCol in colFrom...colFrom+2 {
            if sudoku[areaRow][areaCol] == target {
                return false
            }
        }
    }
    
    // 2. 같은 가로줄에 동일 숫자가 없어야 함
    return !sudoku[row].contains(target)
    // 3. 같은 세로줄에 동일 숫자가 없어야 함
    && !sudoku.map { $0[col] }.contains(target)
}

func backtracking(index: Int) {
    if index == blank.count {
        print(sudoku.map{$0.map{String($0)}.joined()}.joined(separator: "\n"))
        exit(0)
    }
    
    let (row, col) = (blank[index].row, blank[index].col)
    for target in 1...9 {
        if followRule(row: row, col: col, target: target) {
            sudoku[row][col] = target
            backtracking(index: index + 1)
            sudoku[row][col] = 0
        }
    }
    return
}

backtracking(index: 0)
