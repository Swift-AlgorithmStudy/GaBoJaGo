# Chap2. LinkedLists

 **Q. 배열이 아니라 LinkedList를 사용하는 이유는 뭘까요?**

- 리스트 앞에서 삽입 및 제거 시간 일정
- 신뢰할 수 있는 성능 특성


## 1. 연결리스트란?

선형, 단방향 순서로 배열된 값의 집합으로, 노드의 체인이라고 볼 수 있다. 

**Node의 두 가지 책임**

- **값**을 보유합니다.
- **다음 노드에 대한 참조**를 보유합니다. Nil 값은 목록의 끝을 나타냅니다.

**노드 클래스**

```swift
public class Node<Value> {

  public var value: Value
  public var next: Node?

  public init(value: Value, next: Node? = nil) {
    self.value = value
    self.next = next
  }
}

//연결리스트 만들기
let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)
```

연결 **리스트 구조체**

```swift
public struct LinkedList<Value> {

  public var head: Node<Value>?
  public var tail: Node<Value>?

  public init() {}

  public var isEmpty: Bool {
    head == nil
  }
}
```


## 2. 연결리스트에 값 추가하기

값을 추가하는 데는 3가지 방법이 있습니다.

- push: 리스트 앞에 값 추가
- append: 리스트 마지막에 값 추가
- insert(after:): 특정한 리스트 노드 뒤에 값 추가

### **push 코드:** 리스트 앞에 값을 삽입하는 것입니다.

```swift
public mutating func push(_ value: Value) {
  head = Node(value: value, next: head)
  if tail == nil {
    tail = head
  }
}
```

노드를 생성해 인자로 받은 값을 추가하고, next 참조를 기존 head에 합니다.

이후 생성된 노드를 head로 재설정해줍니다.

빈 목록으로 밀어 넣는 경우, 새 노드는 목록의 head와 tail입니다.

### **append 코드**: 리스트 마지막에 값을 삽입하는 것입니다.

```swift
public mutating func append(_ value: Value) {
  // 1
  guard !isEmpty else {
    push(value)
    return
  }

  // 2
  tail!.next = Node(value: value)

  // 3
  tail = tail!.next
}
```

1. 목록이 비어 있다면, head와 tail를 모두 새 노드로 업데이트해야 합니다. 빈 목록에 추가는 푸시와 기능적으로 동일하기 때문에, 푸시를 호출합니다.
2. 다른 모든 경우 tail 노드 뒤에 새 노드를 만듭니다. 위의 guard문으로 isEmpty 인 경우에는 푸시하기 때문에 강제 언래핑는 성공이 보장됩니다.
3. 이것은 tail 삽입이기 때문에, 당신의 새로운 노드는 목록의 꼬리이기도 합니다. 

### **insert(after:) 코드**: 목록의 특정 위치에 값을 삽입하는 것입니다.

insert를 수행하기 위해서는 두 단계가 필요합니다.

1. 리스트에서 특정 노드 찾기
2. 새 노드 삽입하기

먼저, 값을 삽입할 노드를 찾기 위해 코드를 구현해볼까요?

```swift
public func node(at index: Int) -> Node<Value>? {
  // 1
  var currentNode = head
  var currentIndex = 0

  // 2
  while currentNode != nil && currentIndex < index {
    currentNode = currentNode!.next
    currentIndex += 1
  }

  return currentNode
}
```

Node(at:)는 주어진 인덱스를 기반으로 리스트에서 노드를 검색하려고 시도할 것이다. head 노드에서만 리스트의 노드에 액세스할 수 있기 때문에, 반복적인 순회을 해야 합니다. 

1. 헤드에 대한 새로운 참조를 만들고 현재 순회 수를 추적합니다.
2. While 루프를 사용하여, 원하는 인덱스에 도달할 때까지 참조를 리스트 아래로 이동합니다. 빈 리스트나 범위를 벗어난 인덱스는 반환 값이 nil이 됩니다.

이제 새 노드를 삽입하는 코드를 구현해볼까요?

```swift
@discardableResult
public mutating func insert(_ value: Value,
                            after node: Node<Value>)
                            -> Node<Value> {
  // 1
  guard tail !== node else {
    append(value)
    return tail!
  }
  // 2
  node.next = Node(value: value, next: node.next)
  return node.next!
}
```

1. 이 메서드가 tail 노드로 호출되는 경우, 기능적으로 동등한 추가 메서드를 호출할 것입니다. 이것은 tail를 업데이트하는 것을 처리할 것이다.
2. 그렇지 않으면, 새 노드를 나머지 리스트과 연결하고 새 노드를 반환하기만 하면 됩니다.

👩🏻‍💻 💬 **@discardableResult**는 호출자가 컴파일러가 경고하지 않고 이 메서드의 반환 값을 무시할 수 있게 해줍니다.

**Performance analysis**

