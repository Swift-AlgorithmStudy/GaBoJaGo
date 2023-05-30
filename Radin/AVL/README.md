# Chap7. AVL

이전 장에서, 이진탐색트리의 O(log n) 특성에 대해 배웠습니다. 또한 불균형한 트리가 트리의 성능을 O(n)까지 악화시킬 수 있다는 것을 배웠습니다. 

이번 챕터에서는 이진탐색트리의 균형이 성능에 어떤 영향을 미치고 AVL 트리를 구현할 수 있는 방법에 대해 알아볼 것입니다!

## 1. 균형 이해하기

균형 잡힌 트리는 이진 검색 트리의 성능을 최적화하는 열쇠라고 할 수 있습니다. 이번에는 균형의 세 가지 주요 상태에 대해 배우게 될 것입니다.

### 1) Perfect balance 완전 균형

이진 검색 트리의 이상적인 형태는 완벽하게 균형 잡힌 상태입니다. 

**트리의 모든 레벨이 노드로 채워져 있는 상태**를 의미합니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d39eb70b-e473-4fcc-a0f0-f271e0e500b4" alt="Image" width="300">

트리는 완벽하게 대칭일 뿐만 아니라, 하단의 노드는 완전히 채워졌습니다.

### 2) "Good-enough" balance 충분한 균형

 바닥 레벨을 제외한 모든 레벨을 채워진 상태를 의미합니다.

완벽한 균형을 이루는 것이 이상적이긴 하지만, 그런 경우는 거의 없습니다. 완벽하게 균형 트리는 모든 레벨을 맨 아래까지 채우기 위해 정확한 수의 노드를 포함해야 하므로, 특정 수에서만 완벽할 수 있습니다.

예를 들어, 1, 3, 7개의 노드를 가진 나무는 완벽하게 균형을 이룰 수 있지만, 2, 4, 5, 6개의 노드를 가진 나무는 마지막 레벨이 채워지지 않기 때문에 완벽하게 균형을 이룰 수 없습니다

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/7aa68409-0e05-4a58-a86b-46a5e21bb86a" alt="Image" width="300">

### 3) Unbalanced 비균형

불균형한 상태의 이진 검색 트리는 불균형의 정도에 따라 다양한 수준의 성능 손실을 겪는다.

 AVL 트리는 트리가 불균형해질 때 트리의 구조를 조정하여 균형을 유지합니다.

## 2. Implementation 구현

이진 검색 트리와 AVL 트리는 대부분이 비슷하며, 추가할 것은 밸런싱 구성 요소뿐입니다.

### 1) Measuring balance

이진 트리의 균형을 유지하려면, 트리의 균형을 측정하는 방법이 필요합니다. AVL 트리는 각 노드의 높이 속성으로 이것을 달성합니다. 노드의 높이는 현재 노드에서 리프 노드까지의 가장 긴 거리입니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/932e9daf-e083-4994-afdf-32c868c1e9d7" alt="Image" width="300">

노드 자식의 상대적인 높이를 사용하여 특정 노드가 균형이 잡혀 있는지 여부를 결정할 것입니다. 각 노드의 왼쪽과 오른쪽 자식의 높이는 최대 1까지 달라야 합니다. 이 숫자는 균형 요소로 알려져 있습니다.

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

밸런스팩터는 왼쪽과 오른쪽 자식의 키 차이를 계산한다. 특정 자식이 nil이라면, 그 키는 -1로 간주됩니다.

다음은 AVL 트리의 예입니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/202adfcb-6060-425b-bbe5-f4a8f38ead65" alt="Image" width="400">

다이어그램은 균형 잡힌 트리를 보여줍니다. 하단을 제외한 모든 레벨이 채워져있습니다. 노드의 오른쪽에 있는 숫자는 각 노드의 높이를 나타내고, 왼쪽에 있는 숫자는 balanceFactor를 나타낸다.

다음은 40이 삽입된 트리입니다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/8b5a5dc0-0a4a-430a-a8b6-ea13d3b37a2b" alt="Image" width="400">

40을 트리에 삽입하면 균형을 잃은 트리가 됩니다. 균형 인수가 2 또는 -2 또는 그보다 더 극단적인 경우, 균형을 잃은 트리를 나타냅니다. 그러나 각 삽입 또는 삭제 후에 확인함으로써, 최대로 균형 인수의 크기가 2보다 크지 않도록 보장할 수 있습니다.

하나 이상의 노드가 잘못된 균형 인수를 가질 수 있지만, **균형이 깨진 노드 중 가장 아래에 있는 노드에만 균형 조정 절차를 수행**해야 합니다 → 25 노드

### 2)Rotations

이진탐색트리의 균형을 맞추려면 회전을 하면 됩니다. 트리의 균형을 잡을 수 있는 네 가지 방법에는 총 네 번의 회전이 있습니다. 이것들은 왼쪽 회전, 왼쪽-우 회전, 오른쪽 회전 및 오른쪽-왼쪽 회전입니다.

**Left rotation**

위에서 나무에 40을 삽입함으로써 발생하는 불균형은 왼쪽 회전으로 해결할 수 있습니다. 노드 x의 일반적인 왼쪽 회전은 다음과 같습니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/881083a5-f3cf-433d-a993-c199b71d714e" alt="Image" width="400">

세부 사항에 들어가기 전에, 이 전후 비교에서 두 가지 요점이 있습니다:

- 이 노드에 대한 inorder 횡단은 동일하게 유지됩니다. (오름차순)
- 트리의 깊이는 회전 후 한 단계 감소한다.

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

