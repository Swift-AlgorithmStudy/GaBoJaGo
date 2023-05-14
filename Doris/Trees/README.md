# Trees

<img width="50%" height="50%" alt="스크린샷 2023-05-14 오전 2 22 35" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/8e8ebb2e-fb91-48f5-b87a-7a24a98bd777">

</br>

트리는 매우 중요한 데이터 구조로, 소프트웨어 개발의 다양한 측면에서 사용됩니다. </br>

다음과 같은 작업을 할때, 트리가 유용하게 쓰일 수 있습니다. </br>

* `계층 관계`를 나타냅니다.

* 정렬된 `데이터를 관리`합니다.

* `빠른 조회 작업`을 용이하게 합니다.

</br>
</br>

## 💡 Terminology
> 트리 구조에서 사용되는 용어들을 알아보자 ! </br>

### Node

LinkedLists에서와 마찬가지로 트리는 node들로 구성됩니다. </br>

<img  width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/0f0dece9-e92b-4def-a8a6-9850ed076a4a"> </br>

트리에서 각 노드는 `데이터를 저장`할 수 있으며, `자식 노드들을 추적`할 수 있습니다. </br></br>

### Parent and Child

<img  width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/4f10a317-4a38-4f05-beb7-3c6633b1f3fc"> </br>

트리는 실제 나무와 비슷하게 위에서 아래로 가지치는 구조를 가집니다. </br>
맨 위의 노드를 제외한 각 노드는 정확히 하나의 상위 노드와 연결되어 있으며, 이 노드를 `부모노드(parent node)`라고 합니다. </br>
그 아래에 바로 연결된 노드를 `자식 노드(child node)`라고 합니다. </br>
트리에서는 *각 자식 노드가 정확히 하나의 부모를 가지고 있기 때문*에 트리라는 이름이 붙었습니다. </br>
</br>

### Root

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/64e563ea-6d83-4e5c-b22c-0bae5fc29894"> </br>

가장 위에 있는 노드를 Root node라고 부릅니다. </br>
Root node는 부모노드가 없는 유일한 노드입니다. </br> </br>

### Leaf

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/ae48bc05-7036-4dd2-bbf3-2fbfec20caf0"> </br>

트리에서 노드가 자식을 가지지 않을 때 해당 노드를 '리프(leaf)' 노드라고 부릅니다. </br
</br>

## 💡 Implementation
> Swift에서 트리를 구현해보자 ! </br>

```swift
public class TreeNode<T> {
    public var value: T
    public var children: [TreeNode] = []

    public init(_ value: T) {
        self.value = value
  }
}
```
</br>

각각의 노드는 값을 가지며 `배열`을 사용하여 자식 노드에 대한 참조를 가지고 있습니다. </br>

> ✨ Note </br>
> </br>
> 클래스 타입을 사용하여 TreeNode를 구현하는 것은 값 복사의 의미를 잃게 되지만,</br>
> 나중에 사용할 노드에 대한 참조 생성이 간단해집니다. </br>
> 즉, 참조 타입인 클래스를 사용하면 `노드에 대한 참조가 쉽게 유지`됩니다. </br>
</br>

TreeNode 클래스 안에 다음의 코드를 추가해 자식노드를 추가합니다. </br>

```swift
public func add(_ child: TreeNode) {
    children.append(child)
}
```
</br>

```swift
example(of: "creating a tree") {
    let beverages = TreeNode("Beverages")

    let hot = TreeNode("Hot")
    let cold = TreeNode("Cold")

    beverages.add(hot)
    beverages.add(cold)
}
```
</br>

`계층 구조(Hierarchical structures)`는 트리 구조에 대한 자연스러운 현상입니다. </br>
위 코드에서 세 가지 다른 노드를 정의하고 논리적인 계층 구조로 구성했습니다. </br>
이 배열은 아래의 구조에 해당합니다. </br>

<img  width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/3d24b400-f700-49f5-b524-6fc6e6b0428f"> </br> </br>

## 💡 Traversal algorithms
> 트리구조에서의 순회 알고리즘 (모든 요소를 방문)에 대해 알아보자 ! </br>
</br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/ca04cee2-f41a-44e5-b20c-fa2847180c87"> </br>

> 선형 구조에서의 반복 </br>

선형 컬렉션(Linear Collection)을 반복(iterate)하는 것은 간단합니다.</br>
`배열(array)`이나 `연결 리스트(linked list)`와 같은 선형 컬렉션은 명확한 시작과 끝이 있기 때문입니다. </br>

