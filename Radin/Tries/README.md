# Chap8. Tries

## 1. Trie란?

Trie는 영어 단어와 같이 컬렉션으로 나타낼 수 있는 데이터를 저장하는 것을 전문으로 하는 트리입니다.

각 문자열 문자는 마지막 노드(위 다이어그램에서 몹으로 표시됨)가 종료되는 노드에 매핑됩니다. 트라이의 이점은 접두사 매칭의 맥락에서 그것을 보면 가장 잘 설명됩니다. 

트라이 데이터 구조는 여러 자식을 지원하는 노드가 있는 트리로서, 각 노드는 단일 문자를 나타낼 수 있습니다.

루트에서 마침표가 표시된 노드로 문자 모음을 추적하여 단어를 형성합니다. 트리의 흥미로운 특징은 여러 단어가 같은 문자를 공유할 수 있다는 것입니다.

Trie의 성능 이점을 설명하기 위해, CU 접두사가 있는 단어를 찾아야 하는 다음 예를 봐볼까요?

먼저, 당신은 C가 포함된 노드로 이동합니다. 그것은 검색 작업에서 트라이의 다른 지점을 빠르게 제외합니다:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/126a1f4d-2d79-4d04-955e-13bb96399d57" alt="Image" width="300">

다음으로, 다음 글자 U가 있는 단어를 찾아야 합니다.  U 노드로 넘어가세요:

<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/0baf30b6-f840-44da-adfd-c3ae1c875e0e" alt="Image" width="300">

그것이 당신의 접두사의 끝이며, 트리는 U 노드의 노드 체인에 의해 형성된 모든 컬렉션을 반환할 것입니다. 이 경우, CUT와 CUTE라는 단어가 반환될 것입니다. 이 시도가 수십만 단어를 포함하고 있다고 상상해 보세요.

트라이를 활용함으로써 피할 수 있는 비교의 수는 상당합니다.

## 2. Implementation

### 1) TrieNode

```swift
//TrieNode.swift.
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

이 인터페이스는 당신이 만난 다른 노드와 약간 다릅니다:

1. 키는 노드의 데이터를 보유하고 있습니다. 트라이의 루트 노드에는 키가 없기 때문에 이것은 옵셔널입니다.
2. 트라이노드는 부모에 대한 약한 참조를 가지고 있습니다. 이 참조는 나중에 제거 방법을 단순화합니다.
3. 이진탐색트리와 달리, 트라이의 노드는 여러 개의 다른 요소를 보유해야 합니다. 이를 위해 children 딕셔너리를 선언했습니다.
4. isTerminating은 컬렉션의 끝을 나타내는 지표 역할을 합니다.

### 2) Trie

다음으로 노드를 관리할 트라이 자체를 만들 것입니다.

```swift
//Trie.swift
public class Trie<CollectionType: Collection>
    where CollectionType.Element: Hashable {

  public typealias Node = TrieNode<CollectionType.Element>

  private let root = Node(key: nil, parent: nil)

  public init() {}
}
```

String을 포함하여 Collection 프로토콜을 채택한 모든 유형에 Trie 클래스를 사용할 수 있습니다. 

이 요구 사항 외에도, 컬렉션 내부의 각 요소는 Hashable해야 합니다. 이는 컬렉션의 요소를 TrieNode의 child Dictionary의 키로 사용하기 때문에 필요합니다.

다음으로, trie에 대한 네 가지 작업을 구현할 것입니다.

**삽입, 포함, 제거 및 접두사 일치.**

### 3) Insert

컬렉션에 부합하는 모든 유형으로 작업하려고 합니다. 트리는 컬렉션을 가져가서 컬렉션의 각 요소에 대해 하나씩 일련의 노드로 나타낼 것이다.

```swift
//Trie.swift
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

1.  current변수는 루트 노드로 시작하는 횡단 진행 상황을 추적합니다.
2. 트리는 각 컬렉션 요소를 별도의 노드에 저장합니다. 컬렉션의 각 요소에 대해, 먼저 노드가 현재 자식 사전에 존재하는지 확인합니다. 그렇지 않으면, 새 노드를 만드세요. 각 루프 동안, 당신은 current를 다음 노드로 이동합니다.
3. For 루프를 반복한 후, current는 컬렉션의 끝을 나타내는 노드를 참조해야 합니다. 당신은 그 노드를 종료 노드로 표시합니다.

이 알고리즘의 시간 복잡성은 O(k)이며, 여기서 k는 삽입하려는 컬렉션의 요소 수입니다. 각각의 새로운 컬렉션 요소를 나타내는 각 노드를 통과하거나 만들어야 하기 때문입니다.

