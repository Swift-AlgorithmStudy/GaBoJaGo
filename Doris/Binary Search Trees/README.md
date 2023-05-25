# Binary Search Trees
> 이진 탐색 트리에 대해 알아보자 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/89845986-5add-4bce-baaa-32c1413ce680"> </br>

* '이진 탐색 트리(Binary Search Tree, BST)'는 빠른 조회, 삽입 및 삭제 작업을 가능하게 하는 데이터 구조입니다.
* 위의 그림처럼 한 쪽을 선택하면 다른 쪽의 가능성을 모두 포기하게 되며, 가능성을 절반으로 줄이게 됩니다.

이진 탐색 트리에는 두 가지의 특징이 있습니다. </br>

1. **왼쪽 자식 노드**의 값은 부모 노드의 값보다 작아야 합니다.
2. **오른쪽 자식 노드**의 값은 부모 노드의 값보다 크거나 같아야 합니다.

이진 탐색 트리는 이러한 속성을 사용해 불필요한 확인 작업을 피할 수 있습니다. </br>
결과적으로, 조회, 삽입 및 삭제 작업의 평균 시간 복잡도는 `O(log n)`으로 배열이나 연결 리스트와 같은 선형 데이터 구조보다 훨씬 빠릅니다. </br>
</br>

## 💡 Case study : array vs BST
> 배열과 비교해보자 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/cb0eb750-1680-4bed-bd40-bf4dc9d2e9c7">

### 1. Lookup 

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/47b1435e-e523-43ad-b782-80b78a20b8d9"> </br>

정렬되지 않은 배열의 경우 처음부터 모든 요소를 확인해야 합니다. (linear search) </br>
따라서 배열의 array.contains(_:)는 `O(n)`의 시간 복잡도를 가지게 되고, 배열의 크기에 따라 시간 복잡도가 선형적으로 증가합니다. </br>


**이진 탐색 트리** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/c2bc0c50-0863-4120-9c3b-1cd6fb513ca8"> </br>

이진 탐색 트리는 노드 방문 시 다음 두가지의 성질을 지켜야 합니다. </br>

1. 검색 값이 현재 값보다 작을 경우, 왼쪽 하위 트리에 있어야 합니다.
2. 검색 값이 현재 값보다 클 경우, 오른쪽 하위 트리에 있어야 합니다.

BST의 성질을 활용하여 불필요한 확인 작업을 피하고, 결정을 내릴 때마다 검색 공간을 절반으로 줄일 수 있기 때문에 `O(log n)`의 시간 복잡도를 가집니다. </br>
</br>

### 2. Insertion 

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/d9ed325e-b23e-41d8-8ec5-2968089e28a8"> </br>

베열에서 값을 삽입할 경우, 이미 있는 공간에 끼어들듯이 동작하며, 추가 공간을 필요로 합니다. </br>

모든 요소가 한 자리씩 뒤로 밀려나게 되므로 `O(n)`의 시간 복잡도를 가집니다. </br>
</br>

**이진 탐색 트리** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/1eac899a-5ff2-4307-8bc6-d876531324e8">
</br>

이진 탐색 트리에서의 삽입은 모든 요소를 재배치할 필요가 없으므로 `O(log n)`의 시간 복잡도를 가지게 됩니다. </br>

</br>

### 3. Removal

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/030a4855-3221-4ba3-8409-052d6e3a621c"> </br>

요소를 삽입할 경우와 동일하게 모든 요소들을 이동시키는 작업이 필요합니다. </br>
삭제된 요소 뒤에 있는 요소들은 앞으로 이동해 빈 자리를 메우게 됩니다. </br>

**이진 탐색 트리** 
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/457e8b25-4c47-4501-988f-bb94e4b1da22"> </br>

제거하려는 노드가 자식 노드를 가질 경우 복잡한 문제가 있음에도 불구하고, `O(log n)`의 시간 복잡도를 가집니다. </br>
</br>

## 💡 Implementation
> 구현 해보자 ! </br>

```swift
public struct BinarySearchTree<Element: Comparable> {

  public private(set) var root: BinaryNode<Element>?

  public init() {}
}

// nil이 아닐 경우 'root'를 문자열로 변환하여 반환
extension BinarySearchTree: CustomStringConvertible {

  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}
```
</br>

이진 탐색 트리는 Comparable 프로토콜을 준수하는 값만을 저장할 수 있습니다. </br>
</br>

### Inserting elements

