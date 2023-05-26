# AVL Trees

지난 챕터에서 O(log n)의 시간 복잡도를 가진 BST에 대해 배웠습니다. 
하지만 O(n)의 성능까지 내려가는 불균형한 트리에 대해서도 배웠습니다.

1962년에 Georgy Adelson-Velsky와 Evgenii Landis는 AVL Tree라는 스스로 균형을 잡는 BST를 고안해내었습니다.

## Understanding balance

균형잡힌 트리(balanced tree)는 BST의 성능에서 매우 중요한 요소입니다.

이번 섹션에서 균형의 주요 특징에 대해 배워볼 예정입니다.

### Perfect balance

BST의 가장 이상적인 형태는 “완전히 균형잡힌(perfectly balanced)” 상태입니다. 기술적인 관점에서, 모든 층의 트리가 노드로 차있는 것을 의미합니다.

<img width="312" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/caf50997-fcba-42ba-a7e8-bc800ed134e2">

트리가 완벽하게 균형을 이루면서 아래 레벨 또한 완벽하게 채워져있습니다. 이것이 완벽하게 균형을 이루는 조건입니다.

### “Good-enough” balance

완벽한 균형을 이루는 것이 이상적이지만, 확률적으로 희귀한 경우입니다. 완벽하게 균형잡힌 트리는 모든 레벨을 밑까지 채우기 위해 정확한 수의 노드를 포함해야 하므로 특정한 개수의 요소로만 완벽할 수 있습니다.

예를 들어, 1,3,7의 노드는 완벽하게 균형잡혀있지만, 2,4,5,6은 마지막 계층의 노드가 채워지지 않기 때문에 완벽하게 균형잡힌 경우는 아닙니다.

<img width="266" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5fda640d-645f-48c7-b9f1-548817d0e09d">

균형잡힌 트리의 정의는 바닥 레벨을 제외하고 모든 노드가 채워져 있어야 한다는 것입니다.

대부분의 이진 트리에서는 이 경우가 최선일 것입니다.

### Unbalanced

불균형한 상태의 BST는 불균형의 정도에 따라 성능 저하가 일어날 수 있습니다.

<img width="354" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/cbf0a362-8f61-4d0c-a0bb-482944fde6c3">

트리를 균형있게 유지하는 것은 탐색, 삽입, 제거에 O(log n)의 시간 복잡도를 가질 수 있게 해줍니다. 
AVL 트리는 트리가 불균형해질 때 트리의 구조를 조정하면서 균형을 유지합니다

## Implementation

BST와 AVL 트리는 매우 유사하기 때문에 사실상 BST에서 균형 조정 요소만 추가하면 됩니다.

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

### Measuring balance

이진 트리를 균형잡히게 유지하려면, 트리의 균형을 측정하는 방법이 필요할 것입니다. AVL 트리는 각 노드의 높이를 통해 달성합니다. 트리에서 노드의 높이는 현재 노드에서 리프 노드에서 가장 긴 거리를 의미합니다.

<img width="289" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/df6c13ff-8e1a-49e6-aaed-6bac1e11535a">

특정 노드가 균형잡혀있는 지 확인하기 위해서 노드의 자식들의 상대적 높이를 사용할 것입니다. 
각 노드의 왼쪽, 오른쪽 자식의 높이는 기껏해야 1만큼의 차이를 가져야 합니다. 

이 숫자를 balance factor라고 합니다.

```swift
public var height = 0

public var balanceFactor: Int {
  leftHeight - rightHeight
}

public var leftHeight: Int {
  leftChild?.height ?? -1
}

public var rightHeight: Int {
  rightChild?.height ?? -1
}
```

balanceFactor는 왼쪽과 오른쪽 자식의 높이 차이점을 계산해줍니다. 만약 특정 자식이 없다면(nil), 높이는 -1이라고 가정합니다.

<img width="489" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/71a427ad-0eb0-48cd-b42d-f0441df54911">

위의 다이어그램은 균형잡힌 트리를 보여줍니다 - 바닥 계층을 제외하고 모든 계층이 채워져있습니다.

Q. 25 노드의 왼쪽 자식이 없는데 균형잡힌 트리인가?

A. 바닥 계층인 37 노드를 제외하게 되면 25, 50, 75만 남게 되는데, 이때를 봤을 때 균형잡힌 트리임 

—> 37 노드가 있다고 가정을 해서 25 노드의 왼쪽 자식이 없어서 불균형으로 생각하는 것이 아님!

- 노드 50의 Balance가 1인 이유
    
    50의 leftChild의 height == 1 , rightChild의 height == 0
    1 - 0 = 1
    
- 노드 25의 Balance가 -1인 이유
    
    leftChild가 없으므로 -1, rightChild == 0
    -1 - 0 = -1
    