|  | push | append | insert(after:) | node(at:) |
| --- | --- | --- | --- | --- |
| Behaviour | insert at head | insert at tail | insert after a node | returns a node at given index |
| Time complexity | O(1) | O(1) | O(1) | O(i), where i is the given index |


## 3. 리스트에서 값 제거하기

노드를 제거하는 방법은 3가지가 있습니다.

- pop: 리스트 앞의 값을 제거합니다.
- removeLast: 리스트 끝에 있는 값을 제거합니다.
- remove(at:): 리스트의 어느 곳에서나 값을 제거합니다.

### pop

목록 앞의 값을 제거하는 것을 팝이라고 합니다.

```swift
@discardableResult
public mutating func pop() -> Value? {
  defer {
    head = head?.next
    if isEmpty {
      tail = nil
    }
  }
  return head?.value
}
```

팝은 리스트에서 제거된 값을 반환합니다. 리스트가 비어 있을 수 있기 때문에 이 값은 옵셔널입니다.

head를 노드 아래로 이동하면 리스트의 첫 번째 노드를 효과적으로 제거할 수 있습니다. 즉, 첫 번째 노드는 더 이상 리스트에 속하지 않습니다.

해당 메소드가 종료되면, 이전 노드에 더 이상 참조가 없으므로 ARC가 해당 노드를 메모리에서 제거한다는 것을 의미합니다.

리스트가 비어 있으면, tail를 nil로 설정합니다.

### **removeLast**

리스트의 마지막 노드를 제거하는 것은 다소 불편합니다. tail 노드에 대한 참조는 있지만, 그 앞의 노드에 대한 참조 없이는 직접 제거할 수 없습니다. 

```swift
@discardableResult
public mutating func removeLast() -> Value? {
  // 1
  guard let head = head else {
    return nil
  }
  // 2
  guard head.next != nil else {
    return pop()
  }
  // 3
  var prev = head
  var current = head

  while let next = current.next {
    prev = current
    current = next
  }
  // 4
  prev.next = nil
  tail = prev
  return current.value
}
```

1. 만약 head가 nil이라면, 제거할 것이 없으므로 nil을 반환합니다.
2. 만약 리스트가 단 하나의 노드로 이루어져 있다면, removeLast는 기능적으로 pop과 동등합니다. pop은 head와 tail 참조를 업데이트하는 작업을 처리하기 때문에, 이 작업을 pop에게 위임합니다.
3. current.next가 nil이 될 때까지 다음 노드를 찾기 위해 계속해서 검색을 수행합니다. 이는 current가 리스트의 마지막 노드임을 나타냅니다.
4. current가 마지막 노드이므로, prev.next 참조를 사용하여 단순히 연결을 끊습니다. 또한 tail 참조를 업데이트하는 것도 잊지 않습니다.

✔️ removeLast는 목록 끝까지 탐색해야 하므로 **O(n)의 복잡도**입니다.

### remove(after:)

리스트에서 특정한 지점에 있는 특정 노드를 제거하는 작업입니다. 이는 insert(after:)와 매우 유사하게 수행됩니다. 먼저 제거하려는 노드 바로 앞의 노드를 찾은 다음, 해당 노드와의 연결을 끊습니다.

```swift
@discardableResult
public mutating func remove(after node: Node<Value>) -> Value? {
  defer {
    if node.next === tail {
      tail = node
    }
    node.next = node.next?.next
  }
  return node.next?.value
}
```

노드들의 연결을 해제하는 작업은 defer 블록에서 수행됩니다. defer 블록은 해당 범위를 빠져나갈 때 자동으로 실행되는 코드 블록입니다. 따라서, 노드의 연결을 언링크하여 제거하는 작업은 해당 범위를 벗어날 때 수행됩니다.

제거된 노드가 tail 노드인 경우, tail 참조를 업데이트해야 합니다.

✔️ insert(at:)와 유사하게, 이 작업의 시간 복잡도는 O(1)입니다. 하지만 이 작업을 수행하기 위해서는 미리 특정 노드에 대한 참조를 가져야 합니다.

✔️ 즉, 제거하고자 하는 노드의 위치를 정확히 알아야 한다는 것을 의미합니다. 이 작업은 특정한 노드에 대한 참조를 가지고 있어야만 가능합니다.

**Performance analysis**

|  | pop | removeLast | remove(after:) |
| --- | --- | --- | --- |
| Behaviour | remove at head | remove at tail | remove the immediate next node |
| Time complexity | O(1) | O(1) | O(1) |


## 4. Swift collection

```swift
extension LinkedList: Collection {

  public struct Index: Comparable {

    public var node: Node<Value>?

    static public func ==(lhs: Index, rhs: Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left?, right?):
        return left.next === right.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }

    static public func <(lhs: Index, rhs: Index) -> Bool {
      guard lhs != rhs else {
        return false
      }
      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }
  }
}

//컬렉션 요구 사항을 충족하기 위해 이 사용자 지정 인덱스를 사용할 것입니다.
public var startIndex: Index {
  Index(node: head)
}
// 2
public var endIndex: Index {
  Index(node: tail?.next)
}
// 3
public func index(after i: Index) -> Index {
  Index(node: i.node?.next)
}
// 4
public subscript(position: Index) -> Value {
  position.node!.value
}
```