### 4) Contains

포함은 삽입과 매우 유사하다.

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

여기서, 당신은 삽입과 비슷한 방식으로 트라이를 횡단합니다. 컬렉션의 모든 요소를 확인하여 트리에 있는지 확인합니다. 컬렉션의 마지막 요소에 도달하면, 종료 요소여야 합니다. 그렇지 않다면, 컬렉션은 추가되지 않았고, 당신이 찾은 것은 더 큰 컬렉션의 하위 집합입니다.

포함의 시간 복잡성은 O(k)이며, 여기서 k는 검색에 사용하는 컬렉션의 요소 수입니다. 이 시간의 복잡성은 컬렉션이 트라이에 있는지 여부를 결정하기 위해 k 노드를 가로지르는 것에서 비롯된다.

### 5) Remove

트리에서 노드를 제거하는 것은 조금 까다롭다. 여러 컬렉션이 노드를 공유할 수 있기 때문에 각 노드를 제거할 때 특히 주의해야 합니다.

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

1. 이 부분은 포함의 구현이기 때문에 친숙해 보여야 한다. 여기서 그것을 사용하여 컬렉션이 트리의 일부인지 확인하고 컬렉션의 마지막 노드로 현재를 가리킵니다.
2. 다음 단계에서 루프로 현재 노드를 제거할 수 있도록 isTerminating을 false로 설정합니다.
3. 이건 까다로운 부분이야. 노드를 공유할 수 있기 때문에, 다른 컬렉션에 속한 요소를 제거하고 싶지 않습니다. 현재 노드에 다른 자식 노드가 없으면 다른 컬렉션이 현재 노드에 종속되지 않음을 의미합니다.
    
    현재 노드가 종료되는지도 확인합니다. 그렇다면 다른 컬렉션에 속합니다. 전류가 이러한 조건을 충족하는 한, 상위 속성을 통해 계속해서 역추적하고 노드를 제거합니다.
    

이 알고리즘의 시간 복잡성은 O(k)이며, 여기서 k는 제거하려는 컬렉션의 요소 수를 나타냅니다.

### 6) Prefix matching

Trie의 가장 상징적인 알고리즘은 접두사 매칭 알고리즘입니다. 

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

	private func collections(startingWith prefix: CollectionType,
	                         after node: Node) -> [CollectionType] {
	  // 3
	  var results: [CollectionType] = []
	
	  if node.isTerminating {
	    results.append(prefix)
	  }
	
	  // 4
	  for child in node.children.values {
	    var prefix = prefix
	    prefix.append(child.key!)
	    results.append(contentsOf: collections(startingWith: prefix, after: child))
	  }
	  return results
	}
}
```

당신의 접두사 일치 알고리즘은 이 extension 프로그램 내부에 위치할 것이며, CollectionType은 RangeReplaceableCollection으로 제한됩니다. 이 준수는 알고리즘이 RangeReplaceableCollection 타입의 append 메서드에 접근해야하기 때문에 필요합니다.

1. 당신은 트리에 접두사가 포함되어 있는지 확인하는 것으로 시작합니다. 그렇지 않다면, 빈 배열을 반환합니다.
2. 접두사의 끝을 표시하는 노드를 찾은 후, private 메서드를 호출하여 현재 노드 이후의 모든 시퀀스를 찾습니다.
3. 결과를 보관하기 위해 배열을 만듭니다. 현재 노드가 종료되면, 결과에 추가합니다.
4. 다음으로, 현재 노드의 자식을 확인해야 합니다. 모든 자식 노드에 대해, 다른 종료 노드를 찾기 위해 컬렉션(startingWith:after:)을 재귀적으로 호출합니다.

collection(startingWith:)의 시간 복잡도 O(k*m)를 가지며, 여기서 k는 접두사와 일치하는 가장 긴 컬렉션을 나타내고 m은 접두사와 일치하는 컬렉션 수를 나타냅니다.

배열은 O(k*n)의 시간 복잡성을 가지고 있으며, 여기서 n은 컬렉션의 요소 수입니다.

각 컬렉션이 균일하게 분포된 대규모 데이터 세트의 경우, 접두사 매칭을 위해 배열을 사용하는 것보다 훨씬 더 나은 성능을 발휘합니다.

## 🗝️ Key points

- trie는 접두사 매칭과 관련하여 훌륭한 성능 지표를 제공한다.
- 개별 노드가 많은 다른 값 간에 공유될 수 있기 때문에 트라이는 상대적으로 메모리 효율적이다. 예를 들어, car, carbs, care는 단어의 처음 세 글자를 공유할 수 있다.
