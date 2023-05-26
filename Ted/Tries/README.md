# Trie

trie는 영어 단어와 같이 컬렉션으로 나타낼 수 있는 데이터를 저장하는 데 특화된 트리입니다.

<img width="240" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/3ab2a6aa-3bb9-450b-94d2-a323f1e831b6">

각 문자열 문자는 마지막 노드(점으로 표시됨)가 끝나는 노드에 매핑됩니다. trie의 이점은 접두사 일치의 맥락에서 보면 가장 잘 설명됩니다.

## Example

문자열의 컬렉션이 주어졌습니다. 접두사 일치를 다룰 수 있는 컴포넌트를 어떻게 구축할 것입니까?

```swift
class EnglishDictionary {

  private var words: [String]

  func words(matching prefix: String) -> [String] {
    words.filter { $0.hasPrefix(prefix) }
  }
}
```

words(matching:)은 문자열의 컬렉션을 탐색하여 접두사가 일치하는 문자열을 반환할 것입니다.

이 알고리즘은 단어 배열이 적을 때 합리적입니다. 하지만 만약 몇 천 단어를 다룰 때는 비합리적이게 됩니다.

words(matching:)의 시간 복잡도는 O(K * n)으로 k는 컬렉션에서 가장 긴 문자열이고, n은 확인해야할 단어의 개수입니다.

trie 자료구조는 이러한 문제에 이어서 매우 효과적입니다. 여러 자식을 가지고 있는 노드로 이루어진 트리는, 각각의 노드가 각각의 문자가 될 수 있습니다.

검은 점으로 표시된 종단자를 활용하여 루트에서 노드까지 문자 집합을 추적하여 단어를 만듭니다. 트리의 흥미로운 특징은 여러 단어가 동일한 문자를 공유할 수 있다는 점입니다.

Trie의 이점을 설명하기 위해, 접두사가 CU인 단어를 찾아야 하는 예시를 고려해봅시다.

먼저 C를 포함하는 노드로 이동합니다. 이는 검색 작업에 있는 다른 분기를 빠르게 제거해줍니다.

<img width="296" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/6efd246c-d16a-47ac-805a-d176d57969b8">

U가 다음으로 오는 단어를 찾아야 합니다. U 노드를 탐색합니다.

<img width="253" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/14c18d49-8d79-415d-b261-2a273793ebf4">

이것이 접두사의 마지막이기 때문에, U 노드가 있는 모든 컬렉션을 반환할 것입니다. 위 경우에서는 CUT, CUTE가 반환될 것입니다. 

만약 trie가 몇 천개의 단어를 포함하고 있었다면, trie를 사용하면서 줄일 수 있는 비교군의 갯수는 엄청나게 많을 것입니다.

<img width="389" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/b0311830-aaa0-472a-ba45-8eff702318c9">

## Implementation

### TrieNode

```swift
public class TrieNode<Key: Hashable> {

  // 1
  public var key: Key?

  // 2
  public weak var parent: TrieNode?

  // 3
  public var children: [Key: TrieNode] = [:]

  // 4
  public var isTerminating = false

  public init(key: Key?, parent: TrieNode?) {
    self.key = key
    self.parent = parent
  }
}
```

1. key는 노드에 대한 데이터를 가지고 있습니다. trie의 루트 노드는 key가 없기 때문에 옵셔널입니다.
2. TrieNode는 부모에 대해 약한 참조를 하고 있습니다. 이는 remove 메소드를 용이하게 해줍니다.
3. BST에서 node는 왼쪽, 오른쪽 자식을 가지고 있습니다. Trie에서는, 여러 요소들을 포함하고 있어야 하기 때문에 children 딕셔너리를 선언합니다.
4. isTerminating은 컬렉션의 끝에 대한 지표 역할을 합니다.

### Trie

```swift
public class Trie<CollectionType: Collection>
    where CollectionType.Element: Hashable {

  public typealias Node = TrieNode<CollectionType.Element>

  private let root = Node(key: nil, parent: nil)

  public init() {}
}
```

Trie 클래스는 Collection 프로토콜을 준수합니다. 또한 컬렉션 안에 있는 요소들은 Hashable해야합니다. 
컬렉션의 요소들을 children 딕셔너리의 키로 활용할 것이기 때문입니다.

다음에는 insert, contains, remove와 prefix match에 대해 알아볼 것입니다.

### Insert

Trie는 컬렉션에 일치하는 모든 유형으로 작업을 진행합니다. Trie는 컬렉션의 각 요소에 대해 일련의 노드로 표시합니다.

```swift
public func insert(_ collection: CollectionType) {
  // 1
  var current = root

  // 2
  for element in collection {
    if current.children[element] == nil {
      current.children[element] = Node(key: element, parent: current)
    }
    current = current.children[element]!
  }

  // 3
  current.isTerminating = true
}
```

1. current는 루트 노드로부터 시작하여 탐색 과정을 진행합니다.
2. Trie는 각 컬렉션 요소를 별도의 노드에 저장합니다. 컬렉션의 각 요소에 대해 현재 노드가 자식 딕셔너리에 있는지 먼저 확인합니다. 만약 없다면 새로운 노드를 생성합니다. 
루프를 진행하는 동안, current를 다음 노드로 이동합니다. 
3. 루프를 순회한 후, current는 컬렉션의 끝을 참조하고 있어야 합니다. 이 노드를 terminating node라고 합니다.

이 알고리즘의 시간 복잡도는 O(k)인데, k는 컬렉션에 삽입하고자 하는 요소의 갯수입니다. 

### Contains

contains는 insert와 매우 비슷합니다.

