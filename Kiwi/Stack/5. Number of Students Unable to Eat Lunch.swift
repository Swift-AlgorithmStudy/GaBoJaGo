//
//  5. Number of Students Unable to Eat Lunch.swift
//  알고리즘
//
//  Created by Kiwon Song on 2023/05/04.
//

func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
   var a = students
   var b = sandwiches
   
   while b.count != 0 {
       if b[0] != a[0] {
           a.append(a[0])
           a.removeFirst()
           
           if a.contains(b[0]) == false {
               return b.count
           }
       } else {
           a.removeFirst()
           b.removeFirst()
       }
   }
   
   return b.count
}
