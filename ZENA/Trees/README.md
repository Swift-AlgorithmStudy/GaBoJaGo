
# Tree
노드들이 나무가지처럼 연결된 비선형 계층적 자료구조

다음과 같은 상황에서 주로 트리를 사용
- 계층 관계를 표현할 때
- 정렬된 데이터를 관리할 때
- 빠른 lookup 작업이 필요할 때


## Terminology
- Node
각각의 노드는 데이터를 가지며 child 노드들을 추적

- Parent & Child
트리는 top으로부터 bottom으로 가지가 뻗어나가는 구조이다.

최상단 노드를 제외하고 모든 노드는 하나의 상위 노드와 연결된다. 그 상위 노드를 parent node라고 부른다. Parent node 아래에 직접 연결되어 있는 노드들은 child nodes라 부르며, 트리에서 모든 child는 하나의 parent를 가진다.

- Root
트리의 최상단 노드로 root라 부른다. 이는 부모가 없는 유일한 노드이다.

- Leaf
자식 노드가 없는 트리의 가장 마지막 노드들을 leaf라고 표현한다.


## 순회 알고리즘 Traversal Algorithm
배열이나 linked list처럼 선형 컬렉션을 반복하는 것은 직관적이다. 

선형 컬렉션은 명확한 시작과 끝이 있다.

트리를 통해 반복하는 것은 조금 더 복잡하다.

트리에서 Traversal strategy는 어떤 문제를 해결하려고 하는지에 따라 그 방법이 다양하다.


### depth-first traversal 깊이 우선 탐색

---
# Binary Tress

이진트리는 왼쪽과 오른쪽, 최대 두개의 자식노드를 가진다. 

많은 트리 구조와 알고리즘의 기반이다.

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
var tree: BinaryMode<Int> = {
    let zero = BinaryNode(value: 0)
    let one = BinaryNode(value: 1)
    let five= BinaryNode(value: 5)
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

- 중위 순회 in-order
- 전위 순회 pre-order
- 후위 순회 post-order