</br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/5842eaf7-bb85-4e4e-b437-79ba2863042a"> </br>

> 트리 구조에서의 반복 </br>

트리 구조에서의 반복은 복잡합니다. </br>
왼쪽 노드가 우선인가요? 노드의 깊이와 우선순위는 어떻게 관련되어 있나요? 서로 다른 트리와 다른 문제에 대한 다양한 전략이 있습니다. </br>
</br>

### Depth-first traversal (깊이 우선 탐색)

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
</br>

<details>
<summary> 코드 추가 설명 </summary>
 
매개변수 `visit`는 클로저를 받아서 TreeNode 인스턴스를 인자로 받아 실행합니다. </br>
이 함수는 visit 클로저를 호출하면서 자기 자신 `self를 인자로 전달`합니다. </br>

</details>

위 코드는 TreeNode 구조체에 depth-first 탐색을 구현하기 위한 extension입니다. </br>
forEachDepthFirst 메소드는 클로저를 인자로 받아서 해당 노드와 그의 자식 노드들을 depth-first 방식으로 탐색하며, 각 노드를 방문할 때마다 클로저를 실행합니다. </br>
이 코드는 재귀를 사용하여 구현되었지만, 직접 스택을 구현해서 재귀 없이 구현할 수도 있습니다. </br>

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
</br>

위 코드는 아래와 같은 구조를 가집니다. </br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/056c3896-a086-4fcc-986f-d588bf5e75d6"> </br>

```swift
example(of: "depth-first traversal") {
  let tree = makeBeverageTree()
  tree.forEachDepthFirst { print($0.value) }
}
```

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/731bde2e-25f0-4a3b-9059-4700b87a51d2"> </br>

깊이 우선 탐색의 결과는 다음과 같습니다. </br>
</br>

### Level-order traversal (레벨-순서 탐색)
> 너비 우선 탐색(BFS)와 유사하게 레벨이 낮은 노드를 먼저 방문합니다 ! </br>

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
</br>

forEachLevelOrder메서드는 다음과 같은 순서로 노드들을 방문하게 됩니다. </br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/bcf5a191-e995-4f75-bed6-e3676cdd09a5"> </br>

```swift
example(of: "level-order traversal") {
  let tree = makeBeverageTree()
  tree.forEachLevelOrder { print($0.value) }
}
```
</br>

예시 코드에서는 makeBeverageTree() 함수를 사용하여 이진 트리를 만들고, forEachLevelOrder 메서드를 호출하여 노드를 레벨 순서대로 방문하여 출력합니다. </br>
이 때, forEachLevelOrder 메서드 내부에서는 `큐를 사용하여 노드를 순회`하며, 현재 레벨에서의 자식 노드들을 큐에 추가하고, 다음 레벨로 넘어가면서 큐에서 노드를 꺼내어 순회합니다. </br>

코드 순회 결과는 다음과 같습니다. </br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/66a6ae39-86f8-4fcd-be87-e3e9b1810f8e"> </br>

</br>

### Search (검색 알고리즘)

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
</br>

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
결과는 다음과 같습니다. </br>

<img width="50%" height="50%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/f9519257-b995-40f8-b853-d585564e28da"> </br>

위 코드는 레벨 순서 탐색 알고리즘을 사용하여 트리를 순회합니다. </br>
이 코드는 모든 노드를 방문하므로, 만약 여러 노드에서 값이 일치하는 경우에는 `마지막에 일치하는 값`이 출력됩니다. </br>
이러한 불안정성은 순회 방법에 따라 다른 객체를 반환하게 됩니다. </br>
이는 TreeNode 값이 `고유 식별자(유일한 ID)를 가지고 있지 않기 때문`입니다. </br>
만약 노드에 고유한 식별자가 있다면, 해당 노드를 정확하게 찾을 수 있을 것입니다.</br>
</br>

## 💡 Key Points

* 트리는 링크드 리스트와 유사하지만, 링크드 리스트 노드는 한 개의 후속 노드에만 연결될 수 있는 반면, 트리 노드는 `많은 자식 노드에 연결될 수 있다`는 차이가 있습니다.
* 루트 노드를 제외한 모든 트리 노드는 정확히 `하나의 부모 노드`를 갖습니다.
* `루트 노드`는 부모 노드가 없습니다.
* `리프 노드`는 자식 노드가 없습니다.
* 깊이 우선 및 레벨 순회와 같은 탐색은 일반적인 트리에만 적용되는 것이 아니라, 다른 종류의 트리에도 적용될 수 있지만, 구현 방법은 트리 구조에 따라 다소 다를 수 있습니다.