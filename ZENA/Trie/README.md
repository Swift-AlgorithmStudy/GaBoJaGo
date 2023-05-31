# Trie
트라이는 영단어처럼 컬렉션으로 나타낼 수 있는 저장데이터에 특화된 트리이다.

<img width="552" alt="스크린샷 2023-05-30 오전 10 36 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/70bfeefa-2d7f-4139-85f8-a0aef35bb096">

각각의 문자는 마지막 노드가 종료되는 노드에 맵핑된다.(?) 트라이의 이점은 접두어의 매칭 맥락에서 가장 잘 묘사된다.

이번 챕터에서는 먼저 트라이의 성능을 배열과 비교해보장

## Example

```swift
// 스트링 배열이 주어져있음 접두차 매칭 어떻게 처리할래
class EnglishDictionary {
    private var words: [String]
    
    func words(matching prefix: String) -> [String] {
        words.filter { $0.hasPrefix(prefix) }
    }
}
```

`words(mathing:)`는 스트링 컬렉션을 거쳐서 접두사가 일치하는 문자열을 반환할 것이다. 이런 알고리즘은 `words` 배열의 크기가 작을 때 합리적이다. 그러나 수천개의 단어를 다룰 때는 배열을 거치는데 걸리는 시간이 감당이 안될 것이다. `words(matching:)`의 시간복잡도는 **O(k*n)**이다. *(단, k는 스트링 컬렉션 중 가장 긴 문자열의 길이이며, n은 확인해야하는 단어들의 개수이다.)*

트라이(노드가 여러 자식들을 가지며, 각각의 노드는 개별 문자를 나타내는 트리구조)는 특히 이런 문제에 엄청난 성능을 보인다.

루트 노드로부터 마침표(.)라는 특별한 indicator 노드를 향해 문자 컬렉션을 따라 단어를 형성한다. 트라이의 흥미로운 특징은 여러 단어가 같은 문자들을 공유할 수 있다는 점이다.

트라이의 성능적 이점을 설명하기 위해, CU라는 접두사를 가진 단어를 찾는 상황을 생각해보자

먼저, C를 가진 노드를 찾겠지. 그럼 다른 브랜치들은 search 과정에서 바로 배제된다.

<img width="520" alt="스크린샷 2023-05-30 오후 5 49 20" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/8e42decf-67e1-4f64-b6c7-40e258313857">

다음으로, U라는 단어를 가진 노드를 찾아 넘어간다.

<img width="520" alt="스크린샷 2023-05-30 오후 5 49 29" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/4ea5b40f-3333-4915-9763-e4fb4d436b2c">

여기까지가 접두어 CU이므로 트라이는 노드 C - 노드 U가 형성한 chain of nodes을 반환한다. 이러한 경우의 결과로, CUT과 CUTE라는 단어가 반환된다. 트라이가 수백, 수천 단어를 포함하고 있다고 생각해보자 .. 트라이를 씀으로써 버릴 수 있는 비교 연산의 수가 개많다!!

<img width="552" alt="스크린샷 2023-05-30 오후 5 53 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/8f13b21a-ffb6-463f-b065-348f04e01991">

## Implementation

### TrieNode

트라이의 노드를 만드는 것부터 시작!

```swift
// path: Sources/TrieNode.swift

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

그동안 만나본 노드들이랑 인터페이스가 살짝 다를거다

1. `key`는 노드가 가진 데이터이다. **루트노드는 `key`를 갖지 않으므로** 옵셔널이다.
2. TrieNode는 부모에 대해 약한 참조를 가진다. 이는 나중에 `remove` 메소드를 간소화해준다.
3. 이진 탐색 트리에서 노드는 왼쪽, 오른쪽 자식을 가진다. 
    
    트라이에서는 노드가 서로 다른 여러개의 요소를 가지므로, `children`을 딕셔너리로 선언해야 한다.
    
4. 일찍 얘기해보자면, `isTerminating`은 컬렉션의 끝을 가리킨다.

### Trie

노드를 관리할 트라이를 만들어주자.

```swift
// path: Sources/Trie.swift

public class Trie<CollectionType: Collection> where CollectionType.Element: Hashable {

