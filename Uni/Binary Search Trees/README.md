# Chapter 14: Binary Search Trees

- 이진 탐색 트리(BST, Binary Search Trees)는 빠른 조회, 삽입, 삭제를 지원하는 데이터 구조 (평균시간복잡도 O(logn))
- 이진 탐색 트리는 이전 장에서 본 이진 트리에 두 가지 규칙을 부여합니다
    1. 왼쪽 자식의 값은 부모의 값보다 작아야 합니다
    2. 따라서 오른쪽 자식의 값은 부모의 값보다 크거나 같아야 합니다
- 이진 탐색 트리는 위의 두가지 특성을 통해 불필요한 검사를 수행하지 않도록 도와줍니다

<img width="564" alt="스크린샷 2023-05-23 오전 9 04 30" src="https://github.com/zhunhe/zhunhe/assets/22979718/31b22ecb-64ad-4e47-a2a4-5c7d54a03274">


# 배열과의 비교

## 탐색

### 배열

- 정렬되지 않은 배열은 전체 원소를 순회하며 찾아야 합니다
- 시간복잡도 O(n)

<img width="500" alt="스크린샷 2023-05-23 오전 10 46 00" src="https://github.com/zhunhe/zhunhe/assets/22979718/93b089b5-a4f8-438a-a43f-568e870e3a67">

### 이진 탐색 트리

- 이진 탐색 트리에서의 탐색은 검색 값이 현재 값보다 작으면 왼쪽 서브트리, 크면 오른쪽 서브트리에 있습니다.
전체 노드를 다 탐색할 필요 없이 절반씩 줄여나갈 수 있습니다.
- 시간복잡도 O(logn)

<img width="400" alt="스크린샷 2023-05-23 오전 10 46 32" src="https://github.com/zhunhe/zhunhe/assets/22979718/183653bb-eca0-492b-9926-1ec5f8c6543a">

```swift
public func contains(_ value: Element) -> Bool {
	var current = root // 탐색시작 노드 current에 저장
	while let node = current { // Leaf 노드까지 탐색
		if node.value == value { // 탐색 성공!
			return true
		}
		if value < node.value {
			current = node.leftChild
		} else {
			current = node.rightChild
		}
	}
	return false // 탐색 실패!
}
```

## 삽입

### 배열

- 배열에 값을 삽입하는 것은 이미 존재하는 줄에 끼어들듯한 동작입니다.
선택한 위치 앞에 0을 삽입하면, 나머지 모든 요소가 한 자리씩 뒤로 이동하여 공간을 만들어야 합니다.
- 시간복잡도 O(n)

<img width="500" alt="스크린샷 2023-05-23 오후 12 22 53" src="https://github.com/zhunhe/zhunhe/assets/22979718/a4f9b4a3-db09-49ab-b181-e0cbec57a72a">

### 이진 탐색 트리

- BST의 규칙을 활용하면, 삽입 위치를 찾기 위해 세 번의 순회만 하면 됩니다.
- 모든 요소를 이동시킬 필요가 없습니다!
- 시간복잡도 O(logn)

<img width="400" alt="스크린샷 2023-05-23 오후 12 23 25" src="https://github.com/zhunhe/zhunhe/assets/22979718/1ba0c328-b917-419e-968d-c2a0a32e7fa0">

```swift
extension BinarySearchTree {
	public mutating func insert(_ value: Element) {
		root = insert(from: root, value: value)
	}
	private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
		guard let node = node else { // nil 이면 비어있다는 뜻이므로 추가한다
			return BinaryNode(value: value)
		}
		if value < node.value { // 추가할 요소가 현재 노드 값보다 작은 경우
			node.leftChild = insert(from: node.leftChild, value: value)   // Leaf Node 왼쪽에 추가
		} else {
			node.rightChild = insert(from: node.rightChild, value: value) // Leaf Node 오른쪽에 추가
		}
		return node
	}
}
```

## 삭제

### 배열

- 삽입과 마찬가지로, 배열에서 요소를 제거하는 것도 요소들을 앞으로 한칸씩 땡겨주는 작업이 필요합니다
- 시간복잡도 O(n)

<img width="500" alt="스크린샷 2023-05-23 오후 12 24 16" src="https://github.com/zhunhe/zhunhe/assets/22979718/bd6c415c-51af-4619-b1fc-090e7095c037">

### 이진 탐색 트리

- 노드가 자식을 가지고 있는 경우에는 케이스에 따라 다르게 처리해주어야 하는 문제가 있지만,
이진 탐색 트리에서 요소를 제거하는 것은 배열에 비해 빠르게 처리가 가능합니다.
- 시간복잡도 O(logn)

