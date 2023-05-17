# Chap5. Binary Trees

## 1. 이진 트리

이진 트리는 각 노드가 최대 두 개의 자식을 가지고 있는 트리이며, 그 자식은 left child, right child 라고 불립니다.
<br></br>
## 2. 구현

```swift
//BinaryNode.swift
public class BinaryNode<Element> {
  public var value: Element
  public var leftChild: BinaryNode?
  public var rightChild: BinaryNode?

  public init(value: Element) {
    self.value = value
  }
}
```

```swift
//main
var tree: BinaryNode<Int> = {
  let zero = BinaryNode(value: 0)
  let one = BinaryNode(value: 1)
  let five = BinaryNode(value: 5)
  let seven = BinaryNode(value: 7)
  let eight = BinaryNode(value: 8)
  let nine = BinaryNode(value: 9)

  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight

  return seven
}()
```

<br></br>
## 3. Traversal algorithms

이진 트리에 대한 세 가지 횡단 알고리즘을 살펴볼 것입니다

- In-order traversal
- Pre-order traversal
- post-order traversal

### In-order traversal

루트 노드에서 시작하여 다음과 같은 순서로 이진 트리의 노드를 방문합니다

1. 현재 노드에 왼쪽 자식이 있다면, 먼저 이 자식을 재귀적으로 방문하세요.
2. 노드 자체를 방문하세요.
3. 현재 노드에 오르쪽 자식이 있다면, 이 자식을 재귀적으로 방문하세요.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/4d6e1c49-c36b-40f8-9c87-f26badce32f1)

당신은 이것이 예시 트리를 오름차순으로 인쇄한다는 것을 눈치챘을 것입니다. 트리 노드가 특정 방식으로 구조화되면, 순서대로 횡단이 오름차순으로 방문합니다! 

```swift
//BinaryNode.swift
extension BinaryNode {

  public func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)
    visit(value)
    rightChild?.traverseInOrder(visit: visit)
  }
}
```

위에 제시된 규칙에 따라, 값을 방문하기 전에 먼저 가장 왼쪽 노드로 건너세요. 그런 다음 가장 오른쪽 노드로 건너세요. 

### Pre-order traversal

항상 현재 노드를 먼저 방문한 다음, 왼쪽과 오른쪽 자식을 재귀적으로 방문합니다

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/c975149e-df39-4b7b-a148-89660ad7f054)


```swift
//BinaryNode.swift
extension BinaryNode {
	public func traversePreOrder(visit: (Element) -> Void) {
		visit(value)
		leftChild?.traversePreOrder(visit: visit)
		rightChild?.traversePreOrder(visit: visit)
	}
}
```

### Post-order traversal

왼쪽과 오른쪽 자식을 재귀적으로 방문한 후에만 현재 노드를 방문합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/f1900257-68c4-4dcd-8a1f-5428ea5e43a1)

어떤 노드가 주어지면, 당신은 스스로를 방문하기 전에 자식노드를 방문할 것입니다. 이것의 흥미로운 결과는 루트 노드가 항상 마지막으로 방문된다는 것이다.

```swift
//BinaryNode.swift
extension BinaryNode {
	public func traversePostOrder(visit: (Element) -> Void) {
		leftChild?.traversePostOrder(visit: visit)
		rightChild?.traversePostOrder(visit: visit)
		visit(value)
	}
}
```

> 이러한 순회 알고리즘 각각은 O(n)의 시간 및 공간 복잡도를 가집니다. in-order순회는 노드를 오름차순으로 방문한다는 것을 알 수 있었습니다. 이를 위해 이진 트리는 삽입 과정에서 일정한 규칙을 준수함으로써 이러한 순서를 보장할 수 있습니다.
> 

<br></br>
## 🗝️ Key points

- **이진 트리는 가장 중요한 몇 가지 트리 구조의 기반이 됩니다.** 이진 탐색 트리와 AVL 트리는 삽입/삭제 동작에 제약을 가하는 이진 트리입니다.
- 중위, 전위 및 후위 순회는 이진 트리뿐만 아니라 다른 모든 트리에서 데이터를 처리할 때 정기적으로 사용됩니다.

<br></br>
### 226. **Invert Binary Tree**

```swift
class Solution {
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil } // root가 nil이라면 nil을 반환
        
        // 현재 노드의 왼쪽 서브트리와 오른쪽 서브트리를 반전시키기 위해 임시변수에 저장
        let tmp = root.left
        root.left = invertTree(root.right)
        root.right = invertTree(tmp)
        
        // 반전된 이진 트리 반환
        return root
    }
}
```

<br></br>
### **572. Subtree of Another Tree**