여기서 40을 삽입해보겠습니다.

<img width="463" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/35dcdcae-2cc7-4c9a-8166-b1d464811157">

40을 추가하니 불균형한 트리가 되었습니다. 여기서 balanceFactor의 변화를 주목해보시기 바랍니다.

balanceFactor가 2와 -2 또는 더 극단적인 것은 불균형 정도를 나타냅니다. 

그러나 삽입 또는 삭제를 확인할 때, 값이 2이상으로 커지지 않음을 보장할 수 있습니다.

—> AVL Tree에서 balanceFactor의 절댓값이 2를 넘지 않는다 !!!

물론 하나 이상의 노드가 불균형 요인에 포함될 수 있지만, 불균형 요인이 포함된 바닥 계층의 노드에만 균형 조정 절차를 수행하면 됩니다. 

이곳에서 rotation이 수행됩니다.

## Rotations

rotations을 통해 BST를 균형있게 만들 수 있습니다.  

left rotation, left-right rotation, right rotation, right-left rotation이 있습니다.

### Left rotation

40이 삽입되어 된 불균형한 트리는 left rotation으로 해결될 수 있습니다. node x의 일반적인 left rotation은 다음과 같습니다.

left rotation은 오른쪽 자식들이 불균형을 야기할 때 수행할 수 있습니다.

<img width="500" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/434e4fad-6d1d-46fd-8107-2781ba6cace1">

구체적으로 설명하기 전에, 이 전후 비교에서 두 가지 요점이 있습니다.

- 이 노드들에 대한 중위순회는 똑같이 남아있습니다.
- rotation이 끝난 후, 이 트리에 대한 깊이가 1로 줄어듭니다.

```swift
private func leftRotate(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  // 1
  let pivot = node.rightChild!
  // 2
  node.rightChild = pivot.leftChild
  // 3
  pivot.leftChild = node
  // 4
  node.height = max(node.leftHeight, node.rightHeight) + 1
  pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
  // 5
  return pivot
}
```

left rotation을 하기 위한 몇 가지 단계가 존재합니다.

1. 오른쪽 자식은 pivot(중심점)으로 선택됩니다. 이 노드는 회전된 노드를 하위 트리의 루트로 대체합니다(한 단계 위로 이동합니다).
2. 회전할 노드는 pivot의 왼쪽 자식 노드가 됩니다(한 단계 아래로 이동). 이는 pivot의 현재 왼쪽 자식이 다른 곳으로 이동해야 함을 의미합니다. 

위 이미지에서는 노드 B입니다. B는 y보다 작지만 x보다 크기 때문에 x의 오른쪽 자식으로 대체할 수 있습니다. 따라서 회전된 노드의 오른쪽 자식을 pivot의 왼쪽 자식으로 업데이트합니다.

3. pivot의 왼쪽 자식은 회전된 노드로 설정될 수 있습니다.
4. pivot과 회전된 노드의 높이를 업데이트합니다.
5. 마지막으로, pivot을 반환하며 트리의 회전된 노드를 대체할 수 있습니다.

<img width="431" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/7c93585d-8048-476e-84c7-38c49a1d6547">

- 노드 25에 대해 left rotation을 진행한다고 하면, 노드 37이 pivot이 되고, 루트로 대체됩니다.
- 회전할 노드인 노드 25는 pivot의 왼쪽 자식이 됩니다.

—> 위 식에서는 37의 leftChild가 없어서 2번식이 진행되지 않은 것 처럼 보임(헷갈린 부분)

### Right rotation

right rotation은 left rotation의 반대입니다. 왼쪽 자식이 불균형을 야기한다면, right rotation을 하면됩니다.

<img width="464" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/c88838da-5832-4d81-b571-2f8c84c7bdc2">

```swift
private func rightRotate(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  let pivot = node.leftChild!
  node.leftChild = pivot.rightChild
  pivot.rightChild = node
  node.height = max(node.leftHeight, node.rightHeight) + 1
  pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
  return pivot
}
```

- left rotation에서 왼쪽, 오른쪽이 변경된 것만 제외하면 거의 같습니다.

### Right-left-rotation

left, right rotation은 모든 왼쪽 또는 오른쪽 자식일 때의 균형을 맞추는 것이라고 눈치챘을 것입니다.

만약 예제 트리에서 36이 추가되었을 때를 고려해보겠습니다.

<img width="218" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/576e6a44-ae7c-4dc5-8f0b-fec21d085272">

이 경우에 left rotation을 해도 균형잡히지 않습니다. 이러한 경우를 다루기 위해서는 left location을 하기 전에 오른쪽 자식에서 right location을 진행하는 것입니다.

