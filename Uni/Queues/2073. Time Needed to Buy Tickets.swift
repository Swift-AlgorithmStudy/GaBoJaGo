class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var diff = 0
        var rightCount = 0
        for (i, _) in tickets.enumerated() {
            diff += max(tickets[k] - tickets[i], 0)
            if i > k && tickets[i] >= tickets[k] {
                rightCount += 1
            }
        }
        return tickets.count * tickets[k] - rightCount - diff
    }
}