  public typealias Node = TrieNode<CollectionType.Element>
  private let root = Node(key: nil, parent: nil)
  public init() {}
}
```

Trie 클래스는 컬렉션 프로토콜을 따르므로 스트링을 포함한 모든 타입에 대해 사용할 수 있다. 이 요구사항에 덧붙여, 컬렉션 내 각각의 요소들은 반드시 `**Hashable**`해야한다. 왜냐하면 **컬렉션의 요소들을 `TireNode`의 딕셔너리`children` 의 키로 사용해야하기 때문**이다.

그러면 이제 네가지 명령을 구현해 봅시다: insert, contains, remove, prefix match

### Insert

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

1. `current`는 루트노드로부터 시작한 탐색 과정을 추적한다.
2. 트라이는 컬렉션 각각 요소를 각자 개별 노드에 저장한다. 컬렉션 각각의 요소에 대해 `children` 딕셔너리에 이미 존재하는지를 먼저 확인해야 한다.
3. `for` 루프 이후 `current`는 컬렉션의 마지막 노드를 참조해야 한다.

이 삽입 알고리즘의 시간복잡도는 O(k)이다. (단, k는 삽입해야하는 컬렉션의 크기이다.)

### Contains

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

순회하는 방식이 `insert`와 유사하다. 트리에 찾는 요소가 있는지 모든 요소를 확인한다. 마지막 요소에 다다르면, 그건 terminating element겠지요. 그렇지 않다면, 컬렉션이 추가되지 않았으며, 내가 찾은 것은 더 큰 컬렉션의 부분집합인 것이다.

contains의 시간 복잡도는 O(k)이다. (단, k는 찾기 위해 사용하는 컬렉션의  크기이다.) 이런 시간복잡도는 트라이에 내가 찾으려는 그 컬렉션이 있는지 알아내기 위해 k개의 노드들을 순회하기 때문이다.

### Remove

트라이에서 노드를 삭제하는건 조금 더 까다롭다. 특히 여러 컬렉션이 노드들을 공유할 수 있으므로 주의해야 한다.

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

1. `contains`를 구현하는 것과 비슷해 보이지요. 컬렉션이 트라이의 일부인지, `current`가 컬렉션의 마지막 노드인지 확인하는 부분이다.
2. `isTerminating`을 `false`로 세팅해 현재 노드가 다음 루프에서 삭제될 수 있도록 한다.
3. 요기가 바로 까다로운 부분! 노드들이 공유되고 있을 수도 있기 때문에, 다른 컬렉션이 속한 요소를 지우면 안된다. 현재 노드에 또 다른 children이 없다면(empty), 다른 컬렉션들이 현재 노드와 관련이 없다는 뜻이다.
    
    현재 코드가 isTerminating인지 또한 확인해야 하고, 그렇다면 (true라면), 다른 컬렉션에 포함되었다는 뜻이다. current가 이 조건들을 만족하는 한, parent 프로퍼티로 계속 역추적해 노드들을 삭제한다. 
    

시간복잡도는 O(k)이다. (단 k는 지우려고 하는 컬렉션의 크기이다.)

### Prefix matching

트라이의 가장 상징적인 알고리즘이다.

```swift
public extension Trie where CollectionType: RangeReplaceableCollection {
    
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
}
```

prefix-matching 알고리즘은 `CollectionType`이 `RangeReplaceableCollection`으로 제한된 extension  내에 자리해야 한다. 이는 알고리즘에서 `append` 메소드를 사용해야 하기 때문이다.

1. 접두어를 포함하는지 확인을 먼저한다. 없다면 빈 배열을 반환한다.
2. 접두어의 끝을 나타내는 노드를 찾은 후에는 재귀적으로 `collections(startingWith:after)`를 호출해 current 노드 이후의 모든 시퀀스를 찾도록 한다. 

```swift
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
```

1. 결과를 담을 빈 배열을 만든다. 현재 노드가 끝난다면 (terminating), 그 노드를 이 배열에 추가한다.
2. 다음으로 현재 노드의 자식을 확인한다. 모든 자식 노드에게 `collections(StartingWith:after:)`를 재귀적으로 호출해 terminating node를 찾도록 한다.

collection(startingWith:)는 O(k*m)의 시간복잡도를 가진다. (단, k는 접두사와 일치하는 가장 긴 컬렉션이며, m은 접두어와 일치하는 컬렉션의 크기다.)

배열은 O(k*n)의 시간 복잡성을 가지고 있으며, 여기서 n은 컬렉션의 요소 수입니다.

각 컬렉션이 균일하게 분포된 대규모 데이터셋의 경우, 접두사 매칭을 위해 배열을 사용하는 것보다 훨씬 더 나은 성능을 보인다.

## 🔑 Key points

- 트라이는 접두사 매칭에 대해 훌륭한 성능을 보인다.
- 개별 노드가 많은 다른 값 간에 공유될 수 있기 때문에 트라이는 상대적으로 메모리 효율적이다. 예를 들어, "car", "carbs", "care"는 단어의 처음 세 글자를 공유할 수 있다.
