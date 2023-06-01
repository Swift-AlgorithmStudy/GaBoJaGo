class Solution {
    func maxProduct(_ nums: [Int]) -> Int {
        var biggest = 0, secondBiggiest = 0
        for num in nums {
            if num > biggest {
                secondBiggiest = biggest
                biggest = num
            } else if num > secondBiggiest {
                secondBiggiest = num
            }
        }
        return (biggest - 1) * (secondBiggiest - 1)
    }
}