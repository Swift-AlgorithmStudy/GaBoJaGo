# Trees

<img width="451" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/96c002d3-ccce-4c6c-a575-67aeca43d56a">

트리는 매우 중요한 자료구조로 **계층적 관계, 정렬된 데이터 관리, 빠른 검색 연산** 등 소프트웨어 개발에서 많이 사용됩니다,

크기와 모양에 따라 다양한 타입의 트리가 존재합니다. 

## 용어

### Node

링크드 리스트와 같이 트리는 노드로 구성되어 있습니다.

<img width="245" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/fb630ae3-a47d-40bb-bcf1-25f4c03ce7bd">

각각의 노드는 데이터를 포함하고 있으며, 자식 노드에 대해 알고 있습니다.

### Parent and child

트리는 위에서 아래 방향으로 뻗어나갑니다.

모든 노드들은 (가장 상단의 노드를 제외하고) 바로 위에는 정확히 하나의 노드와 이어져있습니다. 

이 노드를 부모 노드라고 하고, 바로 밑에 연결되어 있는 노드는 자식 노드라고 합니다.

트리에서는 모든 자식은 하나의 부모를 가집니다.

<img width="227" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/d95f6c44-270b-4819-9639-f6419bf71dba">

### Root

가장 상단의 노드를 root라고 부릅니다. 유일하게 부모가 없는 노드입니다.

<img width="302" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/be1b80fd-a2a5-47d7-b56b-1384bf8cd4d1">

### Leaf

만약 자식 노드가 없다면 그 노드는 leaf입니다.

<img width="320" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/5fce86fb-63b4-491f-b588-f0c051875ed5">

## Implementation

트리는 노드를 가지고 있으니, 처음엔 TreeNode 클래스를 만들어줍니다.

```swift
public class TreeNode<T> {
  public var value: T
  public var children: [TreeNode] = []

  public init(_ value: T) {
    self.value = value
  }
}
```

각각의 노드는 값을 가지고 있고, 배열을 통해 자식을 참조하고 있습니다.

그리고 TreeNode 안에 메소드를 추가해줍니다.

```swift
public func add(_ child: TreeNode) {
  children.append(child)
}
```

이 메소드는 노드에 자식 노드를 추가해주는 메소드입니다.

```swift
example(of: "creating a tree") {
  let beverages = TreeNode("Beverages")

  let hot = TreeNode("Hot")
  let cold = TreeNode("Cold")

  beverages.add(hot)
  beverages.add(cold)
}
```

3가지의 노드를 선언하고, 논리적 계층으로 노드를 구성하였습니다. 위 식은 다음과 같은 구조를 나타냅니다.

<img width="251" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/f65518bb-9a87-48ff-85d5-a55d346030bb">

## Traversal algorithms

트리에 있어서 반복은 선형 구조에 비해 복잡할 수 있습니다.

<img width="403" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/f1564644-170d-4624-a753-d680b9cc2c56">

순회 전략은 해결하고자 하는 문제에 달려있습니다. 다른 트리와 다른 문제에 대해 다양한 전략들이 있습니다. 

depth-first traversal은 루트 노드에서 시작하여 백트래킹(backtracking)을 하기 전까지 최대한 깊게 방문하는 기술입니다

### Depth-first traversal

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

위 식은 다음 노드에 접근하기 위해 재귀를 사용합니다.

```swift
func makeBeverageTree() -> TreeNode<String> {
  let tree = TreeNode("Beverages")

  let hot = TreeNode("hot")
  let cold = TreeNode("cold")

  let tea = TreeNode("tea")
  let coffee = TreeNode("coffee")
  let chocolate = TreeNode("cocoa")

  let blackTea = TreeNode("black")
  let greenTea = TreeNode("green")
  let chaiTea = TreeNode("chai")

  let soda = TreeNode("soda")
  let milk = TreeNode("milk")

  let gingerAle = TreeNode("ginger ale")
  let bitterLemon = TreeNode("bitter lemon")

  tree.add(hot)
  tree.add(cold)

  hot.add(tea)
  hot.add(coffee)
  hot.add(chocolate)

  cold.add(soda)
  cold.add(milk)

  tea.add(blackTea)
  tea.add(greenTea)
  tea.add(chaiTea)

  soda.add(gingerAle)
  soda.add(bitterLemon)

  return tree
}
```

<img width="602" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/452fa66e-ca6d-4438-88c2-e6be6c56d51a">

```swift
example(of: "depth-first traversal") {
  let tree = makeBeverageTree()
  tree.forEachDepthFirst { print($0.value) }
}
```

위 식을 Depth-first traversal 방법으로 순회하게 되면 다음과 같은 결과를 얻을 수 있습니다.

```swift
---Example of: depth-first traversal---
Beverages
hot
tea
black
green
chai
coffee
cocoa
cold
soda
ginger ale
bitter lemon
milk
```
보통 중위 순회를 이용하여 DFS를 활용합니다.

### Level-order traversal

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

forEachLevelOrder는 각 층의 순서대로 노드들을 방문합니다.

1. 현재 노드인 self를 방문합니다.
2. 그 후, 순회할 노드들을 저장하는 큐를 생성합니다.
3. 현재 노드의 자식들을 순회하며 큐에 추가합니다. 
children.forEach { queue.enqueue($0) } 를 호출하여 자식 노드들을 큐에 넣습니다.
4. while let node = queue.dequeue()를 통해 큐에서 노드를 꺼냅니다.
5. 방문한 노드를 visit 클로저에 전달하여 실행합니다.
6. node.children.forEach { queue.enqueue($0) }를 호출하여 현재 노드의 자식들을 큐에 넣습니다.
7. 큐가 빌 때까지 위 과정을 반복합니다.

<img width="407" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/7d40cb99-35d5-44f8-8e84-4384d717d3ee">

```swift
example(of: "level-order traversal") {
  let tree = makeBeverageTree()
  tree.forEachLevelOrder { print($0.value) }
}
```

위 식을 순회하면 다음과 같은 결과를 얻을 수 있습니다.

```swift
---Example of: level-order traversal---
Beverages
hot
cold
tea
coffee
cocoa
soda
milk
black
green
chai
ginger ale
bitter lemon
```

### Search

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

모든 노드를 순회하는 방식입니다.

```swift
example(of: "searching for a node") {
  // tree from the last example

  if let searchResult1 = tree.search("ginger ale") {
    print("Found node: \(searchResult1.value)")
  }
  if let searchResult2 = tree.search("WKD Blue") {
    print(searchResult2.value)
  } else {
    print("Couldn't find WKD Blue")
  }
}
```

```swift
---Example of: searching for a node---
Found node: ginger ale
Couldn't find WKD Blue
```

## Key points

- 트리는 링크드 리스트와 유사하지만, 링크드 리스트는 그 다음으로 하나의 노드만 가질 수 있는 반면에 트리는 여러 자식 노드를 가질 수 있습니다.
- root node를 제외한 모든 트리 노드들은 하나의 부모 노드만을 가집니다.
- root node는 부모 노드가 없습니다.
- leaf node는 자식 노드가 없습니다.
