# Linked List

Linked List(연결 리스트)는 선형적이고, 단방향의 순서를 가진 값들의 collection입니다.

장점으로는 좋은 성능과 함께 상수 시간 내에 원소를 삽입하거나 삭제할 수 있다는 것이 있습니다.

Linked List는 ‘노드’들로 연결되어 있는데, 노드는 ‘값을 가지고 있고’, ‘다음 노드의 참조값을 알고 있어’야 합니다. (C언어의 포인터와 같은 개념)

이를 통해만약 참조값이 nil이라면 리스트의 마지막임을 유추할 수 있습니다.

```swift
public class Node<Value> {
    
    public var value: Value
    public var next: Node?
    
    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}
```

- 노드에는 value와 다음 노드의 참조값이 있습니다.

<img width="324" alt="image" src="https://user-images.githubusercontent.com/104834390/236654316-aa439cb8-5580-4cbc-9bf5-c27504f63cc1.png">

Linked List에는 ‘head’와 ‘tail’이라는 개념이 있는데, 이는 리스트의 처음과 끝을 의미합니다.

<img width="478" alt="image" src="https://user-images.githubusercontent.com/104834390/236654328-ff8a5987-fa50-4536-9843-a45bcba4462f.png">

## 값 추가하기

값을 추가하는 방법에는 3가지가 있습니다.

1. push: 리스트의 앞에 값을 추가합니다.
2. append: 리스트의 마지막에 값을 추가합니다.
3. insert(after: ): 특정 리스트 노드 다음에 값을 추가합니다.

### push

head-first insertion이라고도 불립니다.

```swift
// push
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
```

- head에 Node를 추가함으로써 push합니다.
- 만약 빈 리스트라면(tail ==nil) head와 tail은 같습니다.

### append

tail-end insertion이라고도 불림

```swift
// append
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

1. 만약 리스트에 아무것도 없다면 push와 기능적으로 같기 때문에, push를 해줍니다.
2. tail 노드 다음에 새로운 노드를 생성해줍니다. 
1번에서 isEmpty를 guard 구문을 통해 만들었기 때문에, 강제 언래핑이 가능합니다.
3. 새로운 노드는 리스트의 끝(tail)에 생성됩니다.

### insert(after:)

insert를 하기 위해선, 다음과 같은 방법을 실행시켜야 합니다.

1. 리스트 안에서 특정 노드를 찾습니다.
2. 새로운 노드를 삽입합니다.

```swift
// insert
// 1. 특정 노드 찾기
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

// 2. 새로운 노드 삽입
// 1
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        
        // 2
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        // 3
        node.next = Node(value: value, next: node.next)
        
        return node.next!
    }
```

- 위 식은 주어진 index를 기반으로 노드를 찾을 것입니다.
    
    노드의 head 부분부터 접근이 가능하기 때문에, 반복문을 통해 확인합니다.
    
1. 새로운 참조의 head를 만들고 현재 번호를 추적합니다.
2. while문을 통해 원하는 index로 도달할 것입니다.
만약 없는 인덱스나 범위에 없다면 nil을 리턴할 것입니다.

1. @discardableResult는 호출자가 이 메서드의 반환 값을 무시하도록 허용하여 컴파일러가 경고하지 않도록합니다.
2. 만약 tail 노드라면, append와 기능적으로 같기 때문에, append를 해줍니다.
3. 만약 아니라면, 새로운 노드를 리스트와 연결해주고 새로운 노드를 반환해줍니다.

시간 복잡도

<img width="619" alt="image" src="https://user-images.githubusercontent.com/104834390/236654347-b8e2e3ff-e964-4c21-9201-53fc7fa8aed2.png">

요소를 변경할 때 전체를 탐색할 필요가 없어 O(1)의 시간이 소요되어, 매우 효율적입니다.

## 값 제거하기

값을 제거하는 방법에는 3가지가 있습니다.

1. pop: 리스트의 앞에 값을 제거합니다.
2. removeLast: 리스트의 마지막에 값을 제거합니다.
3. remove(at: ): 리스트 어디에 있던지 제거합니다.

### pop

```swift
// pop
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

