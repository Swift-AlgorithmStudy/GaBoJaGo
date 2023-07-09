let N = Int(readLine()!)!
var permutation = [Int]()
var results = [String]()

func dfs() {
    if permutation.count == N {
        print(permutation.map({ String($0) }).joined(separator: " "))
        return
    }
    
    for n in 1...N {
        if !permutation.contains(n) {
            permutation.append(n)
            dfs()
            permutation.removeLast()
        }
    }
}

dfs()
