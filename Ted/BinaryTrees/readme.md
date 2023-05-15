# Binary Trees

Binary tree는 각각의 노드가 기껏해야 2명의 자식을 가질 수 있는 트리이며 이들을 왼쪽, 오른쪽 자식이라고 부르는 부르는 특징이 있습니다.

<img width="244" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/34d957e0-d2d5-4094-84ef-f91a15e281bf">

Binary tree는 많은 트리 구조와 알고리즘의 근간이 되기 때문에 이번 장에서는 가장 중요한 트리 선회 알고리즘에 대해 배울 것입니다.

## Implementation

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

```swift
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

위의 식은 다음과 같습니다.

<img width="226" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/46eb9e46-62b4-4f3a-a4db-368a6f7e02a6">

## Traversal algorithms

Binary tree를 순회하는 방법이 있는데, in-order(중위), pre-order(전위), post-order(후위)순회 방식입니다.

### In-order traversal (중위 순회)

In-order traversal은 root node부터 시작해서 다음과 같은 순서를 따릅니다.

1. 현재 노드가 왼쪽 자식이 있다면, 재귀적으로 왼쪽 자식부터 방문합니다.
2. 그리고 노드 자신을 방문합니다.
3. 만약 현재 노드가 오른쪽 자식이 있다면, 재귀적으로 이 자식들을 방문합니다.

***left- root - right*** 

```swift
extension BinaryNode {

  public func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)    //1
    visit(value)    //2
    rightChild?.traverseInOrder(visit: visit)    //3
  }
}
```

### pre-order traversal (전위 순회)

pre-order traversal(전위 순회)는 현재의 노드를 먼저 방문하고, 재귀적으로 왼쪽, 오른쪽 자식을 방문합니다.

***root - left - right***

```swift
public func traversePreOrder(visit: (Element) -> Void) {
  visit(value)
  leftChild?.traversePreOrder(visit: visit)
  rightChild?.traversePreOrder(visit: visit)
}
```

### post-order traversal (후위 순회)

post-order traversal(후위 순회)는 왼쪽, 오른쪽 자식을 재귀적으로 방문한 뒤에 현재의 노드를 방문합니다.

***left - right - root***

```swift
public func traversePostOrder(visit: (Element) -> Void) {
  leftChild?.traversePostOrder(visit: visit)
  rightChild?.traversePostOrder(visit: visit)
  visit(value)
}
```

이 순회 알고리즘들은 O(n)의 시간 복잡도를 가집니다. 

중위 순회(in-order traversal)는 오름차순으로 노드들을 방문합니다.

이진 트리(Binary tree)는 삽입 동작 시 일부 규칙을 준수함으로써 이를 보장할 수 있는데, 다음 장에서는 더욱 엄격한 의미를 가진 이진 탐색 트리에 대해 살펴볼 것입니다.

## Key-points

- 이진 트리는 트리 구조 중 가장 중요한 구조의 기초입니다.
    
    이진 탐색 트리와 AVL 트리는 삽입, 삭제에 있어서 엄격한 제한을 갖는 이진 트리입니다.
    
- in-order, pre-order, post-order traversal은 이진 트리 뿐에서만 중요한 개념이 아니고 다른 트리에서도 꾸준하게 사용될 것입니다.
