# Trees

## 용어설명

#### 그림1
![](https://hackmd.io/_uploads/H1lqQZ0E2.png)

- **Node** : 그림에서 직 사각형으로 된 것은 모두 노드이다. 트리 자료구조는 연결리스트와 마찬가지로 여러 '노드'로 구성된다.
 
- **root** : 트리에서 가장 위에 있는 노드를 root 노드라고 한다. 

- **leaf** : 트리에서 자식노드가 없는 노드를 leaf 노드라고 한다. 

![](https://hackmd.io/_uploads/Sku5QZ0Eh.png)

- **Parent, children** : 위에 그림처럼 트리는 부모와 자식으로 구성되어 있다. 모든 자식노드는 하나의 부모노드만을 가지는 특성이 있다.

## 구현

### 트리
```swift

public class TreeNode<T> {
    public var value: T // 노드가 가지고 있는 값
    public var children = Array<TreeNode>() // 자식 노드는 복수로 존재 할 수 있으니 배열로 선언.
    public init(_ value:T){
        self.value = value 
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }   
}
 
```

```swift
    let tree = TreeNode("Beverages") // 루트 노드
    
    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")
    
    let tea = TreeNode("Tea")
    let coffee = TreeNode("Coffee")
    let cocoa = TreeNode("Cocoa")
    
    let blackTea = TreeNode("black")
    let greenTea = TreeNode("green")
    let chaiTea = TreeNode("chai")
    
    let soda = TreeNode("Soda")
    let milk = TreeNode("Milk")
    
    let gingerAle = TreeNode("ginger ale")
    let bittleLemon = TreeNode("bittle lemon")
    
    tree.add(hot)
    tree.add(cold)
    
    hot.add(tea)
    hot.add(coffee)
    hot.add(cocoa)
    
    cold.add(soda)
    cold.add(milk)
    
    tea.add(blackTea)
    tea.add(greenTea)
    tea.add(chaiTea)
    
    soda.add(gingerAle)
    soda.add(bittleLemon)
```
 >Note! 구조 형태는 [그림1](#그림1) 참조

### forEachDepthFirst(visit: ) 구현

- 깊이 우선 탐색 메서드이다. 아래의 형태로 출력되어야 한다.

![](https://hackmd.io/_uploads/H1UyPbAN3.png)

```swift
tree.forEachDepthFirst { 
    print($0.value) 
}

public func forEachDepthFirst(visit: (TreeNode) -> Void) {
    visit(self)
    children.forEach {
      $0.forEachDepthFirst(visit: visit)
    }
  }
}
```
재귀 함수를 이용하여 자식 노드들의 value 값을 print하도록 한다.

### forEachLevelOrder(visit: ) 구현

- 레벨 우선 탐색 메서드.

![](https://hackmd.io/_uploads/HyfGj-A4n.png)

```swift
tree.forEachLevelOrder {
        print($0.value) 
}

public func forEachLevelOrder(visit: (TreeNode) -> Void ){
        visit(self) 
        var queue = Queue<TreeNode>() 
        // TreeNode 객체를 Queue 방식으로 저장.
        
        children.forEach { 
            queue.enqueue($0) // 루트의 자식 노드 두개.
        }
        while let node = queue.dequeue() { 
            visit(node) // 루트의 자식 노드 프린트
            node.children.forEach { 
                //루트의 자식 노드 들의 자식 노드들도 enqueue 그리고 위에 과정을 반복.
                queue.enqueue($0)
            }
        }
}
```

### search(value: ) 구현

```swift

extension TreeNode where T: Equatable { 
    // Equatable을 채택한 타입만 탐색이 가능하다.
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode? 
        forEachDepthFirst { node in 
            // 위에 구현한 메서드 둘중 하나 선택 가능
            if node.value == value {
                result = node
            } // 찾고자 하는 노드가 검사하는 노드의 값과 일치하는지 확인.
        }
        return result 
    }
}
```
# Binary Trees

## 용어

이진 트리는 트리를 구성하는 각 노드가 최대 두 개의 자식 노드를 가지는 트리를 의미

![](https://hackmd.io/_uploads/BJ5gUieBn.png)

### 전위 순회
![](https://hackmd.io/_uploads/HJ7qZobBn.png)

전위 순회는 다른 노드들을 방문 하기 이전에 루트노드를 먼저 방문하는 순회방식이다. 루트 -> 왼쪽 -> 오른쪽 순으로 트리의 노드들을 방문한다고 생각하면 된다.

### 중위 순회
![](https://hackmd.io/_uploads/ryNplobS3.png)

중위 순회는 루트 노드를 중간에 방문하는 순회 방법입니다. 따라서 왼쪽->루트->오른쪽의 순서대로 노드를 방문하게 된다.

### 후위 순회
![](https://hackmd.io/_uploads/BkVM-j-B2.png)

후위 순회는 루트 노드를 가장 마지막으로 방문하는 순회 방법이다. 왼쪽 서브트리의 탐색이 항상 오른쪽보다 선행되기 때문에 왼쪽->오른쪽->루트의 순서대로 노드를 방문하게 된다.

## 구현

```swift
public class BinaryNode<Element> {
  
  public var value: Element
  public var leftChild: BinaryNode?
  public var rightChild: BinaryNode?
  
  public init(value: Element) {
    self.value = value
  }
}

// 재귀함수 Party
extension BinaryNode {
  
  public func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)
    visit(value)
    rightChild?.traverseInOrder(visit: visit)
  }
  
  public func traversePreOrder(visit: (Element) -> Void) {
    visit(value)
    leftChild?.traversePreOrder(visit: visit)
    rightChild?.traversePreOrder(visit: visit)
  }
  
  public func traversePostOrder(visit: (Element) -> Void) {
    leftChild?.traversePostOrder(visit: visit)
    rightChild?.traversePostOrder(visit: visit)
    visit(value)
  }
}
```
# Trees, Binary Trees

## 1.Invert Binary Tree  

### 풀이.

```swift
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else { return nil }
    let left: TreeNode? = root.left
    let right: TreeNode? = root.right
    
    root.left = right
    root.right = left
    
    invertTree(root.left)
    invertTree(root.right)
    
    return root
}
```

### 설명.

root의 nil 여부를 확인을 먼저한다음 nil이 아니라면 left와 right를 상수에 할당한다.(값의 변경을 반영하기 위해) 할당된 상수들을 root의 left,right에 바꿔서 할당한다. 이런 식을 가지고 있는 함수를 재귀함수로 계산한다.

### 주의할점.

유일하게 푼문제이다.

## 2.Subtree of Another Tree 

### 풀이.

```swift
func isSubtree(_ root: TreeNode?, _ subRoot: TreeNode?) -> Bool {
    guard let root = root else { return false }
    if check(root, subRoot) {
        return true
    }
    
    return isSubtree(root.left, subRoot) || isSubtree(root.right, subRoot)
}

func check(_ treeA: TreeNode?, _ treeB: TreeNode?) -> Bool {
    if treeA == nil && treeB == nil {
        return true
    }
    
    guard let treeA = treeA, let treeB = treeB else { return false }
    
    guard treeA.val == treeB.val else { return false }
    
    return check(treeA.left, treeB.left) && check(treeA.right, treeB.right)
}
```

### 설명.

해당 subRoot를 포함하고 있는지 확인하기 위해서는 우선적으로 각각의 root의 val의 값이 같아야한다. 그래서 val 값을 비교한다음 같다면 해당 root의 left 값고 subroot의 left값을 재귀적으로 다시 확인한다.(right도 동일) 그리고 최종적으로 비교하는 두 노드의 값이 nil면 true를 리턴한다.

### 주의할점.

그냥 어렵다.

## 3.Construct String from Binary Tree

### 풀이.

```swift
func tree2str(_ t: TreeNode?) -> String {
    return makeStringValue(t)
}

func makeStringValue(_ root: TreeNode?) -> String {
    if root == nil {
        return ""
    }
    if root!.left == nil && root!.right == nil {
        return "\(root!.val)"
    }
    if root!.right == nil {
        return "\(root!.val)" + "(" + makeStringValue(root!.left) + ")"
    }
    return "\(root!.val)" + "(" + makeStringValue(root!.left) + ")(" + makeStringValue(root!.right) + ")"
}
```

### 설명.

root가 nil이면 ""을 리턴한다. nil이 아니라면 left와 right의 값이 nil인지 아닌지 확인하고 동시에 nil이 아니라면
해당 root의 val를 스트링 값으로 리턴한다. 그리고 right만 nil 이라면 root의 val 스트링 값에 괄호 안에 들어있는 left값을 리턴한다. 마지막으로 left값이 nil이라면 root의 val 스트링 값에 괄호에 쌓인 root.left의 재귀함수와 right의 재귀함수를 리턴하면 된다.

### 주의할점.

아 이게 내가 푼건지 뭔지 모르겠다

## 4.Average of Levels in Binary Tree
 
### 풀이.

```swift
func averageOfLevels(_ root: TreeNode?) -> [Double] {
        guard let r = root else {
            return [0.0]
        }

        var result = [Double]()
        var queue = [TreeNode]()

        queue.append(r)

        while !queue.isEmpty {
            let countInLevel = queue.count
            var sum = 0

            for _ in 0..<countInLevel {
                let node = queue.removeFirst()
                
                sum += node.val

                if let left = node.left {
                    queue.append(left)
                }

                if let right = node.right {
                    queue.append(right)
                }
            }

            result.append(Double(sum) / Double(countInLevel))
        }

        return result
    }
```

### 설명.

while 반복문을 이용해서 각 level의 요소값들을 enque해주고 이를 재귀적으로 deque 하면서 더해주고 최종적으로 전체 요소 개수로 나눠준다.

### 주의할점.

그냥 힘들다.

## 5.Sum of Root To Leaf Binary Numbers 

### 풀이.

```swift
    func sumRootToLeaf(_ root: TreeNode?) -> Int {
        
        var res = 0
        
        func go(_ node: TreeNode? = root, _ s: String = "") {
            guard let node = node else { return }
            
            var ns = s + String(node.val)
            
            guard node.left == nil, node.right == nil else {
                go(node.left, ns)
                go(node.right, ns)
                return
            }
            
            res += Int(ns, radix: 2)!
        }
        
        go()
        
        return res
    }
```

### 설명.

입력받은 node의 val값을 string 값에 더해주고, left와 right 값의 존재여부를 확인한다. 존재 한다면 node의 val값을 더한 string 값과함께 재귀함수를 실행한다. 그리고 마지막으로 radix를 이용해 res 값에 더해준다.

### 주의할점.

나 알고리즘 실력 늘고있는거 맞아?
