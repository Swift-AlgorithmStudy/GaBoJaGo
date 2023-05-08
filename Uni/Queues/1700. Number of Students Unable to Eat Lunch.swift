class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var students = students, sandwiches = sandwiches
        while !students.isEmpty && students.contains(sandwiches[0]) {
            if students[0] == sandwiches[0] {
                students.removeFirst()
                sandwiches.removeFirst()
            } else {
                let first = students.removeFirst()
                students.append(first)
            }
        }
        return students.count
    }
}