# Binary Search Trees

Binary search tree(BST)는 빠른 탐색, 삽입,제거 연산을 용이하게 해주는 자료 구조입니다.

한 쪽을 선택하면 다른 쪽의 가능성을 완전히 배제하여 문제를 반으로 줄여주는 경우를 생각해보십시오.

<img width="404" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ab0188f6-8810-406e-89d1-9042a76d0fea">

결정을 내리고 브랜치를 선택하였으면, 뒤로 돌아갈 수 없습니다.

leaf node로 갈 때까지(마지막 선택을 할 때까지) 계속 진행됩니다.

BST는 binary tree에서 2가지의 규칙을 추가합니다.

- **왼쪽 자식은 부모보다 값이 작아야합니다.**
- **결론적으로, 오른쪽 자식은 부모와 값이 같거나, 더 커야합니다.**

BST는 위의 특징을 통해 불필요한 확인을 하지 않아 성능을 보호해줍니다.

탐색, 삽입, 제거는 평균 O(logn)의 시간 복잡도를 가지는데, 이는 배열과 링크드 리스트에 비해 엄청나게 빠른 속도입니다.

이번 장에서는 배열에 비해 BST가 가지는 장점과 자료 구조에 대해 배울 예정입니다.

## Case study: array vs BST

배열과 BST에 대해 비교해보겠습니다.

<img width="450" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/362a3802-3726-432a-ab36-7792bd958393">

정렬되지 않은 배열에서 요소를 찾기 위해서는 처음부터 시작하여 모든 요소를 확인하는 방법밖에는 없습니다.

그러한 이유로 array.contains(_:)는 O(n)입니다.

<img width="318" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/91a93e1d-f1c1-48a6-9bab-49e6aed7d0b9">

BST에서 노드를 방문할 때마다 두 가지의 가정을 진행합니다.

- 만약 찾는 값이 현재 값보다 작다면, 그 값은 왼쪽 subtree에 있을 것입니다.
- 만약 찾는 값이 현재 값보다 크다면, 그 값은 오른쪽 subtree에 있을 것입니다.

BST의 규칙을 활용함으로써 불필요한 확인을 피하고 결정을 내릴 때마다 검색 공간을 절반으로 줄일 수 있습니다.

이로 인해 BST는 O(log n)입니다.

### Insertion

만약 0을 삽입하고 싶다고 가정해봅시다.

<img width="411" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/8c2c4300-94de-4164-a919-8fec31a0c186">

0이 삽입된다면, 다른 요소들을 뒤로 옮겨줘야합니다.

고로 배열에 삽입하는 것은 O(n)의 시간 복잡도를 가집니다.

<img width="285" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/01dd8c94-13bd-46c3-8628-70cfa7c24ac5">

BST에서의 삽입은 더욱 간편합니다.

BST의 규칙을 활용한다면, 오직 3번의 탐색을 통해 삽입 위치를 찾을 수 있고, 다른 요소들의 위치를 옮길 필요도 없어집니다.

따라서 BST는 O(log n)의 시간 복잡도를 가집니다.

### 제거

삽입과 비슷하게, 요소를 제거하는 것 또한 요소의 위치를 옮겨줘야 합니다.

<img width="480" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/98ab19fd-17da-497b-b1cc-74b3903eb3a7">

만약 중간에 있는 값이 제거된다면, 그 값의 뒤에 있는 요소들의 위치를 앞으로 옮겨줘야 합니다.

<img width="278" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/b97ce8ab-3bb1-42dc-8cea-b8714c5e61a3">

이런 방식을 이용한다면 노드를 제거하는 방식이 쉽고 간편합니다. 제거하고자 하는 노드에게 자식이 있다면 조금 복잡하겠지만, 이는 조금 이따가 배울 예정입니다.

BST에서 제거하는 것 또한 O(log n)의 시간 복잡도를 가집니다.

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

public struct BinarySearchTree<Element: Comparable> {

  public private(set) var root: BinaryNode<Element>?

  public init() {}
}

extension BinarySearchTree: CustomStringConvertible {

  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}
