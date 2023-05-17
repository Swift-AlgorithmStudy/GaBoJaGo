# Chap4. Trees

트리는 매우 중요한 데이터 구조입니다. 다음과 같은 소프트웨어 개발의 여러 측면에서 사용됩니다

- 계층 구조(hierarchical relationship)를 표현하는 데 사용됩니다.
- 정렬된 데이터(sorted data)를 관리하는 데 사용됩니다.
- 빠른 검색 작업(fast lookup operations)을 가능하게 합니다.
<br></br>

## 1. 용어

- Node
    - 연결리스트처럼 트리는 노드로 구성되어 있습니다.
    - 각 노드는 데이터를 가지고 있으며 자식 노드를 추적합니다.
- Parent and child
    - 최상위 노드를 제외한 모든 노드는 바로 위에 있는 하나의 노드에 연결됩니다. 그 노드를 부모 노드(parent node)라고 합니다. 그것과 직접적으로 연결된 아래쪽의 노드들을 자식 노드(child nodes)라고 합니다. 트리에서 모든 자식 노드는 정확히 하나의 부모를 가지고 있습니다.
- Root
    - 트리의 최상단 노드는 트리의 루트라고 불립니다. 부모가 없는 유일한 노드입니다.
- Leaf
    - 자식이 없는 노드는 Leaf입니다.
    
<br></br>
## 2. 구현

```swift
//TreeNode.swift
public class TreeNode<T> {
  public var value: T
  public var children: [TreeNode] = []

  public init(_ value: T) {
    self.value = value
  }
	//child노드를 노드에 추가하는 메서드
	public func add(_ child: TreeNode) {
		children.append(child)
	}
}
```

각 노드는 값을 담당하며 배열을 사용하여 모든 자식 노드에 대한 참조를 보유합니다.

> 클래스 유형을 사용하여 TreeNode를 나타내는 것은 값의 의미론(value semantics)을 잃는 것을 의미합니다. 반면에, 이것은 나중에 사용할 노드에 대한 참조를 만드는 것이 간단해지는 것을 의미합니다.
> 
<br></br>
## 3. 트리 순회 알고리즘

배열이나 연결 리스트와 같은 선형 컬렉션을 반복하는 것은 간단합니다. 선형 컬렉션은 명확한 시작점과 끝점을 가지고 있습니다. 하지만 트리는 좀 더 복잡합니다.

서로 다른 트리와 문제에 대해 여러 전략이 있습니다.

### 깊이 우선 순회(depth-first traversal)

이 기술은 루트에서 시작하여 백트래킹하기 전까지 최대한 깊은 노드를 방문하는 기법입니다.

```swift
extension TreeNode {
  public func forEachDepthFirst(visit: (TreeNode) -> Void) {
    visit(self)
    children.forEach {
      $0.forEachDepthFirst(visit: visit)
    }
  }
}
```

이 코드는 재귀를 사용하여 다음 노드를 처리합니다.

재귀로 구현되는 것을 원하지 않는다면 자신만의 스택을 사용할 수 있습니다.

### Level-order traversal

노드의 깊이에 따라 트리의 각 노드를 방문하는 기술입니다.

```swift
extension TreeNode {
  public func forEachLevelOrder(visit: (TreeNode) -> Void) {
    visit(self)
    var queue = Queue<TreeNode>()
    children.forEach { queue.enqueue($0) }
    while let node = queue.dequeue() {
      visit(node)
      node.children.forEach { queue.enqueue($0) }
    }
  }
}
```

노드를 올바른 레벨 순서대로 방문하도록 큐(스택x)를 사용했다는 점에 유의하세요. 

단순한 재귀(암묵적으로 스택을 사용하는)는 작동하지 않았을 것입니다!

### Search

이미 모든 노드를 반복하는 메서드가 있으므로 검색 알고리즘을 구축하는 데 시간이 많이 걸리지 않을 것입니다.

```swift
extension TreeNode where T: Equatable {
  public func search(_ value: T) -> TreeNode? {
    var result: TreeNode?
    forEachLevelOrder { node in
      if node.value == value {
        result = node
      }
    }
    return result
  }
}
```
<br></br>
## 🗝️ Key points

- 트리는 연결 리스트와 유사하지만 트리 노드는 많은 자식 노드에 연결될 수 있습니다. 반면, 연결 리스트 노드는 단 하나의 다음 노드에만 연결될 수 있습니다.
- 루트 노드를 제외한 모든 트리 노드는 정확히 하나의 부모 노드를 갖습니다.
- 루트 노드는 부모 노드가 없습니다.
- 리프 노드는 자식 노드가 없습니다.
- 깊이 우선 순회 및 레벨 순서 순회와 같은 순회 방법은 일반 트리에만 적용되는 것은 아닙니다. 다른 종류의 트리에서도 작동하지만 트리가 구조화되는 방식에 따라 구현 방법이 약간 다를 수 있습니다.