```swift
class Solution {
    func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
        // 만약 root 또는 subRoot가 nil이라면 서브트리가 아니므로 false를 반환
        guard let root = root, let subRoot = subRoot else { return false }

        // 만약 root와 subRoot의 구조와 값이 동일하다면 true를 반환
        if isSameTree(root, subRoot) { return true }

        // 왼쪽 서브트리와 오른쪽 서브트리에 대해 재귀적으로 isSubtree 함수를 호출
        // 어느 한쪽 서브트리에서도 subRoot를 포함하는 서브트리를 찾지 못한 경우에만 false를 반환
        return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
    }

    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        // 만약 p와 q가 모두 nil이라면 동일한 트리이므로 true를 반환
        if p == nil && q == nil { return true }
        // 만약 p와 q 중 하나만 nil이라면 구조가 다르므로 false를 반환
        if p == nil || q == nil { return false }
        // 두 노드의 값이 다르다면 구조가 다르므로 false를 반환
        if p!.val != q!.val { return false }

        // 왼쪽 서브트리와 오른쪽 서브트리에 대해 재귀적으로 isSameTree 함수를 호출하여 값 비교
        return isSameTree(p?.left, q?.left) && isSameTree(p?.right, q?.right)
    }
}
```

<br></br>
### **606. Construct String from Binary Tree**

```swift
class Solution {
    func tree2str(_ root: TreeNode?) -> String {
        // root가 nil이라면 빈 문자열을 반환
        guard let root = root else { return "" }
        
        var result: String = String(root.val)
        
        // 왼쪽 자식 노드가 있는 경우, 왼쪽 자식 서브트리를 문자열에 추가
        if root.left != nil {
            result.append("(\(tree2str(root.left)))")
        }
        // 왼쪽 자식 노드가 없고 오른쪽 자식 노드가 있는 경우, 빈 괄호를 문자열에 추가
        else if root.left == nil && root.right != nil {
            result.append("()")
        }
        
        // 오른쪽 자식 노드가 있는 경우, 오른쪽 자식 서브트리를 문자열에 추가
        if root.right != nil {
            result.append("(\(tree2str(root.right)))")
        }
        
        return result
    }
}
```

<br></br>
### **637. Average of Levels in Binary Tree**

```swift
class Solution {
    func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let root = root else {return []} //빈 트리가 주어졌을 경우 빈 배열 반환
        
        var result: [Double] = [] //최종 평균 결과를 담을 배열 선언
        var queue = [root] //루트 노드를 담는 배열 선언
        
        while queue.count != 0 { //큐 배열이 비어있지 않을 때 반복
            var sum = 0 //합을 담을 변수 생성, 0으로 초기화
            let count = queue.count //큐의 카운트를 담는 count 변수 생성
            
            for _ in 0..<count { //count 수만큼 반복 >> 현재 레벨의 노드를 순회
                let node = queue.removeFirst() //queue의 첫 번째 노드를 꺼내서 node에 할당
                sum += node.val //node의 값을 sum에 더함
            
                if let left = node.left { //node의 왼쪽 자식이 존재하면, 자식을 queue에 추가
                    queue.append(left)
                }
                if let right = node.right { //node의 오른쪽 자식이 존재하면, 자식을 queue에 추가
                    queue.append(right)
                }
            }
            result.append(Double(sum)/Double(count)) //현재 레벨의 모든 노드를 순회한 후에는 해당 레벨의 평균 값을 계산하여 result 배열에 추가합니다.
        }
        return result
    }
}
```

### **풀이**

큐를 활용하여 레벨 순회(BFS) 방식으로 트리를 탐색하고, 각 레벨의 평균 값을 계산하여 배열에 저장하는 방식

### **새로 알게된 개념**

다 몰라요..


<br></br>
### **1022. Sum of Root To Leaf Binary Numbers**

```swift
class Solution {
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        guard let root = root else { return 0 }// 루트가 nil이면 0반환
        return sumRootToLeafPrev(root, 0) //sum을 계산하기 위해 함수 호출
    }

    func sumRootToLeafPrev(_ node: TreeNode, _ prevSum: Int) -> Int {
        let sum = 2 * prevSum + node.val // 현재 노드의 값에 이전sum를 두 배로 곱하고 더하여 합을 계산
        if node.left == nil && node.right == nil { // 현재 노드가 리프 노드인 경우, 합을 반환
            return sum
        }

        var result = 0

				// 왼쪽 자식이 존재하는 경우, 왼쪽 자식에 대해 재귀로 합을 계산하고 결과에 더함
        if let left = node.left {
            result += sumRootToLeafPrev(left, sum)
        }
				
				// 오른쪽 자식이 존재하는 경우, 오른쪽 자식에 대해 재귀로 합을 계산하고 결과에 더함
        if let right = node.right {
            result += sumRootToLeafPrev(right, sum)
        }
        
        return result
    }
}
```
