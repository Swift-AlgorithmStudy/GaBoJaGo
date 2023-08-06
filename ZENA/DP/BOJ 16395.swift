let input = readLine()!.split(separator: " ").map{Int($0)!}
let (n, k) = (input[0], input[1])

var pascal = Array(repeating: [Int](), count: n)
for row in 0..<n {
    for col in 0..<row+1 {
        if col == row || col == 0 {
            pascal[row].append(1)
        } else {
            pascal[row].append(pascal[row-1][col-1] + pascal[row-1][col])
        }
    }
}

print(pascal[n-1][k-1])
