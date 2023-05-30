# Chapter 16: AVL Trees

이전 장에서는 이진 탐색 트리의 O(log n) 성능 특성에 대해 배웠습니다. 그러나 균형이 맞지 않은 트리는 트리의 성능을 O(n)까지 저하시킬 수 있다는 것도 알게 되었습니다. 1962년에 Georgy Adelson-Velsky와 Evgenii Landis가 최초의 자가 균형 이진 탐색 트리인 AVL 트리를 고안했습니다. 이번 장에서는 이진 탐색 트리의 균형이 어떻게 성능에 영향을 미치는지 자세히 살펴보고, AVL 트리를 처음부터 구현해보겠습니다!

## 균형 이해

균형 잡힌 트리는 이진 탐색 트리의 성능을 최적화하는 핵심입니다. 이 섹션에서는 균형의 세 가지 주요 상태에 대해 배우게 될 것입니다.

### 완벽한 균형

이진 탐색 트리의 이상적인 형태는 완벽히 균형 잡힌 상태입니다. 트리의 루트 노드부터 맨 아래까지 모든 레벨에 노드가 가득 차 있는 것을 의미합니다.

<img width="300" alt="스크린샷 2023-05-30 오전 4 32 13" src="https://github.com/zhunhe/zhunhe/assets/22979718/793aa27c-ea4f-4ea2-a672-e7bb65887f37">

### "충분히 좋은" 균형

완벽한 균형을 달성하는 것은 이상적이지만, 실제로는 드뭅니다. 완벽히 균형 잡힌 트리는 맨 아래까지 모든 레벨을 채울 만큼의 정확한 노드 수를 가져야 하므로, 특정한 수의 요소만 가지고 완벽히 균형 잡힌 상태가 될 수 있습니다.

예를 들어, 1, 3, 또는 7개의 노드로 이루어진 트리는 완벽히 균형 잡힌 상태가 될 수 있지만, 2, 4, 5, 또는 6개의 노드로 이루어진 트리는 완벽히 균형 잡힌 상태가 될 수 없습니다. 왜냐하면 트리의 마지막 레벨이 채워지지 않기 때문입니다.

<img width="300" alt="스크린샷 2023-05-30 오전 4 32 56" src="https://github.com/zhunhe/zhunhe/assets/22979718/375762a9-01ea-4479-91a8-1d1aac21be82">

균형 잡힌 트리의 정의는 맨 아래 레벨을 제외한 모든 레벨이 채워져 있어야 한다는 것입니다. 대부분의 이진 트리에서는 이것이 최선의 해결 방법입니다.

### 균형이 맞지 않은 상태

마지막으로, 균형이 맞지 않은 상태가 있습니다. 이 상태의 이진 탐색 트리는 균형의 정도에 따라 다양한 수준의 성능 저하를 겪게 됩니다.

<img width="300" alt="스크린샷 2023-05-30 오전 4 34 14" src="https://github.com/zhunhe/zhunhe/assets/22979718/21999b9a-3827-4d86-92d2-8a2facd1238b">

트리를 균형있게 유지하면 find, insert, remove 연산의 시간 복잡도가 O(log n)가 됩니다. AVL 트리는 트리가 균형을 잃을 때 트리의 구조를 조정하여 균형을 유지합니다. 이번 장을 진행하면서 이것이 어떻게 작동하는지 알아보게 될 것입니다.

## 구현

### 균형 측정

균형을 측정하기 위해 이진 트리의 높이를 측정하는 방법이 필요합니다. AVL 트리는 각 노드에 height 속성을 사용하여 이를 달성합니다. 노드의 높이는 현재 노드에서 가장 먼 리프 노드까지의 거리를 의미합니다.

<img width="300" alt="스크린샷 2023-05-30 오전 4 36 14" src="https://github.com/zhunhe/zhunhe/assets/22979718/2e5d3869-c6ca-4863-89ba-432f2253ce3d">

```swift
public var height = 0
```

특정 노드가 균형 잡혀 있는지 확인하기 위해 노드의 자식들의 상대적인 높이(relative height of a node’s children)를 사용합니다. 각 노드의 왼쪽 자식과 오른쪽 자식의 높이 차이는 최대 1이어야 합니다. 이 숫자를 균형 인수(balance factor)라고 합니다.

