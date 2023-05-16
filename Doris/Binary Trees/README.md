# Binary Trees

각각의 노드가 최대 **두 개의 자식 노드**를 가지는 트리 구조로, </br>
자식 노드를 각각 왼쪽 자식 노드와 오른쪽 자식 노드라고 합니다. </br>
</br>
</br>

## 💡 Implementation

```swift
public class BinaryNode<Element> {
    var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?

    public init(value: Element) { 
        self.value = value
  }
}

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
</br>

위 코드는 다음과 같은 트리를 정의 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/MC2_Morning_0404/assets/93391058/e810d379-d77f-46c2-8bce-0cc00f0a63fa">
</br>
</br>

### Building a diagram

```swift
extension BinaryNode: CustomStringConvertible {
    
    public var description: String {
        diagram(for: self)
    }

    private func diagram(for node: BinaryNode?,
                        _ top: String = "",
                        _ root: String = "",
                        _ bottom: String = "") -> String {
        
        // 1
        guard let node = node else {
            return root + "nil\n"
        }

        // 2
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        } 

        //3 
        return diagram(for: node.rightChild,
                        top + " ", top + "┌──", top + "│ ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild,
                        bottom + "│ ", bottom + "└──", bottom + " ")
    } 
}
```
</br>

1. node 언래핑 -> nil일 경우 nil 반환
자식이 없는 노드 (leaf 노드)를 처리하는 부분 </br>

2. node가 단말 노드인지 확인하는 조건문 
단말 노드 : 해당 노드가 좌우 자식 노드를 갖지 않는 노드 </br>
단말 노드일 경우 해당 노드의 값 반환 </br>

3. 전체 다이어그램 생성

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/6f9edfe3-8cfa-4816-8649-6a4c25610de9"> </br>

</br>

## 💡 Traversal algorithms

> 이진 트리의 순회 알고리즘에 대해 알아보자 ! </br>
</br>

### In-order traversal (중위 순회)

왼쪽 서브트리 -> 현재 노드 -> 오른쪽 서브트리 </br>
이 방식으로 이진 트리의 모든 노드를 **왼쪽부터 오름차순**으로 방문 합니다. </br>

1. 시작 = 루트 노드
2. 현재 노드가 왼쪽 자식 노드를 가지고 있다면, 이 노드를 먼저 재귀적으로 방문
3. 그럼 다음 현재 노드를 방문
4. 현재 노드가 오른쪽 자식 노드를 가지고 있다면, 이 노드를 재귀적으로 방문

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/e3019f70-b040-4d61-b886-319d4bf3054c">
</br>

```swift
extension BinaryNode {
    
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

example(of: "in-order traversal") {
    tree.traverseInOrder { print($0) }
}
```
</br>

> 결과 </br>
<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/0df1a94f-59d6-44a1-b70f-8fe3311387e7">

</br></br>

### Pre-order traversal (전위 순회)

현재 노드 -> 왼쪽 서브트리 -> 오른쪽 서브트리 </br>

1. 현재 노드의 값을 방문하고 작업 수행
2. 왼쪽 자식 노드를 전위 순회
3. 오른쪽 자식 노드를 전위 순회

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/b7d62994-e56d-43ef-8193-65dddc621f0d"> </br>

```swift
public func traversePreOrder(visit: (Element) -> Void) {
    visit(value)
    leftChild?.traversePreOrder(visit: visit)
    rightChild?.traversePreOrder(visit: visit)
}

example(of: "pre-order traversal") {
    tree.traversePreOrder { print($0) }
}
```
</br>
<img  width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/bb769ef1-5cad-4902-b2b3-df0c3dd91269"> </br>
</br>

### Post-order traversal (후위 순회)

왼쪽 서브트리 -> 오른쪽 서브트리 -> 현재 노드 </br>

1. 왼쪽 자식 노드 후위 순회
2. 오른쪽 자식 노드 후위 순회
3. 현재 노드의 값 방문하고 작업 수행

</br>

<img width="60%" height="60%"  alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/4ee1f946-4d8e-404b-90ed-e7baad838490">
</br>
</br>

*  각각의 순회 알고리즘은 O(n)의 시간 복잡도와 공간 복잡도를 가지고 있습니다.
</br></br>

## 💡 Key Points
> 중요 중요 중요 ! </br>

* 이진 트리는 가장 중요한 트리 구조 중 일부의 기반이 됩니다. 이진 탐색 트리와 AVL 트리는 삽입 및 삭제 동작에 제한을 둔 이진 트리입니다.

* 중위, 전위 및 후위 순회 알고리즘은 트리의 구조를 탐색하고 노드를 효율적으로 처리하는 데에 중요한 역할을 합니다.