- head의 값을 다음 head의 값으로 설정하여 기존의 head가 삭제된 것처럼 보이게 함
- 기존의 head에는 아무런 참조가 있지 않기 때문에 ARC가 자동으로 삭제함
- 만약 값이 비었다면, tail을 nil로 선언함

### removeLast

tail 노드를 알고 있더라도, 그 전의 노드의 참조를 알지 못한다면 제거할 수 없습니다.

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

1. 만약 head가 nil이면 비어있는 리스트이므로 nil을 리턴해줍니다.
2. 만약 하나의 노드만 가지고 있다면, pop과 기능적으로 같기 때문에, pop을 해줍니다.
3. current.next가 nil일 때까지 찾아, current는 tail 노드가 됩니다.
prev는 마지막 노드의 이전 노드이고, current는 마지막 노드를 가리킵니다.
4. current가 마지막 노드이기 때문에, 연결을 끊어주면 됩니다.

### remove(after:)

isert(after:)와 비슷하게, 제거하고 싶은 노드를 찾고, 링크를 해제하면 됩니다.

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

1. 만약 삭제하려는 노드가 리스트의 마지막 노드인 경우에 tail을 node로 바꿔줍니다. 
2. node.next를 node.next.next로 변경함으로써 node.next를 삭제합니다.

시간복잡도

<img width="759" alt="image" src="https://user-images.githubusercontent.com/104834390/236654407-4bbb7fc5-565f-491a-a75d-d566f5e1ebe8.png">

## Swift collection protocols

- Swift collection protocols
    
    
    1. Sequence 
        - 요소에 차례대로 접근할 수 있도록 해줍니다.
        - 방문한 요소들에게 재방문이 불가능하여 엄청 소비적일 수 있습니다.
    
    2. Collection
        - collection 타입은 길이가 유한하고, 원소들에 대한 중복 접근이 가능합니다.
    
    3. BidirectionalCollection
        - 이름처럼 양방향의 collection 타입입니다.
        - head에서 tail로밖에 갈 수 없는 Linked List에서는 사용할 수 없습니다.
    
    4. RandomAccessCollection

## Collection protocol 확장하기

LinkedList에서 Collection의 기능을 기능을 위해 추가합니다.

