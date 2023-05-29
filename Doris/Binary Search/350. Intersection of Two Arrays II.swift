class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        
        var nums1 = nums1.sorted()
        var nums2 = nums2.sorted()

        var smaller: [Int] = []
        var larger: [Int] = []

        var res: [Int] = []

        if nums1.count < nums2.count {
            smaller = nums1
            larger = nums2
        } else {
            smaller = nums2
            larger = nums1
        }

        func binarySearch(_ array: [Int], num: Int) -> Bool {
            
            if array.count == 1 {
                return array[0] == num ? true : false
            }
            let mid = array.count / 2
            if array[mid] == num { return true }
            let range = array[mid] > num ? (0..<mid) : ((mid + 1)..<array.count)
    
            return binarySearch(Array(array[range]), num: num)
        }

        for num in smaller {
            if binarySearch(larger, num: num) {
                res.append(num)
            }
        }

        return res
    }
}

// [1,2] [1,1]일 때 오류남 
// [1]이 나와야되는데 [1,1]나옴


// 중복 제거 하기 위해 dictionary 사용

class Solution {
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var dict1: [Int: Int] = [:]
        var dict2: [Int: Int] = [:]
        var res: [Int] = []

        // 배열 1의 숫자 카운트
        for num in nums1 {
            dict1[num, default: 0] += 1
        }

        // 배열 2의 숫자 카운트
        for num in nums2 {
            dict2[num, default: 0] += 1
        }

        // 공통된 숫자 찾기
        for (num, count) in dict1 {
            if let count2 = dict2[num] {
                let commonCount = min(count, count2)
                for _ in 0..<commonCount {
                    res.append(num)
                }
            }
        }

        return res
    }
}