```swift
extension BinarySearchTree {

  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }

  private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
    
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
</br>

1. 
첫 번째 insert 매서드는 사용자에게 노출되는 (public) 매서드입니다. </br>
두 번째 매서드는 private 도우미(helper)매서드로 사용되며, 실제 삽입 작업을 수행합니다. </br>
insert 매서드는 재귀적인 방식으로 구현되어 있습니다. </br>
현재 노드가 `nil`인 경우에는 새로운 `BinaryNode`를 생성하여 해당 값을 가진 노드를 반환합니다. </br>
> 현재 노드가 `nil`인 경우는 삽입 지점을 찾았다는 것을 의미합니다. </br>
> 따라서 새로운 노드가 이진 탐색 트리에 삽입될 것이며, 이는 재귀적인 insert매서드 호출의 종료 조건입니다. </br>
> 그렇기 때문에 현재 노드가 nil인 경우에는 새로운 BinaryNode를 생성하여 해당 값을 가진 노드를 반환하는 것이 필요합니다. </br>
</br>

2. 
if 문은 다음 `insert`호출이 어느 방향으로 진행되어야 하는지 제어합니다. </br>
찾고자하는 값(value)이 현재 값(node.value)보다 작으면 왼쪽 자식 노드에서 `insert`를 호출합니다. </br>
반대로 찾고자하는 값이 현재 값보다 크거나 같다면 오른쪽 자식 노드에서 `insert`를 호출합니다. </br>
</br>

3. 
현재 노드를 반환합니다. </br>
insert는 node를 **생성**하거나 (만약 nil이었다면), node를 **반환**합니다.(만약 nil이 아니었다면) </br>

</br>

* 이진 탐색 트리에서는 항상 균형을 유지하는 것이 중요합니다.
* 균형 잡힌 트리는 탐색, 삽입, 삭제 작업에 대해 일관된 성능을 제공하며, 효율적인 데이터 구조로 사용될 수 있습니다. 

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/f583bdca-5fe3-4b5d-857a-b3784b09c3be">

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/f129e9e1-a0bf-471a-9643-d8dc0dbe83e1">

</br>

예를 들어, 이미 불균형한 트리에 순차적으로 1,2,3,4,5를 삽입한다고 가정하면, 불균형한 트리의 형태로 순차적으로 원소를 삽입하면 트리의 높이가 높아지게 됩니다. </br>
따라서 이진 탐색 트리의 핵심 이점인 O(log n)의 시간 복잡도가 유지되지 않고, 삽입 작업의 시간 복잡도가 O(n)으로 증가하게 됩니다. </br>

</br>

### Finding elements

```swift
public func contains(_ value: Element) -> Bool {
  // 1. current 변수를 루트 노드로 설정
  var current = root
  // 2. current 변수가 nil이 아닌 동안 현재 노드의 값을 확인
  while let node = current {
    // 3. 현재 노드의 값이 찾고자 하는 값 (value)와 일치할 경우 true 반환
    if node.value == value {
      return true
    }
    // 4-1. 찾고자 하는 값이 현재 노드의 값보다 작을 경우 current 변수를 왼쪽 자식 노드로 업데이트
    // 4-2. 클 경우 current 변수를 오른쪽 자식 노드로 업데이트
    if value < node.value {
      current = node.leftChild
    } else {
      current = node.rightChild
    }
  }
  return false
}
```
</br>

위의 contains 매서드는 균형 잡힌 이진 탐색 트리에서 O(log n )의 시간 복잡도를 가집니다. </br>
</br>

### Removing elements

**Case 1 : Leaf node** </br>
> leaf node를 제거하는 것은 간단합니다. </br>
> 부모 노드와 분리하면 됩니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/59b22b29-c88d-446a-ae77-563725f3cf7e">
</br>

**Case 2 : Nodes with one child** </br>
> 제거된 노드의 자식 노드를 나머지 트리에 연결해야 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/cc5427cd-d343-41dc-b2c3-6851b0ecd066"> </br>

**Case 3 : Nodes with two children** </br>
> 복잡함 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/5a0d3acb-7549-48b2-8c14-4f2cead06e84">
</br>

위의 사진에서 25 노드를 삭제한다고 가정합니다. </br>
제거해야 할 노드의 자식 노드가 두 개(12와 37)이 있으며, 부모 노드는 하나의 자식 노드만 가질 수 있습니다. </br>
</br>

대체되는 노드는 제거한 노드의 `오른쪽 서브트리의 가장 작은 노드` (왼쪽 서브트리의 가장 큰 노드)로 대체합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/41b353ab-9ec6-4efd-9009-62eea0964e70">
</br>

새로운 노드는 오른쪽 서브트리에서 가장 작은 노드이므로, 오른쪽 서브트리의 모든 노드는 여전히 새로운 노드보다 크거나 같을 것입니다.</br>
또한, 새로운 노드는 오른쪽 서브트리에서 왔으므로 왼쪽 서브트리의 모든 노드는 새로운 노드보다 작을 것입니다. </br>
이로써 이진 탐색 트리의 규칙을 유지하면서 제거 작업을 수행할 수 있습니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/Memories_Perfume/assets/93391058/54de81a5-9c13-4a1f-88f9-2d994e9176a6"> </br>

```swift
private extension BinaryNode {

  var min: BinaryNode {
    leftChild?.min ?? self
  }
}

extension BinarySearchTree {

  // 하위 트리에서 최소 노드를 찾습니다. 
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
```swift
// leaf node일 경우 nil을 반환하여 현재 노드를 제거
if node.leftChild == nil && node.rightChild == nil {
  return nil
}
// 왼쪽 자식 노드가 없을 경우 node.rightChild를 반환해 오른쪽 하위 트리를 다시 연결
if node.leftChild == nil {
  return node.rightChild
}
// 오른쪽 자식 노드가 없을 경우 node.leftChild를 반환해 오른쪽 하위 트리를 다시 연결
if node.rightChild == nil {
  return node.leftChild
}
// 두 개의 자식 노드가 있을 경우 
// 노드의 값을 오른쪽 하위 트리의 가장 작은 값으로 대체 한 후 오른쪽 하위 트리에서 해당 값을 제거
node.value = node.rightChild!.min.value
node.rightChild = remove(node: node.rightChild, value: node.value)
```
</br>
</br>

## 💡 Key Points
> 중요 중요 중요 ! </br>

* 이진 탐색 트리는 정렬된 데이터를 저장하기 위한 강력한 데이터 구조입니다.

* 이진 탐색 트리의 요소는 비교 가능해야 합니다. 이를 위해 제네릭 제약 조건을 사용하거나 비교를 수행하는 클로저를 제공할 수 있습니다.

* BST(Binary Search Tree)의 insert, remove, contains 메서드의 시간 복잡도는 `O(log n)`입니다.

* 트리가 균형을 잃게 되면 성능이 O(n)으로 저하됩니다.