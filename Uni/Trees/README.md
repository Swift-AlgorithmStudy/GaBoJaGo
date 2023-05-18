# Trees

- 트리는 아래의 그림과 같이 부모 노드, 자식 노드의 연결로 이루어진 자료구조
    → 추상구문트리, max heap, 균형이진트리 (AVL트리, 레드블랙트리) 등등에 사용됨

<img width="500" alt="스크린샷 2023-05-18 오전 10 38 32" src="https://github.com/zhunhe/zhunhe/assets/22979718/6133f128-7301-43bc-beb7-f9fecf5f1849">

## 노드
- 트리는 연결 리스트와 마찬가지로 노드로 구성되며 아래의 정보를 갖고 있음
    - 값
    - 자식 노드의 주소값

<img width="300" alt="스크린샷 2023-05-18 오전 11 00 52" src="https://github.com/zhunhe/zhunhe/assets/22979718/32245992-2201-4efc-acea-3f3aaccd099a">

### 부모 노드, 자식 노드
- 각 자식은 무조건 하나의 부모 노드를 가지고 있음
- 부모는 여러 자식 노드를 가질 수 있음

<img width="300" alt="스크린샷 2023-05-18 오전 11 02 19" src="https://github.com/zhunhe/zhunhe/assets/22979718/89015921-183a-4352-914b-d07b22964cbd">

### 루트 노드
- 트리에서 가장 위에 있는 노드를 트리의 루트 노드라고 함
- 루트는 유일하게 부모가 없는 노드

<img width="500" alt="스크린샷 2023-05-18 오전 11 05 07" src="https://github.com/zhunhe/zhunhe/assets/22979718/dee2d2c0-e663-4e53-a0ae-b862e0216333">


### 리프 노드
- 자식 노드가 하나도 없으면 해당 노드를 리프 노드라고 함

<img width="500" alt="스크린샷 2023-05-18 오전 11 05 58" src="https://github.com/zhunhe/zhunhe/assets/22979718/cc3b4cc9-d142-4098-ac52-c42d5900a11b">

## 구현

```swift
public class TreeNode<T> {
  public var value: T
  public var children: [TreeNode] = []
  public init(_ value: T) {
    self.value = value
  }

	public func add(_ child: TreeNode) {
	  children.append(child)
	}
}
```

## 탐색 알고리즘

### 깊이 우선 순회(**Depth-first traversal, DFS)**

- 먼저 가장 깊은 노드를 방문한 다음 해당 노드의 형제가 없으면 부모 노드로 역추적
- BFS에 비해 상대적으로 메모리를 덜 쓰고, 구현이 간단한 장점
- Stack을 사용해 구현도 가능하나 재귀를 사용해 구현하는게 일반적인 느낌
- 가장 깊은 노드를 다 탐색하기 때문에 BFS에 비해 상대적으로 느림

<img width="400" alt="스크린샷 2023-05-18 오후 1 38 36" src="https://github.com/zhunhe/zhunhe/assets/22979718/b40acbc1-ed71-4c03-a1a4-8bc9d90411ec">

```swift
let root = TreeNode(value: 0)

let child1 = TreeNode(value: 1)
let child2 = TreeNode(value: 2)

let grandchild1 = TreeNode(value: 3)
let grandchild2 = TreeNode(value: 4)
let grandchild3 = TreeNode(value: 5)
let grandchild4 = TreeNode(value: 6)

root.addChild(child1)
root.addChild(child2)

child1.addChild(grandchild1)
child1.addChild(grandchild2)
child2.addChild(grandchild3)
child2.addChild(grandchild4)

// 트리 순회(traversal) 예시: 깊이 우선 순회 (Depth-First Traversal)
func depthFirstTraversal(node: TreeNode<Int>) {
    print(node.value)
    
    for child in node.children {
        depthFirstTraversal(node: child)
    }
}

depthFirstTraversal(node: root)

// 출력 결과:
// 0
// 1
// 3
// 4
// 2
// 5
// 6
```

### 레벨 순서 순회(**Level-order traversal, BFS)**
- 루트 노드로부터 가까운 노드부터 탐색하는 알고리즘
- 자료구조 queue를 활용해 구현함

<img width="400" alt="스크린샷 2023-05-18 오후 1 40 24" src="https://github.com/zhunhe/zhunhe/assets/22979718/5ada4b1f-314e-4d29-8cea-548ad5013e8e">