<img width="400" alt="스크린샷 2023-05-23 오후 12 24 38" src="https://github.com/zhunhe/zhunhe/assets/22979718/1ddda2c9-6eb1-4418-96e8-e68f6614ee82">

### 케이스1: 리프 노드

- 제거할 요소가 리프 노드에 있는 경우는 단순하게 리프 노드를 제거하면 됩니다.

<img width="400" alt="스크린샷 2023-05-23 오후 12 48 34" src="https://github.com/zhunhe/zhunhe/assets/22979718/e8d847d7-7018-4643-8d08-429818a0288e">

### 케이스2: 자식 노드 하나만 있는 경우

- 하나의 자식을 가진 노드를 제거할 때는 해당 하나의 자식을 나머지 트리와 다시 연결해줍니다.

<img width="400" alt="스크린샷 2023-05-23 오후 12 48 44" src="https://github.com/zhunhe/zhunhe/assets/22979718/751565f3-44be-4a0d-8f34-63949869b0a4">

### 케이스3: 자식 노드 두개 있는 경우

- 아래의 트리를 가지고 있고, 값 25를 삭제하고자 한다고 가정해 보겠습니다.
- 노드가 두 개의 자식을 가지는 경우가 약간 복잡하므로, 이 상황을 처리하는 방법을 더 잘 설명해 줄 수 있는 복잡한 예제 트리가 필요합니다.

<img width="400" alt="스크린샷 2023-05-23 오후 2 48 48" src="https://github.com/zhunhe/zhunhe/assets/22979718/4dda8067-8160-467d-b867-5a109a377267">

- 단순히 중간에 노드를 삭제해서 부모, 자식 노드를 연결하는 것은 문제가 발생할 수 있습니다.

<img width="400" alt="스크린샷 2023-05-23 오후 2 49 18" src="https://github.com/zhunhe/zhunhe/assets/22979718/a2372848-f741-4b5c-b6fd-69d500b99c8f">

- 자식 노드가 두 개 (12와 37) 있어 다시 연결해야 하지만 부모 노드는 하나의 자식만 가질 수 있습니다. 이 문제를 해결하기 위해 스왑 작업을 수행해줍니다.
- 두 개의 자식을 가진 노드를 제거할 때는, 제거한 노드를 그 오른쪽 부분 트리에서 가장 작은 노드로 대체합니다.

<img width="400" alt="스크린샷 2023-05-23 오후 2 50 02" src="https://github.com/zhunhe/zhunhe/assets/22979718/cd49cd39-fb7d-4652-8434-5cc3fafac824">

- 이로 인해 유효한 이진 탐색 트리가 생성됨을 강조해야 합니다.
- 스왑을 수행한 후에는 복사한 값을 단순히 삭제할 수 있습니다. 해당 값은 리프 노드이기 때문입니다.

<img width="400" alt="스크린샷 2023-05-23 오후 2 50 33" src="https://github.com/zhunhe/zhunhe/assets/22979718/68241e31-3a69-4b1a-8efe-ef2f16de8ccb">

이렇게 하면 두 개의 자식을 가진 노드를 제거할 수 있습니다.

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
	private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
		guard let node = node else {
			return nil
		}
		if value == node.value {
			// 케이스 1 노드가 리프 노드인 경우, 현재 노드를 삭제하기 위해 nil을 반환합니다.
			if node.leftChild == nil && node.rightChild == nil {
				return nil
			}
			// 케이스 2 노드가 왼쪽 자식을 가지지 않는 경우, 오른쪽 부분 트리를 다시 연결하기 위해 node.rightChild를 반환합니다.
			if node.leftChild == nil {
				return node.rightChild
			}
			// 케이스 2 노드가 오른쪽 자식을 가지지 않는 경우, 왼쪽 부분 트리를 다시 연결하기 위해 node.leftChild를 반환합니다.
			if node.rightChild == nil {
				return node.leftChild
			}
			// 케이스 3 이 경우에는 제거할 노드가 왼쪽과 오른쪽 자식을 모두 가지고 있는 경우입니다. 
			// 오른쪽 부분 트리에서 가장 작은 값을 제거할 노드의 값으로 대체합니다.
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

# Key Points

- 이진 탐색 트리는 정렬된 데이터를 저장하기 위한 강력한 데이터 구조입니다.
- 이진 탐색 트리의 요소들은 비교 가능해야 합니다.
- 이진 탐색 트리의 삽입, 삭제, 탐색의 평균 시간 복잡도는 O(log n)입니다.
- 트리가 균형을 잃으면 성능이 O(n)으로 저하될 수 있습니다.
16장에서 AVL 트리라는 자체 균형 이진 탐색 트리에 대해 알아볼 것입니다.