```

정의에 의해서 BST는 Comparable 가능한 요소들만 가질 수 있습니다.

set으로 되어있는 이유는 다음과 같습니다.

- BST는 중복된 값이 존재할 수 없기 때문입니다.
- 특정 값의 존재 여부를 검사하는데에 있어 효율적인 탐색 작업을 지원합니다.

## Inserting elements

BST는 현재 노드보다 작은 값은 왼쪽 자식으로, 크거나 같은 값은 오른쪽 자식으로 지정해야 하는 규칙이 있으므로, 이를 준수하면서 insert 메소드를 작성해보겠습니다.

```swift
extension BinarySearchTree {

  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }

  private func insert(from node: BinaryNode<Element>?, value: Element)
      -> BinaryNode<Element> {
    // 1
    guard let node = node else {
      return BinaryNode(value: value)
    }
    // 2
    if value < node.value {
      node.leftChild = insert(from: node.leftChild, value: value)
    } else {
      node.rightChild = insert(from: node.rightChild, value: value)
    }
    // 3
    return node
  }
}
```

1. 재귀함수이기 때문에, base case가 필요합니다.
만약 현재 노드가 없다면(nil) value값을 넣고 새로운 BinaryNode를 반환합니다.
—> 이 경우는 처음 노드에 값을 추가할 때만 사용됩니다. 

```swift
var tree = BinarySearchTree<Int>()
tree.insert(5)
```

처음에 tree를 선언했을 때에는 값이 아무 것도 없습니다.

따라서 insert(5)를 실행했을 때, guard let 구문에서 현재 노드값이 nil이므로 Binary Node에 5라는 value를 추가한 뒤 반환해줍니다.
그 다음 insert가 진행되면 nil이 아니기 때문에 그 아래의 식으로 넘어갑니다.

1. 요소들이 비교 가능한(Comparable) 타입이기 때문에, 비교를 할 수 있습니다.
만약 입력받은 value가 노드의 value보다 작은 경우, 왼쪽 자식으로 값을 insert하게 되고,
입력받은 value가 노드의 value보다 큰 경우, 오른쪽 자식으로 값을 insert하게 됩니다.

2. 현재 노드를 반환합니다. 이 형식은 노드가 없을 때 노드를 만들어주거나(1번), 노드를 추가한 뒤 노드를 반환해주는 역할(2번)을 합니다.

```swift
example(of: "building a BST") {
  var bst = BinarySearchTree<Int>()
  for i in 0..<5 {
    bst.insert(i)
  }
  print(bst)
}

---Example of: building a BST---
    ┌──4
  ┌──3
  │ └──nil
 ┌──2
 │ └──nil
┌──1
│ └──nil
0
└──nil
```

위의 트리는 불균형해보이지만, 규칙을 따르고 있습니다. 

하지만, 트리를 사용할 때는 균형이 맞도록 포멧을 설정해야합니다.

<img width="393" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ea6ea60b-32e4-4c23-a033-b3fcba0869ef">

왜냐하면 불균형한 트리는 성능에 영향을 줍니다. 

만약 불균형한 트리에 5를 삽입한다면, O(n) 연산이 될 것입니다.

<img width="494" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/89885746-d1a2-486f-8b69-20a575d78989">

self-balancing tree라는 구조를 통해 균형있는 구조를 유지할 수 있는데, 이는 AVL Trees때 자세히 배울 예정입니다.

```swift
var exampleTree: BinarySearchTree<Int> {
  var bst = BinarySearchTree<Int>()
  bst.insert(3)
  bst.insert(1)
  bst.insert(4)
  bst.insert(0)
  bst.insert(2)
  bst.insert(5)
  return bst
}

example(of: "building a BST") {
  print(exampleTree)
}

---Example of: building a BST---
 ┌──5
┌──4
│ └──nil
3
│ ┌──2
└──1
 └──0
```

먼저 3을 삽입해주면 전에 비해 훨씬 균형있게 됩니다.

## Finding elements

요소를 찾는 것은 이전의 챕터에서 배운 순회 방식을 사용한다면 쉽게 적용할 수 있을 것입니다.

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

example(of: "finding a node") {
  if exampleTree.contains(5) {
    print("Found 5!")
  } else {
    print("Couldn’t find 5")
  }
}

---Example of: finding a node---
Found 5!
```

in-order traversal(중위 순회)은 O(n)의 시간 복잡도를 가지고 있으므로, unsorted array와 같은 시간 복잡도를 가집니다.
하지만 이를 최적화할 수 있습니다.

### Optimizing contains

BST 규칙을 통해 불필요한 비교를 피할 수 있습니다.

```swift
public func contains(_ value: Element) -> Bool {
  // 1
  var current = root
  // 2
  while let node = current {
    // 3
    if node.value == value {
      return true
    }
    // 4
    if value < node.value {
      current = node.leftChild
    } else {
      current = node.rightChild
    }
  }
  return false
}
```

1. root를 current로 세팅해놓습니다.
2. 만약 current의 값이 존재한다면(nil이 아니라면), current node의 value를 확인합니다.
3. 만약 값이 동일하다면, true를 반환합니다.
4. 만약 원하는 값이 노드의 값보다 작다면, current를 노드의 왼쪽 자식으로 할당합니다.
만약 반대라면 오른쪽 자식으로 할당합니다.
5. 만약 current가 nil이 된다면 false를 반환합니다.

위 식은 balanced BST에서 O(log n) 연산입니다.

## Removing elements

요소를 제거하는 것은 다양한 시나리오가 있기 떄문에 조금 까다로울 수 있습니다.

