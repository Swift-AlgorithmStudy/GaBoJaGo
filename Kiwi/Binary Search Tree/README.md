# Binary Search Tree

## vs 이진트리

이진트리와의 차이점은 모든 노드가 자신의 왼쪽 Child Node엔 자신보다 작은 값이, 자신의 오른쪽 Child Node엔 자신보다 큰 값이 오는 규칙을 만족해야 한다는 점이다.

## Array vs BST

![](https://hackmd.io/_uploads/HyOPlIwBh.png)

배열에서 값을 찾는 방법은 배열의 요소를 처음부터 끝까지 검사하는 것이다. 따라서 `array.contains(:)`는 O(n) 이다.

반면 이진 검색 트리는 큰값과 작은 값을 비교하며 값을 찾아갑니다. 그래서 경우의 수가 2분의 1로 줄어들기 때문에 BST에서 각 요소의 조회가 O(log n)이다.

## Insertion

삽입도 같은 원리이다.

![](https://hackmd.io/_uploads/SklNzQUvB3.png)

위처럼 0이 배열 앞에 삽입되면 다른 모든 요소가 한 위치만큼 뒤로 이동해야 한다. 그렇기 때문에 배열에 값을 삽입하는 것은 O(n)의 시간 복잡도를 가진다.

![](https://hackmd.io/_uploads/r1Nn7UvHh.png)

BST에 대한 규칙을 활용하면 삽입 위치를 찾기 위해 세 번의 탐색 만 수행하면된다. 그래서 BST에 요소를 삽입하는 작업은 O(log n)이다.

## Removal
    
삭제도 역시나 이다. 똑같다.

![](https://hackmd.io/_uploads/HJP4PUwB2.png)
![](https://hackmd.io/_uploads/S1eUw8wS2.png)

## 구현

### BST

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

### Inserting elements

```swift
extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
        
    }
    
    private mutating func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        // root에 값이 없는 경우에 값을 추가한 경우에는 root의 값을 추가한다.
        // 혹은 아래의 if, else 구문에서 left,right 자식 노드에 추가될때 호출됨.
        guard let node = node else { return BinaryNode<Element>(value: value)}
        
        // 추가한 값이, 해당 node의 값보다 작으면 해당 노드의 왼쪽 자식 노드에
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
```
>NOTE❗️
0을 루트노드로 시작해서 4까지 순서대로 트리에 삽입하면 아래와 같은 구조가 된다. 이때 5를 추가한다면 배열과 다를 바 없는 O(n)이 된다. 이런 트리를 편향되었다 하는데 이러한 경우를 조심해서 insert를 해줘야 한다.(AVL Trees에서 자동화 가능)

![](https://hackmd.io/_uploads/HyP4RFwH3.png)

### Finding elements

```swift

extension BinarySearchTree {

  public func contains(_ value: Element) -> Bool {
    guard let root = root else {
      return false
    }
    var found = false
    root.traverseInOrder {
      if $0 == value {
        found = true
      }
    }
    return found
  }
}
// 하지만 위처럼 모든 노드를 검사할 필요가 없다. 탐색 트리는 자식노드의 규칙이 있기 때문

public func contains(_ value: Element) -> Bool {
    var current = root 
        
    while let node = current { 
        if node.value == value{ 
               return true
            }
        if value < node.value { 
               current = current?.leftChild
        } else {
            current = current?.rightChild 
           }
       }
       return false
}
```

### Removing elements

**이진 탐색 트리에서 제거하는 연산은 3가지의 경우로 나뉜다.**

1. leaf 노드인경우는 그냥 삭제하면 된다.

![](https://hackmd.io/_uploads/Hy39VqDSh.png)

2. 자식노드를 하나만 가지고 있는 경우는 삭제후 해당 노드의 자식노드로 대체하면 된다.

![](https://hackmd.io/_uploads/r1a2V9DH3.png)

3. 아래의 그림처럼 25를 삭제한다고 하면 해당 노드의 오른 노드 중에 가장 작은 노드로 대체하면된다.

| ![](https://hackmd.io/_uploads/rJFEH9PH3.png) | ![](https://hackmd.io/_uploads/BJ4rHqvr3.png) |
| --------------------------------------------- | --------------------------------------------- |

```swift
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>?{
        guard let node = node else { return nil }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil { 
                return nil 
            }
            // leaf node
            
            if node.leftChild == nil { 
                return node.rightChild 
            }
            if node.rightChild == nil { 
                return node.leftChild 
            }
            node.value = node.rightChild!.min.value 
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value { 
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
 
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
 
extension BinaryNode { 
    var min: BinaryNode {
        return leftChild?.min ?? self 
    }
}

```

# 문제풀이

## 1. Convert Sorted Array to Binary Search Tree 

### 풀이.

```swift
func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
    guard nums.count > 0 else { return nil }
    let mid = nums.count / 2
    var newNode = TreeNode(nums[mid])
    newNode.left = sortedArrayToBST(Array(nums[0..<mid]))
    newNode.right = sortedArrayToBST(Array(nums[mid+1..<nums.count]))
    return newNode
}
```

### 설명.
    
균형잡힌 트리를 만들어야 하기 때문에 어레이의 중간 인덱스를 구한다음 해당 요소값을 val로 가지는 root를 설정한다. 그리고 해당 요소보다 작은 수들을 재귀함수를 통해 작은값들은 왼쪽으로 큰값은 오른쪽으로 배치한다. 

### 주의할점.

문제를 잘 읽자.
균형잡힌 트리를 만드려면 중간으로 나눠서 양쪽에 배치.

## 2. Two Sum IV - Input is a BST   

### 풀이.

```swift
func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
    var set = Set<Int>()
    return findSum(root, k, &set)
}

func findSum(_ node: TreeNode?, _ target: Int, _ set: inout Set<Int>) -> Bool {
    guard let node = node else {
        return false
    }
    
    let complement = target - node.val
    
    if set.contains(complement) {
        return true
    }
    
    set.insert(node.val)
    
    return findSum(node.left, target, &set) || findSum(node.right, target, &set)
}
```

### 설명.

빈 Set을 선언한다.(중복값을 제거해주는 컬렉션이기 때문) 그리고 입력받은 k값에서 node의 val값을 빼주고 해당값을 빈 Set에다가 insert 해준다. 그리고 노드를 돌아가며 해당 val 값이 Set에 포함되어 있는지 확인한다. 포함된다면 두수의 합이 k와 같다는 뜻이다.

### 주의할점.

Run돌려서 통과했다고 Submit 통과된다는 보장없다.

## 3. Search in a Binary Search Tree  

### 풀이.

```swift
func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let node = root else { return nil }
    if val > node.val {
        return searchBST(node.right, val)
    } else if val < node.val {
        return searchBST(node.left, val)
    } else {
        return node
    }
}
```

### 설명.

교과서의 search와 같음.

### 주의할점.

개꿀.

## 4. Minimum Distance Between BST Nodes 

### 풀이.

```swift
func minDiffInBST(_ root: TreeNode?) -> Int {
    var prev: TreeNode?
    var res = Int.max
    
    func dfs(_ node: TreeNode?) {
        if node == nil { return }
        dfs(node?.left)
        
        if prev != nil {
            res = min(res, node!.val - prev!.val)
        }
        prev = node
        
        dfs(node?.right)
    }
    
    dfs(root)
    return res
}
```

### 설명.

재귀함수를 통해 dfs를 돌린다. node의 left값과 right값을 함수에 입력하는 타이밍이 중요하다. left는 작은값이기 때문에 prev 값에 할당을 한후 다음식으로 진행한다.

### 주의할점.

함수를 비동기 처럼 생각하지 말자.

## 5. Increasing Order Search Tree 

### 풀이.

```swift
func increasingBST(_ root: TreeNode?) -> TreeNode? {
    var arr: [Int] = []
    func traverse(_ node: TreeNode?) {
        guard let node = node else { return }
        traverse(node.left)
        arr.append(node.val)
        traverse(node.right)
    }
    traverse(root)
    let head = TreeNode(arr[0])
    var tail = head
    for n in arr[1...] {
        tail.right = TreeNode(n)
        tail = tail.right!
    }
    return head
}
```

### 설명.

중위탐색을 통해 모든 값을 순서대로 빈어레이에 할당한다. 그런다음 어레이의 순서대로 링크드 리스트로 만들어주면 끝!

### 주의할점.

좋다좋아.