```swift
func levelOrderTraversal(root: TreeNode<String>) {
    var queue: [TreeNode<String>] = []
    queue.append(root)
    
    while !queue.isEmpty {
        let currentNode = queue.removeFirst()
        print(currentNode.value)
        
        for child in currentNode.children {
            queue.append(child)
        }
    }
}

// 예시를 위해 문자열형 트리를 만들어보겠습니다.
let root = TreeNode(value: "0")

let child1 = TreeNode(value: "1")
let child2 = TreeNode(value: "2")

let grandchild1 = TreeNode(value: "3")
let grandchild2 = TreeNode(value: "4")
let grandchild3 = TreeNode(value: "5")
let grandchild4 = TreeNode(value: "6")

root.addChild(child1)
root.addChild(child2)

child1.addChild(grandchild1)
child1.addChild(grandchild2)
child2.addChild(grandchild3)
child2.addChild(grandchild4)

levelOrderTraversal(root: root)

// 출력 결과:
// 0
// 1
// 2
// 3
// 4
// 5
// 6
```

## **Key points**

- 트리의 부모 노드는 여러 개의 자식 노드를 가질 수 있음
- 루트 노드(는 부모 노드 0개)를 제외한 모든 트리 노드는 하나의 부모 노드를 가지고 있음
- 자식 노드가 없는 노드는 리프 노드라고 부름
- 깊이 우선 순회와 레벨 순서 순회와 같은 트리 탐색은 일반적인 트리에만 해당되는 것은 아님

# Binary Trees
- Tree에서 각 노드가 최대 2개의 자식 노드를 가질 수 있는 트리를 Binary Tree(이진 트리)라고 부름

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
```

## 탐색 알고리즘

### 전위 순회(**Pre-order traversal)**
- 트리를 복사하는데 사용
    → 부모 노드가 자식 노드보다 먼저 생성되어야 하므로!

<img width="300" alt="스크린샷 2023-05-18 오후 2 04 50" src="https://github.com/zhunhe/zhunhe/assets/22979718/1f341afd-5c0c-4c58-87d0-2c67e761fde3">

### 중위 순회(In-order traversal)s
- 이진 탐색 트리에서 오름차순 or 내림차순으로 값을 가져오는데 사용

<img width="327" alt="스크린샷 2023-05-18 오후 2 01 50" src="https://github.com/zhunhe/zhunhe/assets/22979718/aa93bb38-d6a5-49f7-86b0-a659f4f7486f">


```swift
func inOrderTraversal(node: TreeNode<String>?) {
    guard let currentNode = node else {return}
    // print(currentNode.value)          // <- 전위 순회
    inOrderTraversal(node: currentNode.left)
    // print(currentNode.value)          // <- 중위 순회
    inOrderTraversal(node: currentNode.right)
    // print(currentNode.value)          // <- 후위 순회
}

// 예시를 위해 문자열형 이진 트리를 만들어보겠습니다.
let root = TreeNode(value: "7")

let leftChild = TreeNode(value: "1")
let rightChild = TreeNode(value: "9")

let leftGrandchild1 = TreeNode(value: "0")
let leftGrandchild2 = TreeNode(value: "5")
let rightGrandchild1 = TreeNode(value: "8")

root.left = leftChild
root.right = rightChild

leftChild.left = leftGrandchild1
leftChild.right = leftGrandchild2
rightChild.left = rightGrandchild1

inOrderTraversal(node: root)

// 출력 결과:
// 0
// 1
// 5
// 7
// 8
// 9
```

### 후위 순회(**Post-order traversal)**
- 주로 트리를 삭제하는데 사용
    → 부모 노드를 삭제하기 전에 자식 노드를 삭제해야 하기 때문!

<img width="300" alt="스크린샷 2023-05-18 오후 2 06 16" src="https://github.com/zhunhe/zhunhe/assets/22979718/2f45e608-cf48-46cc-8b13-b935399aef7b">

## Key points
- 이진 트리는 가장 중요한 트리 구조의 기반이 됨
- 중위 순회(In-order), 전위 순회(Pre-order), 후위 순회(Post-order)는 이진 트리에만 중요한 것은 아님. 어떤 종류의 트리에서 데이터를 처리할 때도 이러한 순회 방법을 정기적으로 사용함.