1. 연결 리스트에서 시작 인덱스인 StartIndex는 head(머리)로 합리적으로 정의됩니다.
2. Collection은 endIndex를 마지막으로 액세스 가능한 값 바로 다음 인덱스로 정의합니다. 즉, tail?.next를 사용하여 endIndex를 정의합니다. tail은 연결 리스트의 마지막 노드를 가리키는 포인터이므로, tail?.next는 nil이 됩니다.
3. index(after:)는 인덱스를 증가시키는 방법을 지시합니다. 다음 노드의 인덱스를 간단히 전달하여 인덱스를 증가시킬 수 있습니다.
4. 첨자(subscript)는 인덱스를 컬렉션 내의 값에 매핑하는 데 사용됩니다. 사용자 정의 인덱스를 만들었기 때문에 노드의 값에 상수 시간에 접근할 수 있습니다. 이를 통해 인덱스를 값을 참조하는 데 사용할 수 있습니다.


## 5. Value semantics and copy-on-write

- 리스트로 값 복사 할 경우

```swift
example(of: "array cow") {
  let array1 = [1, 2]
  var array2 = array1

  print("array1: \(array1)")
  print("array2: \(array2)")

  print("---After adding 3 to array 2---")
  array2.append(3)
  print("array1: \(array1)")
  print("array2: \(array2)")
}
```

```bash
---Example of array cow---
array1: [1, 2]
array2: [1, 2]
---After adding 3 to array 2---
array1: [1, 2]
array2: [1, 2, 3]
```

- 링크리스트로 값복사

```swift
example(of: "linked list cow") {
  var list1 = LinkedList<Int>()
  list1.append(1)
  list1.append(2)
  var list2 = list1
  print("List1: \(list1)")
  print("List2: \(list2)")

  print("After appending 3 to list2")
  list2.append(3)
  print("List1: \(list1)")
  print("List2: \(list2)")
}
```

```bash
---Example of linked list cow---
List1: 1 -> 2
List2: 1 -> 2
After appending 3 to list2
List1: 1 -> 2 -> 3
List2: 1 -> 2 -> 3
```

안타깝게도, 연결 리스트는 값 의미론을 가지고 있지 않습니다! 이는 내부 저장소가 참조 유형(Node)을 사용하기 때문입니다. 이는 LinkedList가 구조체이고 값 의미론을 사용해야하는데 심각한 문제입니다. 이 문제를 해결하기 위해 COW를 구현해야합니다.

COW를 사용하여 값 의미론을 달성하는 전략은 비교적 간단합니다. 연결 리스트의 내용을 변경하기 전에 내부 저장소를 복사하고 모든 참조(head 및 tail)를 새로운 복사본으로 업데이트하려고 합니다.

구현해볼까요?

```swift
private mutating func copyNodes() {
  guard var oldNode = head else {
    return
  }

  head = Node(value: oldNode.value)
  var newNode = head

  while let nextOldNode = oldNode.next {
    newNode!.next = Node(value: nextOldNode.value)
    newNode = newNode!.next

    oldNode = nextOldNode
  }

  tail = newNode
}
```

이 메서드는 연결 리스트의 기존 노드를 동일한 값을 가진 새로 할당된 노드로 교체합니다. 이제 LinkedList에서 mutating 키워드로 표시된 다른 모든 6가지 삽입 삭제 메서드의 맨 위에서 copyNodes를 호출하세요.



## 🗝️ Key points

- **연결 리스트는 선형이면서 단방향적인 데이터 구조입니다.** 한 노드에서 다른 노드로 참조를 이동하면 되돌아갈 수 없습니다.
- **연결 리스트는 머리(head)에 요소를 삽입하는 경우 O(1)의 시간 복잡도를 갖습니다.** 이는 리스트의 시작 부분에 요소를 삽입하는 작업이 상수 시간이 걸린다는 것을 의미합니다. 반면 배열은 머리에 요소를 삽입하는 경우 O(n)의 시간 복잡도를 갖습니다. 이는 기존 요소들을 이동시켜야 하기 때문입니다.
- **Swift의 Sequence와 Collection과 같은 컬렉션 프로토콜을 준수함으로써 많은 유용한 메서드와 기능에 접근할 수 있습니다.** 이를 통해 익숙한 방식으로 연결 리스트를 다루기가 더욱 쉬워집니다.
- **쓰기 시점 복사(COW) 동작을 통해 값 의미론을 유지하면서 좋은 성능을 유지할 수 있습니다.** COW를 사용하면 연결 리스트의 내부 저장소는 변경될 때만 복사되므로 데이터의 효율적인 공유와 메모리 사용량을 최적화할 수 있습니다.