### Case 1: Leaf node

leaf node를 제거하는 것은 직관적입니다. 단순히 leaf node를 삭제하면 됩니다.

<img width="286" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/c2b9f712-87ab-4595-aa8c-31b81b26e9e3">

하지만 leaf node가 아닌 경우에는 추가적인 단계를 거쳐야합니다.

### Case 2: Nodes with one child

만약 하나의 자식을 가진 노드를 제거하고 싶으면, 그 자식을 다른 트리와 연결해줍니다.

<img width="240" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/1c703862-2a0d-4c1a-a7cf-f7b4b96b05fc">

### Case 3: Nodes with two children

두 자식을 갖는 노드라면 조금 더 복잡하므로, 상황을 예시로 설명하는 것이 더욱 도움에 될 것입니다.

만약 25를 제거하고 싶다고 가정해봅시다.

<img width="409" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/6ecd239b-bdbf-493e-9777-70e1d8cad5bd">

하나의 자식을 연결할 수 있는데, 2개의 자식이 나왔습니다(12, 37).

이 문제를 해결하기 위해선, swap을 이용해야합니다.

두 개의 자식이 있을 때는, 오른쪽 자식 중 가장 작은 값으로 교체합니다. 
BST 규칙에 따르면 이는 오른쪽 자식 중 가장 왼쪽 노드입니다.(leftmost node of the right subtree)

<img width="289" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/69988b90-0334-41e0-b2e3-5b7ee78064fa">

swap을 진행한 후, leaf node에 있는 복사한 값을 삭제하면 됩니다.

<img width="307" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/cccce1ac-3e0b-45e8-be38-a15b910321e2">

### Implementation

```swift
private extension BinaryNode {

  var min: BinaryNode {
    leftChild?.min ?? self
  }
}

extension BinarySearchTree {

  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }

  private func remove(node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element>? {
    guard let node = node else {
      return nil
    }
    if value == node.value {
      // more to come
    } else if value < node.value {
      node.leftChild = remove(node: node.leftChild, value: value)
    } else {
      node.rightChild = remove(node: node.rightChild, value: value)
    }
    return node
  }
}
```

min을 통해 subtree의 최소값을 구해주었습니다. 

insert와 다를 게 없지만, value == node.value일 때(노드의 값과 삭제하고자 하는 값이 같을 때)만 다르게 다뤄져야합니다.

```swift
private extension BinaryNode {

  var min: BinaryNode {
    leftChild?.min ?? self
  }
}

extension BinarySearchTree {

  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }

  private func remove(node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element>? {
    guard let node = node else {
      return nil
    }
    if value == node.value {
      // 1
			if node.leftChild == nil && node.rightChild == nil {
			  return nil
			}
			// 2
			if node.leftChild == nil {
			  return node.rightChild
			}
			// 3
			if node.rightChild == nil {
			  return node.leftChild
			}
			// 4
			node.value = node.rightChild!.min.value
			node.rightChild = remove(node: node.rightChild, value: node.value)

    } else if value < node.value {
      node.leftChild = remove(node: node.leftChild, value: value)
    } else {
      node.rightChild = remove(node: node.rightChild, value: value)
    }
    return node
  }
}
```

1. 만약 해당 노드가 leaf 노드라면 nil을 반환함으로써 해당 노드를 제거해줍니다.
2. 만약 왼쪽 자식이 없다면 오른쪽 자식을 반환하여 오른쪽 트리와 연결해줍니다.
3. 만약 오른쪽 자식이 없다면 왼쪽 자식을 반환하여 왼쪽 트리와 연결해줍니다.
4. 없어져야 할 노드가 왼쪽, 오른쪽 자식 둘 다 있을 때, 
오른쪽 자식의 최소값을 노드 값으로 지정하고, 원래 있던 자리의 노드를 제거해줍니다.

```swift
example(of: "removing a node") {
  var tree = exampleTree
  print("Tree before removal:")
  print(tree)
  tree.remove(3)
  print("Tree after removing root:")
  print(tree)
}

---Example of: removing a node---
Tree before removal:
 ┌──5
┌──4
│ └──nil
3
│ ┌──2
└──1
 └──0

Tree after removing root:
┌──5
4
│ ┌──2
└──1
 └──0
```

## Key points

- BST는 정렬된 데이터를 다루는 데에 있어 매우 강력한 자료 구조입니다.
- BST의 요소들은 비교가 가능해야 합니다. generic constraint나 클로저를 통해 비교를 수행할 수 있습니다.
- BST에서의 삽입, 제거, 탐색은 O(log n)의 시간 복잡도를 가집니다.
- 만약 트리가 불균형하다면 O(n)의 시간 복잡도를 가질 것입니다. 이는 16장의 AVL 트리에서 다룰 예정입니다.