```swift
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

insert와 유사한 방식으로 순회합니다. 컬렉션에 있는 모든 요소를 확인하면서 트리에 있는지 확인합니다.

만약 마지막 요소에 도달하면, 그 요소는 마지막 요소여야합니다. 

contains의 시간 복잡도 또한 O(k)입니다. 

```swift
example(of: "insert and contains") {
  let trie = Trie<String>()
  trie.insert("cute")
  if trie.contains("cute") {
    print("cute is in the trie")
  }
}

---Example of: insert and contains---
cute is in the trie
```

### Remove

노드를 제거할 때 해당 노드를 여러 컬렉션이 공유하고 있을 수 있기 때문에 
trie에서 remove는 조금 더 까다롭습니다. 

```swift
public func remove(_ collection: CollectionType) {
  // 1
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
  // 2
  current.isTerminating = false
  // 3
  while let parent = current.parent,
        current.children.isEmpty && !current.isTerminating {
      parent.children[current.key!] = nil
      current = parent
  }
}
```

1. 이 부분은 contains의 구현 방법입니다. 컬렉션이 trie의 일부분인지 확인하고 마지막 노드에서 현재의 노드를 가리킵니다.
2. isTerminating을 false로 설정하면 다음 단계에서 현재 노드를 제거할 수 있습니다.
3. 노드를 공유할 수 있으므로 다른 컬렉션에 속한 요소를 제거하지 않고 싶을 수 있습니다. 현재 노드에서 자식 노드가 없다면, 다른 컬렉션이 현재 노드에 종속되지 않음을 의미합니다.
또한 현재 노드가 종료되는지 확인합니다. 만약 그렇다면, 다른 다른 컬렉션에 속한 것입니다. 이러한 조건을 만족시키는 한, 부모 프로퍼티를 통해 역추적을 하고, 노드를 제거할 수 있습니다.

이 알고리즘의 시간 복잡도는 O(k)이고, k는 제거하고자 하는 컬렉션 요소의 갯수입니다.

```swift
example(of: "remove") {
  let trie = Trie<String>()
  trie.insert("cut")
  trie.insert("cute")

  print("\n*** Before removing ***")
  assert(trie.contains("cut"))
  print("\"cut\" is in the trie")
  assert(trie.contains("cute"))
  print("\"cute\" is in the trie")

  print("\n*** After removing cut ***")
  trie.remove("cut")
  assert(!trie.contains("cut"))
  assert(trie.contains("cute"))
  print("\"cute\" is still in the trie")
}

---Example of: remove---

*** Before removing ***
"cut" is in the trie
"cute" is in the trie

*** After removing cut ***
"cute" is still in the trie
```

### prefix matching

trie는 prefix-matching 알고리즘으로 유명합니다. 

```swift
public extension Trie where CollectionType: RangeReplaceableCollection {

}
```

prefix-matching 알고리즘은  RangeReplaceableCollection 프로토콜에 제한을 받습니다. 
이유는 RangeReplaceableCollection 타입의 메소드에 접근해야 하기 때문입니다.

```swift
func collections(startingWith prefix: CollectionType) -> [CollectionType] {
  // 1
  var current = root
  for element in prefix {
    guard let child = current.children[element] else {
      return []
    }
    current = child
  }

  // 2
  return collections(startingWith: prefix, after: current)
}
```

1. Trie가 접두사를 포함하는 지를 확인함으로 시작합니다. 만약 포함하지 않고 있다면, 빈 배열을 반환합니다.
2. 접두사의 끝을 나타내는 노드를 찾은 후 헬퍼 메소드인 collections메소드를 통해 재귀적으로 현재 노드 뒤의 모든 순서를 찾습니다.

다음으로 헬퍼 메소드를 위해 코드를 추가합니다.

```swift
private func collections(startingWith prefix: CollectionType,
                         after node: Node) -> [CollectionType] {
  // 1
  var results: [CollectionType] = []

  if node.isTerminating {
    results.append(prefix)
  }

  // 2
  for child in node.children.values {
    var prefix = prefix
    prefix.append(child.key!)
    results.append(contentsOf: collections(startingWith: prefix,
                                           after: child))
  }

  return results
}
```

1. 결과를 담을 배열을 생서합니다. 만약 현재 노드가 종료된다면, 결과에 노드를 추가합니다.
2. 다음으로 현재 노드의 자식 노드를 확인해야 합니다. 모든 자식 노드에 대해 collections메소드를 재귀적으로 호출하여 다른 종료 노드를 찾습니다.

collections의 시간 복잡도는 O(k * m)인데, k는 접두사에 일치하는 가장 긴 컬렉션을 나타내고, m은 해당 접두사에 일치하는 컬렉션의 갯수입니다.

해당 배열을 자기 부르는 것은 O(k* n)의 시간 복잡도를 가니는데, n은 컬렉션 안의 요소의 갯수입니다.

```swift
example(of: "prefix matching") {
  let trie = Trie<String>()
  trie.insert("car")
  trie.insert("card")
  trie.insert("care")
  trie.insert("cared")
  trie.insert("cars")
  trie.insert("carbs")
  trie.insert("carapace")
  trie.insert("cargo")

  print("\nCollections starting with \"car\"")
  let prefixedWithCar = trie.collections(startingWith: "car")
  print(prefixedWithCar)

  print("\nCollections starting with \"care\"")
  let prefixedWithCare = trie.collections(startingWith: "care")
  print(prefixedWithCare)
}

---Example of: prefix matching---

Collections starting with "car"
["car", "carbs", "care", "cared", "cars", "carapace", "cargo", "card"]

Collections starting with "care"
["care", "cared"]

```

## Key points

- Trie는 prefix matching에 있어서 매우 좋은 성능을 보여줍니다.
- 상대적으로 메모리로도 효율적입니다. 
예를 들어 car, carbs, care의 첫 세 글자를 공유할 수 있습니다.