- startIndex와 endIndex를 사용하여 컬렉션의 시작과 끝 인덱스에 접근할 수 있습니다.
- 인덱스를 사용하여 컬렉션 내의 특정 위치의 요소에 접근할 수 있습니다.
- 컬렉션의 요소 수를 계산하는 count 프로퍼티를 제공합니다.
- 컬렉션의 요소를 반복할 수 있도록 Sequence 프로토콜을 따르도록 요구합니다.

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

		// 1
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
}
```

1. startIndex는 linked list의 head부분입니다.
2. endIndext는 마지막으로 접근 가능한 값 다음의 인덱스를 나타냅니다.
실제 유효한 값은 아니며, 단지 컬렉션의 마지막 노드 다음에 있는 노드를 가리키는 인덱스일 뿐입니다.
3. 다음 노드의 인덱스를 전달하여 인덱스를 증가시킵니다.
4. 첨자(subscript)는 컬렉션의 값을 인덱스에 매핑하는데 사용됩니다. 
커스텀 인덱스를 만들었기 때문에 node의 값을 찾는데는 상수만큼의 시간이 소요됩니다.

## Value semantics and copy-on-write

컬렉션의 중요한 특징 중 하나는 **value semantics**라는 것입니다.

컬렉션은 값 타입이기 때문에 해당 컬렉션 타입이 복사될 때 새로운 인스턴스가 생성됩니다.

따라서 다른 컬렉션에 영향을 주지 않습니다.

이러한 방식은 copy-on-write를 통해 이루어집니다.

<img width="296" alt="image" src="https://user-images.githubusercontent.com/104834390/236654434-a86394c2-0be3-49f8-8277-0aed73af610b.png">

하지만 Linked List의 저장은 참조타입(노드)을 사용하기 때문에 value semantics를 가지고 있지 않습니다.

<img width="365" alt="image" src="https://user-images.githubusercontent.com/104834390/236654440-5087bd06-ef78-4db4-8560-f77ad1e1b4a4.png">

struct임에도 value semantics를 가지고 있지 않은 상황을 COW를 통해 해결할 수 있습니다.

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

- Copy-on-write
    
    값 복사를 지연시켜 메모리 사용량을 줄이는 최적화 기법 중 하나입니다. 
    
    즉, 값이 변경되기 전까지는 원래 값의 복사본이 생성되지 않습니다. 
    
    대신 변경이 발생할 때에만 복사가 이루어지고, 이후에 변경된 값에 대한 복사본을 사용하게 됩니다. 
    
    이렇게 하면 메모리를 절약할 수 있으며, 값의 복사를 효율적으로 처리할 수 있습니다. 
    
    Swift의 배열과 같은 일부 컬렉션은 copy-on-write 최적화를 사용하여 값 복사를 지연시키고 메모리 사용량을 줄이는데에 활용됩니다.
    

## Optimizing COW

O(n)을 하지 않기 위해 2가지 방법이 있습니다.

1. 주인이 한 명일 때는 복사를 하지 않습니다.

### isKnownUniquelyReferenced

객체가 하나의 참조를 하고 있는지 알려주는 라이브러리입니다.

```swift
guard !isKnownUniquelyReferenced(&head) else {
  return
}
```

- copyNodes 위에 이 식을 선언해줌으로, COW의 이점을 얻을 수 있습니다.

### minor predicament

```swift
print("Removing middle node on list2")
if let node = list2.node(at: 0) {
  list2.remove(after: node)
}
print("List2: \(list2)")

---Example of linked list cow---
List1: 1 -> 2
List2: 1 -> 2
After appending 3 to list2
List1: 1 -> 2
List2: 1 -> 2 -> 3  
Removing middle node on list2
List2: 1 -> 2 -> 3
```

현재 remove가 되지 않습니다. 이유는 COW로 인해 변화가 발견될 때마다 노드를 복사하여 다른 노드 세트의 값을 제거하기 때문입니다. 따라서 관련된 메소드를 추가해줘야 합니다.

```swift
private mutating func copyNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
  guard !isKnownUniquelyReferenced(&head) else {
    return nil
  }
  guard var oldNode = head else {
    return nil
  }

  head = Node(value: oldNode.value)
  var newNode = head
  var nodeCopy: Node<Value>?

  while let nextOldNode = oldNode.next {
    if oldNode === node {
      nodeCopy = newNode
    }
    newNode!.next = Node(value: nextOldNode.value)
    newNode = newNode!.next
    oldNode = nextOldNode
  }

  return nodeCopy
}
```

해당 식은 통과된 파라미터에 기반하여 노드를 리턴해줄 것입니다.

remove메소드 또한 업데이트 해줍니다.

```swift
@discardableResult
public mutating func remove(after node: Node<Value>) -> Value? {
  guard let node = copyNodes(returningCopyOf: node) else { return nil }
  defer {
    if node.next === tail {
      tail = node
    }
    node.next = node.next?.next
  }
  return node.next?.value
}
```

## 한 줄 요약

- 연결 리스트는 선형적이며 단방향적입니다. 하나의 노드에서 다른 노드로 참조를 이동하면 이전 노드로 되돌아갈 수 없습니다.
- 연결 리스트는 머리부터 삽입하는 경우 O(1)의 시간 복잡도를 갖습니다. 배열의 경우 머리부터 삽입하는 경우 O(n)의 시간 복잡도를 갖습니다.
- Swift Sequence 및 Collection 프로토콜을 준수하면 많은 유용한 메서드에 쉽게 액세스할 수 있습니다.
- COW(복사 시점 지연) 행동을 통해 성능을 유지하면서 값의 의미론을 달성할 수 있습니다.
