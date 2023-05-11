class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {

        var sdt = students
        var sdw = sandwiches

        while sdt.count != 0 {
            if !(sdt.contains(sdw[0])){
                return sdt.count
            }
           else if sdt[0] == sdw[0] {
               sdt.removeFirst()
               sdw.removeFirst()
            } else {
                let firstValue = sdt[0]
                sdt.removeFirst()
                sdt.append(firstValue)
            }
        }

        return sdt.count
    }
}

/*
풀이과정 ->

문제 이해하는데 오래걸림 (능지이슈)



*/