```swift
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

balanceFactor는 왼쪽 자식과 오른쪽 자식의 높이 차이를 계산합니다. 특정 자식이 nil인 경우 해당 자식의 높이는 -1로 간주합니다.

<img width="500" alt="스크린샷 2023-05-30 오전 4 38 16" src="https://github.com/zhunhe/zhunhe/assets/22979718/6a5ad498-eb5f-4983-a076-7eb628ad5b98">

다이어그램은 균형 잡힌 트리를 보여줍니다. 맨 아래 레벨을 제외한 모든 레벨이 채워져 있습니다. 노드 오른쪽에 있는 숫자는 각 노드의 높이를 나타내고, 왼쪽에 있는 숫자는 balanceFactor를 나타냅니다.
다음은 40이 삽입된 업데이트된 다이어그램입니다.

<img width="500" alt="스크린샷 2023-05-30 오전 4 38 51" src="https://github.com/zhunhe/zhunhe/assets/22979718/c0a045b9-b0f4-42fc-81d0-f31dd74651ea">

40를 트리에 삽입하면 Unbalanced tree가 됩니다. balanceFactor가 어떻게 변경되는지 주목하세요. balanceFactor가 2, -2 또는 그 이상의 값은 균형이 맞지 않은 트리를 나타냅니다. 하지만 각 삽입 또는 삭제 후에 확인함으로써, 균형이 더 이상 2의 절댓값보다 크게 되지 않도록 보장할 수 있습니다.
한 개 이상의 노드가 잘못된 균형 인수를 가질 수 있지만, 균형 조정 절차는 균형 인수가 잘못된 가장 하위 노드인 25를 포함하는 노드에서만 수행하면 됩니다.
여기서 회전이 필요해집니다.

## 회전

이진 탐색 트리를 균형있게 유지하기 위해 사용되는 절차들을 회전(rotations)이라고 합니다. 트리가 균형을 잃는 네 가지 다른 방법에 대해 총 네 가지 회전이 있습니다. 이들은 좌회전(left rotation), 좌-우회전(left-right rotation), 우회전(right rotation) 및 우-좌회전(right-left rotation)이라고 알려져 있습니다.

### 좌회전(left rotation)
****

40를 트리에 삽입함으로써 발생한 균형 잡힘이 좌회전을 통해 해결될 수 있습니다. 노드 x에 대한 일반적인 좌회전은 다음과 같습니다:

<img width="500" alt="스크린샷 2023-05-30 오전 4 40 11" src="https://github.com/zhunhe/zhunhe/assets/22979718/ac644044-5875-4d35-8134-8c658297fd0d">

이 전과 후의 비교를 통해 얻을 수 있는 두 가지 요점이 있습니다:

- 이러한 노드들에 대한 중위 순회(in-order traversal)는 동일합니다.
- 회전 이후에 트리의 깊이가 한 단계 감소합니다.

```swift
private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
	// 1 오른쪽 자식을 피벗으로 선택합니다.
	// 이 노드는 회전된 노드를 대체하여 서브트리의 루트로 이동합니다(레벨이 하나 올라갑니다).
	let pivot = node.rightChild!
	// 2 회전될 노드는 피벗의 왼쪽 자식이 됩니다(레벨이 하나 내려갑니다).
	// 이는 피벗의 현재 왼쪽 자식이 다른 곳으로 이동되어야 함을 의미합니다.
	// 이전 이미지의 일반적인 예시에서는 노드 b가 이에 해당합니다.
	// b는 y보다 작지만 x보다 크므로 x의 오른쪽 자식으로 y를 대체할 수 있습니다.
	// 따라서 회전된 노드의 rightChild를 피벗의 leftChild로 업데이트합니다.
	node.rightChild = pivot.leftChild
	// 3 피벗의 leftChild는 이제 회전된 노드로 설정됩니다.
	pivot.leftChild = node
	// 4 회전된 노드와 피벗의 높이를 업데이트합니다.
	node.height = max(node.leftHeight, node.rightHeight) + 1
	pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
	// 5 마지막으로, 피벗을 반환하여 트리에서 회전된 노드를 대체할 수 있도록 합니다.
	return pivot
}
```

이전 예시의 25에 대해 좌회전의 전후 효과는 다음과 같습니다.

<img width="500" alt="스크린샷 2023-05-30 오전 4 41 51" src="https://github.com/zhunhe/zhunhe/assets/22979718/b6ea3529-b4e1-4c92-bd01-40e2e1dc1cfa">

### 우회전(right rotation)
****

우회전은 좌회전의 대칭적인 반대 개념입니다. 연속적인 좌측 자식들이 균형을 깨뜨릴 때, 우회전을 수행해야 합니다.
노드 x의 일반적인 우회전은 다음과 같습니다.

<img width="500" alt="스크린샷 2023-05-30 오전 4 42 30" src="https://github.com/zhunhe/zhunhe/assets/22979718/6c2c948b-d54a-4355-b5a5-378abb520251">


이를 구현하기 위해, leftRotate 바로 다음에 다음 코드를 추가하세요.

```swift
private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
	let pivot = node.leftChild!
	node.leftChild = pivot.rightChild
	pivot.rightChild = node
	node.height = max(node.leftHeight, node.rightHeight) + 1
	pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
	return pivot
}
```

이 알고리즘은 leftRotate의 구현과 거의 동일하며, 좌우 자식에 대한 참조만 교체된다는 점이 다릅니다.

### 우-좌회전(right-left rotation)
****

왼쪽 회전과 오른쪽 회전은 모두 모든 노드가 왼쪽 자식이거나 모든 노드가 오른쪽 자식인 노드들을 균형있게 만드는 것을 알 수 있습니다. 36이 원래의 예시 트리에 삽입되는 경우를 고려해 보겠습니다.

<img width="300" alt="스크린샷 2023-05-30 오전 4 45 22" src="https://github.com/zhunhe/zhunhe/assets/22979718/cc2d6c0b-bdef-405b-86ed-079306e8898e">

이 경우 좌회전만 수행하면 균형 잡힌 트리가 되지 않습니다. 이와 같은 경우를 처리하는 방법은 좌회전을 수행하기 전에 오른쪽 자식에 대해 우회전을 수행하는 것입니다. 다음은 해당 절차의 모습입니다:

<img width="600" alt="스크린샷 2023-05-30 오전 4 45 48" src="https://github.com/zhunhe/zhunhe/assets/22979718/7c6fe529-751c-4c3d-87a3-c369de7ee109">

1. 37에 대해 우회전을 수행합니다.
2. 이제 노드 25, 36, 37이 모두 오른쪽 자식이므로 트리를 균형잡기 위해 좌회전을 적용할 수 있습니다.
rightRotate 바로 다음에 다음 코드를 추가하세요.

```swift
private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
	guard let rightChild = node.rightChild else {
		return node
	}
	node.rightChild = rightRotate(rightChild)
	return leftRotate(node)
}
```

지금은 언제 이를 호출해야 하는지에 대해 걱정하지 마세요. 곧 이에 대해 알아볼 것입니다. 먼저 마지막 경우인 좌-우회전을 처리해야 합니다.

### 좌-우회전(left-right rotation)
****

<img width="600" alt="스크린샷 2023-05-30 오전 4 47 12" src="https://github.com/zhunhe/zhunhe/assets/22979718/f5f58a58-4cdc-4a33-ac0e-76a847596be9">

1. 노드 10에 대해 좌회전을 수행합니다.
2. 이제 노드 25, 15, 10이 모두 왼쪽 자식이므로 트리를 균형잡기 위해 우회전을 적용할 수 있습니다.
rightLeftRotate 바로 다음에 다음 코드를 추가하세요.

```swift
private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
	guard let leftChild = node.leftChild else {
		return node
	}
	node.leftChild = leftRotate(leftChild)
	return rightRotate(node)
}
```

회전에 대한 내용은 여기까지입니다. 다음으로, 이러한 회전을 올바른 위치에서 적용해야 할 시기를 파악하게 될 것입니다.

## **균형**

다음 작업은 balanceFactor를 사용하여 노드가 균형 조정이 필요한지 여부를 결정하는 메소드를 설계하는 것입니다. leftRightRotate 아래에 다음 메소드를 작성하세요.

```swift
private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
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

