# Tries

이진 트리같은경우 숫자의 크기가 작고 큼에 따라 O(log n)의 탐색속도를 가지게 되는데, Trie는 전화번호부의 숫자들, 영어단어의 접두사, 접미사 등으로 데이터를 걸러내는 것을 말한다. (ex. 구글의 검색, 전화번호검색)

![](https://hackmd.io/_uploads/H1dd4V7U3.png)

"cute" 를 표현하고 싶은데 그 안에 "cut" 도 포함되어있다. 이를 표현하기 위해 아래의 사진처럼 '.'을 찍어 준다.
![](https://hackmd.io/_uploads/HJnlS4XUh.png)

## 구현

### TrieNode

```swift

public class TrieNode<Key: Hashable> {
  
  public var key: Key?
  public weak var parent: TrieNode?
  public var children: [Key: TrieNode] = [:]
  public var isTerminating = false
  
  public init(key: Key?, parent: TrieNode?) {
    self.key = key
    self.parent = parent
  }
}

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {
  
    public typealias Node = TrieNode<CollectionType.Element> 
    
    private let root = Node(key: nil, parent: nil) 
    
    public init(){ }
}
```

### insert,contains
```swift
  public func insert(_ collection: CollectionType) {
    var current = root
    for element in collection {
      if current.children[element] == nil {
        current.children[element] = Node(key: element, parent: current)
      }
      current = current.children[element]!
    }
    current.isTerminating = true
  }
  
  public func contains(_ collection: CollectionType) -> Bool {
    var current = root
    for element in collection {
      guard let child = current.children[element] else {
        return false
      }
      current = child
    }
    return current.isTerminating
  }

```

### remove 

```swift 

 public func remove(_ collection: CollectionType) {
    var current = root
    for element in collection {
      guard let child = current.children[element] else {
        return
      }
      current = child
    }
    guard current.isTerminating else {
      return
    }
    current.isTerminating = false
    while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
      parent.children[current.key!] = nil
      current = parent
    }
  }

```

### collections 

```swift

public extension Trie where CollectionType: RangeReplaceableCollection {
  
  func collections(startingWith prefix: CollectionType) -> [CollectionType] {
    var current = root
    for element in prefix {
      guard let child = current.children[element] else {
        return []
      }
      current = child
    }
    return collections(startingWith: prefix, after: current)
  }
  
  private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
    
    // 1
    var results: [CollectionType] = []
    
    if node.isTerminating {
      results.append(prefix)
    }
    
    // 2
    for child in node.children.values {
      var prefix = prefix
      prefix.append(child.key!)
      results.append(contentsOf: collections(startingWith: prefix, after: child))
    }
    
    return results
  }
}

```