1. 오른쪽 자식이 피벗으로 선택된다. 이 노드는 회전된 노드를 하위 트리의 루트로 대체할 것이다(레벨을 올라갈 것이다).
2. 회전할 노드는 피벗의 왼쪽 자식이 될 것이다(수준 아래로 이동한다). 이것은 피벗의 현재 왼쪽 자식이 다른 곳으로 옮겨져야 한다는 것을 의미한다.
이전 이미지에 표시된 일반적인 예에서, 이것은 노드 b이다. B는 y보다 작지만 x보다 크기 때문에, y를 x의 올바른 자식으로 대체할 수 있다. 그래서 당신은 회전된 노드의 오른쪽 자식을 피벗의 왼쪽 자식으로 업데이트합니다.
3. 피벗의 leftChild는 이제 회전된 노드로 설정할 수 있습니다.
4. 회전된 노드와 피벗의 높이를 업데이트합니다.
5. 마지막으로, 트리에서 회전된 노드를 대체할 수 있도록 피벗을 반환합니다.

이전 예에서 25의 왼쪽 회전의 결과입니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/3eba2236-78df-4671-bd8d-54251ea0d344" alt="Image" width="400">

**Right rotation**

오른쪽 회전은 왼쪽 회전의 정반대이다. 왼쪽 아이들이 불균형을 일으킬 때, 오른쪽 회전을 하면 된다.

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/de45050e-58c6-4afb-878d-13e5ee3ffed8" alt="Image" width="400">

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

이 알고리즘은 왼쪽과 오른쪽 자식에 대한 참조가 교환되는 것을 제외하고는 leftRotate의 구현과 거의 동일하다.

**Right-left rotation**

당신은 왼쪽과 오른쪽 회전이 모두 왼쪽 자식 또는 모든 오른쪽 자식인 노드의 균형을 이룬다는 것을 알아차렸을 것입니다. 36이 원래 예제 트리에 삽입된 경우를 고려하세요.

이 경우, 왼쪽 회전을 하는 것은 균형 잡힌 나무가 되지 않을 것이다. 이와 같은 경우를 처리하는 방법은 왼쪽 회전을 하기 전에 오른쪽 아이에게 오른쪽 회전을 수행하는 것입니다. 절차는 다음과 같습니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d236eef3-7a20-41ce-b875-2527b04dabf5" alt="Image" width="400">

 37에 오른쪽 회전을 적용합니다. 이제 노드 25, 36, 37은 모두 오른쪽 자식입니다. 트리의 균형을 맞추기 위해 왼쪽 회전을 적용할 수 있습니다.

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

**Left-right rotation**

왼쪽-오른쪽 회전은 오른쪽-왼쪽 회전의 대칭 반대이다. 여기 예시가 있습니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/91149052-a6d0-4b35-bfc7-a813e7ab595d" alt="Image" width="400">

1. 노드 10에 왼쪽 회전을 적용합니다.
2. 이제 노드 25, 15, 10은 모두 왼쪽 자식입니다. 나무의 균형을 맞추기 위해 오른쪽 회전을 적용할 수 있습니다.

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

### 3) 밸런스

이제, 올바른 위치에서 이 회전을 언제 적용해야 하는지 알아볼 것입니다.

다음 작업은 balanceFactor를 사용하여 노드에 밸런싱이 필요한지 여부를 결정하는 방법을 설계하는 것입니다. 

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

고려해야 할 세 가지 사례가 있다.

- 2의 밸런스 팩터는 왼쪽 아이가 오른쪽 아이보다 "무거움"(더 많은 노드 포함)임을 시사한다. 이것은 당신이 right 또는 left-right 회전을 사용하고 싶다는 것을 의미합니다.
- -2의 밸런스 팩터는 오른쪽 아이가 왼쪽 아이보다 무겁다는 것을 시사한다. 이것은 당신이 left 또는 right-left 회전을 사용하고 싶다는 것을 의미합니다.
- 그 외에는 특정 노드가 균형을 이루고 있음을 의미하므로, 노드를 반환하면 됩니다.

balanceFactor는 단일 또는 이중 회전이 필요한지 결정하는 데 사용될 수 있습니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/af5991e3-dadb-4213-a150-eb9bc226f87f" alt="Image" width="300">

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

Balance는 적절한 행동 방침을 결정하기 위해 balanceFactor를 검사합니다. 남은 것은 적절한 데에서 호출하는 것 뿐입니다.

### 4) Revisiting insertion

Insert(from:value:)를 다음으로 업데이트하세요:

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

삽입 후 바로 노드를 반환하는 대신, 균형 잡힌 노드로 전달합니다. 그것을 전달하면 콜 스택의 모든 노드가 밸런싱 문제를 확인할 수 있습니다. 또한 노드의 높이를 업데이트합니다.

### 5) Revisiting remove

 AVLTree에서, 최종 반환을 제거하고 다음과 같이 바꾸세요:

```swift
let balancedNode = balanced(node)
balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
return balancedNode
```

AVL 트리의 자체 균형 속성은 삽입 및 제거 작업이 O(log n) 시간 복잡도로 최적의 성능으로 작동한다는 것을 보장합니다.

## Key points

- 자체 균형 트리는 트리에 요소를 추가하거나 제거할 때마다 밸런싱 절차를 수행하여 성능 저하를 방지합니다.
- AVL 트리는 트리가 더 이상 균형을 이루지 않을 때 트리의 일부를 재조정하여 균형을 유지합니다.
- 균형은 노드 삽입 및 제거 시 네 가지 유형의 트리 회전에 의해 달성된다.