<img width="654" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/1d2d12e6-3c97-4386-b980-4978a69f124c">

1. 37에 대해 right rotation을 진행합니다.
2. 그러면 노드 25, 36, 37이 모두 오른쪽 자식이 되었기 때문에 left rotation을 적용할 수 있습니다.

```swift
private func rightLeftRotate(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  guard let rightChild = node.rightChild else {
    return node
  }
  node.rightChild = rightRotate(rightChild)
  return leftRotate(node)
}
```

### Left-right rotation

Left-right rotation 또한 right-left rotation의 반대입니다. 

<img width="485" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/4f74ea65-029a-4737-8ec0-4898f0b61e7c">

1. 노드 10에 left rotation을 적용합니다.
2. 25, 15, 10이 모두 왼쪽 자식이 되었기 때문에 right rotation을 적용할 수 있습니다.

```swift
private func leftRightRotate(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  guard let leftChild = node.leftChild else {
    return node
  }
  node.leftChild = leftRotate(leftChild)
  return rightRotate(node)
}
```

### Balance

그 다음은 노드가 밸런싱이 필요한 지에대해 결정하는 메소드를 설계하는 것입니다.

```swift
private func balanced(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  switch node.balanceFactor {
  case 2:
    // ...
  case -2:
    // ...
  default:
    return node
  }
}
```

3가지에 대해 고려해야 합니다.

1. 2의 balanceFactor는 오른쪽 자식에 비해 왼쪽 자식이 더 무겁다(더 많은 노드를 포함하고 있다)는 것으로,
right이나 left-right rotation을 사용해야 합니다.
2. -2의 balanceFactor는 오른쪽 자식이 더 무겁다는 것으로, left나 right-left rotation을 사용해야 합니다.
3. 기본 케이스는 특정 노드가 균형이 맞다고 가정합니다. 그냥 노드를 반환하면 됩니다.

balanceFactor의 기호는 rotation이 필요한지 결정해줍니다.

<img width="373" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3d622d60-8da8-47c3-b246-95dde2e2f90a">

```swift
private func balanced(_ node: AVLNode<Element>)
  -> AVLNode<Element> {

  switch node.balanceFactor {
  case 2:
    if let leftChild = node.leftChild,
           leftChild.balanceFactor == -1 {
      return leftRightRotate(node)
    } else {
      return rightRotate(node)
    }
  case -2:
    if let rightChild = node.rightChild,
           rightChild.balanceFactor == 1 {
      return rightLeftRotate(node)
    } else {
      return leftRotate(node)
    }
  default:
    return node
  }
}
```

balanced는 balanceFactor를 검사하여 적절한 행동을 결정합니다. 

### Revisiting insertion

```swift
private func insert(from node: AVLNode<Element>?,
                    value: Element) -> AVLNode<Element> {
  guard let node = node else {
    return AVLNode(value: value)
  }
  if value < node.value {
    node.leftChild = insert(from: node.leftChild, value: value)
  } else {
    node.rightChild = insert(from: node.rightChild, value: value)
  }
  let balancedNode = balanced(node)
  balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
  return balancedNode
}
```

삽입 후에 바로 노드를 반환하는 대신에, balanced에 보냅니다. 이는 균형 이슈에 대해 확인할 수 있도록 합니다.

```swift
example(of: "repeated insertions in sequence") {
  var tree = AVLTree<Int>()
  for i in 0..<15 {
    tree.insert(i)
  }
  print(tree)
}

---Example of: repeated insertions in sequence---
  ┌──14
 ┌──13
 │ └──12
┌──11
│ │ ┌──10
│ └──9
│  └──8
7
│  ┌──6
│ ┌──5
│ │ └──4
└──3
 │ ┌──2
 └──1
  └──0
```

### Revisiting remove

remove는 insert와 비슷합니다.

```swift
let balancedNode = balanced(node)
balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
return balancedNode
```

```swift
example(of: "removing a value") {
  var tree = AVLTree<Int>()
  tree.insert(15)
  tree.insert(10)
  tree.insert(16)
  tree.insert(18)
  print(tree)
  tree.remove(10)
  print(tree)
}

---Example of: removing a value---
 ┌──18
┌──16
│ └──nil
15
└──10

┌──18
16
└──1
```

self-balancing은 insert나 remove를 할 때 O(log n)의 시간 복잡도를 가집니다.

## Key points

- self-balancing tree는 요소를 추가하거나 제거할 때마다 균형을 잡는 절차를 수행하여 성능 저하를 방지합니다.
- AVL Tree는 트리가 균형을 유지하지 않을 때 트리의 일부를 조정하여 균형을 유지하도록 합니다.
- 균형은 노드의 추가 및 제거에 있어 4가지의 트리 회전을 통해 이루어집니다.