고려해야 할 세 가지 경우가 있습니다.

1. balanceFactor가 2인 경우, 왼쪽 자식이 오른쪽 자식보다 "무거운" 상태(더 많은 노드를 포함)를 의미합니다. 따라서 우회전 또는 좌-우회전을 사용해야 합니다.
2. balanceFactor가 -2인 경우, 오른쪽 자식이 왼쪽 자식보다 더 무거운 상태를 의미합니다. 따라서 좌회전 또는 우-좌회전을 사용해야 합니다.
3. 기본적인 경우는 해당 노드가 균형 잡혀 있는 상태를 의미합니다. 여기서는 노드를 반환하는 것 외에는 할 일이 없습니다.
balanceFactor의 부호를 사용하여 단일 회전 또는 이중 회전이 필요한지를 결정할 수 있습니다.

<img width="400" alt="스크린샷 2023-05-30 오전 4 49 36" src="https://github.com/zhunhe/zhunhe/assets/22979718/f9069986-abd3-47a0-89d4-90798998a631">

다음과 같이 balanced 함수를 업데이트하세요.

```swift
private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
	switch node.balanceFactor {
	case 2:
		if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
			return leftRightRotate(node)
		} else {
			return rightRotate(node)
		}
	case -2:
		if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
			return rightLeftRotate(node)
		} else {
			return leftRotate(node)
		}
	default:
		return node
	}
}
```

balanced 함수는 balanceFactor를 검사하여 적절한 조치를 결정합니다. 남은 작업은 적절한 위치에서 balance를 호출하는 것뿐입니다.

## ****Revisiting insertion****

이미 대부분의 작업을 완료했습니다. 나머지는 꽤 간단합니다. insert(from:value:)를 다음과 같이 업데이트하세요.

```swift
// 1
private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
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

// 2
example(of: "repeated insertions in sequence") {
	var tree = AVLTree<Int>()
	for i in 0..<15 {
		tree.insert(i)
	}
	print(tree)
}
```

## ****Revisiting Remove****

AVLTree에서 Remove의 마지막 반환값을 삭제하고 아래의 값으로 변경합니다.

```swift
// 1
let balancedNode = balanced(node)
balancedNode.height = max(balancedNode.leftHeight,
balancedNode.rightHeight) + 1
return balancedNode

// 2
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
```

## **Key points**

- 자가 균형 트리는 요소를 추가하거나 제거할 때마다 균형 조정 절차를 수행함으로써 성능 저하를 피합니다.
- AVL 트리는 트리가 더 이상 균형을 유지하지 못할 때 트리의 일부를 재조정함으로써 균형을 유지합니다.
- 균형은 노드 삽입 및 제거 시에 네 가지 유형의 트리 회전을 통해 달성됩니다.