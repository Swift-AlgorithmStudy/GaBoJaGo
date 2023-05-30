# Chapter 18: Tries

트라이(Trie)란 문자열을 저장하고 효율적으로 탐색하기 위한 트리 형태의 자료구조입니다.

<img width="500" alt="스크린샷 2023-05-30 오후 3 25 31" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/6b2844b3-dbcf-4093-94cd-4f262ceee57e">

각 문자는 노드에 매핑되며, 마지막 노드는 종료를 나타내는 점으로 표시됩니다.

트라이의 이점은 접두사 매칭의 문맥에서 살펴보면 가장 잘 설명됩니다.

이 장에서는 트라이의 성능을 배열과 비교한 후, 트라이를 처음부터 구현할 것입니다!

## 예시

주어진 문자열 컬렉션에서 접두사 매칭을 처리하는 컴포넌트를 구축하는 방법을 설명드리겠습니다.

```swift
class EnglishDictionary {
	private var words: [String]
	func words(matching prefix: String) -> [String] {
		words.filter { $0.hasPrefix(prefix) }
	}
}
```

words(matching:) 함수는 문자열 컬렉션을 확인하고 접두사와 일치하는 문자열을 반환합니다.

이 알고리즘은 words 배열에 있는 요소 수가 적을 경우 합리적입니다.

그러나 수천 개 이상의 단어를 다루는 경우 words 배열을 확인하는 데 걸리는 시간은 받아들일 수 없을 정도로 오래 걸릴 수 있습니다.

words(matching:)의 시간 복잡도는 O(k*n)이며, 여기서 k는 컬렉션에서 가장 긴 문자열의 길이이고 n은 확인해야 하는 단어 수입니다.

<img width="500" alt="스크린샷 2023-05-30 오후 3 47 58" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/a67734e9-6ec1-464b-b6ee-e149088e3033">

트라이(Trie) 데이터 구조는 이 문제에 대해 탁월한 성능 특성을 가지고 있습니다.

각 노드가 여러 자식을 지원하는 트리로, 각 노드는 하나의 문자를 나타낼 수 있습니다.

루트에서 특별한 표시인 종결자(검은 점으로 표시)가 있는 노드까지 문자열 컬렉션을 추적하여 단어를 형성합니다.

트라이의 흥미로운 특성 중 하나는 여러 단어가 동일한 문자를 공유할 수 있다는 것입니다.

트라이의 성능 이점을 설명하기 위해 CU 접두사를 가진 단어를 찾아야 하는 다음 예시를 살펴보겠습니다.

먼저 C를 포함하는 노드로 이동합니다. 이렇게 함으로써 검색 작업에서 다른 브랜치를 빠르게 배제할 수 있습니다.

<img width="400" alt="스크린샷 2023-05-30 오후 3 49 00" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/297b7157-1686-47c0-ad56-d0461fda0207">

다음으로 다음 문자 U를 가진 단어를 찾아야 합니다. U 노드로 이동합니다.

<img width="400" alt="스크린샷 2023-05-30 오후 3 49 33" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/0adf2fc3-93c6-4af3-b936-2decc6b2f17d">

이 접두사의 끝이므로, 트라이는 U 노드부터 형성된 노드 체인에 의해 형성된 모든 컬렉션을 반환합니다. 이 경우 CUT와 CUTE라는 단어가 반환됩니다. 수십만 개의 단어가 포함된 트라이를 상상해보세요.
트라이를 사용하여 피할 수 있는 비교 횟수는 상당합니다.

<img width="500" alt="스크린샷 2023-05-30 오후 3 50 13" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/897db22c-1aa3-49c5-afe8-8aff3b41bcb9">

## 구현

### TrieNode
****

```swift
public class TrieNode<Key: Hashable> {
	// 1 key는 노드의 데이터를 저장합니다.
	// 트라이의 루트 노드는 키가 없으므로 이는 옵셔널로 선언되어 있습니다.
	public var key: Key?
	// 2 TrieNode는 부모에 대한 약한 참조(weak reference)를 가지고 있습니다.
	// 이 참조는 이후에 remove 메서드를 간단하게 구현하기 위한 것입니다.
	public weak var parent: TrieNode?
	// 3 이진 검색 트리에서는 노드가 왼쪽과 오른쪽 자식을 가집니다.
	// 그러나 트라이에서는 노드가 여러 요소를 가지고 있어야 합니다.
	// 따라서 children 딕셔너리를 사용하여 처리합니다.
	public var children: [Key: TrieNode] = [:]
	// 4 앞서 언급한 대로, isTerminating은 컬렉션의 끝을 나타내는 지시자로 작용합니다.
	public var isTerminating = false
	public init(key: Key?, parent: TrieNode?) {
		self.key = key
		self.parent = parent
	}
}
```

### **Trie**

```swift
public class Trie<CollectionType: Collection>
where CollectionType.Element: Hashable {
	public typealias Node = TrieNode<CollectionType.Element>
	private let root = Node(key: nil, parent: nil)
	public init() {}
}
```

Trie 클래스는 String을 포함한 Collection 프로토콜을 채택하는 모든 타입에 사용할 수 있습니다. 또한, 컬렉션 내의 각 요소는 Hashable 프로토콜을 채택해야 합니다. 이 추가적인 제약은 TrieNode의 children 딕셔너리에서 컬렉션의 요소를 키로 사용하기 때문에 필요합니다.
다음으로, 트라이에 대해 네 가지 작업을 구현할 것입니다: insert, contains, remov, prefix match

### Insert
****

삽입(Insert) 작업은 트라이에 컬렉션을 삽입하는 작업입니다. 트라이는 컬렉션의 각 요소를 나타내는 노드들의 연속으로 표현됩니다.

```swift
public func insert(_ collection: CollectionType) {
	// 1
	// 현재 노드를 추적하기 위해 current 변수가 사용되며, 시작은 루트 노드로 설정됩니다.
	var current = root
	// 2
	// 트라이는 각 컬렉션 요소를 별도의 노드에 저장합니다.
	// 각 요소에 대해 현재 노드가 children 딕셔너리에 존재하는지 확인합니다.
	// 존재하지 않는 경우 새로운 노드를 생성합니다. 각 루프에서 current를 다음 노드로 이동합니다.
	for element in collection {
		if current.children[element] == nil {
			current.children[element] = Node(key: element, parent: current)
		}
		current = current.children[element]!
	}
	// 3
	// for 루프를 순회한 후에는 current가 컬렉션의 끝을 나타내는 노드를 참조해야 합니다.
	// 해당 노드를 종료 노드로 표시합니다.
	// 이 알고리즘의 시간 복잡도는 O(k)이며, 여기서 k는 삽입하려는 컬렉션의 요소 수입니다.
	// 이 비용은 각 새로운 컬렉션 요소를 나타내는 노드를 순회하거나 생성해야 하기 때문입니다.
	current.isTerminating = true
}
```

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

example(of: "insert and contains") {
	let trie = Trie<String>()
	trie.insert("cute")
	if trie.contains("cute") {
		print("cute is in the trie")
	}
}
```

여기서는 삽입과 유사한 방식으로 트라이를 순회합니다. 컬렉션의 각 요소를 확인하여 트리에 있는지 확인합니다. 컬렉션의 마지막 요소에 도달하면 종료 요소여야 합니다. 그렇지 않으면 컬렉션이 추가되지 않았으며, 찾은 것은 더 큰 컬렉션의 부분집합입니다.
contains의 시간 복잡도는 O(k)입니다. 여기서 k는 검색에 사용되는 컬렉션의 요소 수입니다. 이 시간 복잡도는 컬렉션이 트라이에 있는지 확인하기 위해 k개의 노드를 순회해야 하기 때문입니다.

### Remove
****

트라이에서 노드를 제거하는 것은 약간 까다로울 수 있습니다. 각 노드를 제거할 때 특히 주의해야 하며, 여러 컬렉션이 동일한 노드를 공유할 수 있습니다.

```swift
public func remove(_ collection: CollectionType) {
	// 1
	// 이 부분은 contains의 구현과 유사합니다.
	// 여기서는 컬렉션이 트라이에 포함되어 있는지 확인하고, current를 컬렉션의 마지막 노드로 설정합니다.
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
	// isTerminating을 false로 설정하여 다음 단계의 루프에서 현재 노드가 제거될 수 있도록 합니다.
	current.isTerminating = false
	// 3 이 부분이 조금 복잡합니다.
	// 노드가 공유될 수 있기 때문에, 다른 컬렉션에 속하는 요소를 제거하지 않도록 주의해야 합니다.
	// 현재 노드에 다른 자식이 없다면, 다른 컬렉션은 현재 노드에 의존하지 않는다는 의미입니다.
	// 또한 현재 노드가 종료 노드인지 확인합니다. 종료 노드인 경우, 다른 컬렉션에 속합니다.
	// current가 이러한 조건을 만족하는 한,
	// 부모 속성(parent property)을 따라 계속해서 되돌아가며 노드를 제거합니다.
	// 이 알고리즘의 시간 복잡도는 O(k)이며, 여기서 k는 제거하려는 컬렉션의 요소 수를 나타냅니다.
	while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
		parent.children[current.key!] = nil
		current = parent
	}
}

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

## Prefix matching

```swift
public extension Trie where CollectionType: RangeReplaceableCollection {}
```

접두사 매칭 알고리즘은 RangeReplaceableCollection로 제한된 CollectionType의 extension 내에 위치할 것입니다.

이 준수는 알고리즘이 RangeReplaceableCollection 타입의 append 메서드에 접근해야 하기 때문에 필요합니다.

```swift
func collections(startingWith prefix: CollectionType) -> [CollectionType] {
	// 1
	// 우선 트라이가 접두사를 포함하는지 확인합니다.
	// 만약 포함하지 않는다면, 빈 배열을 반환합니다.
	var current = root
	for element in prefix {
		guard let child = current.children[element] else {
			return []
		}
		current = child
	}
	// 2
	// 접두사의 끝을 표시하는 노드를 찾은 후, 현재 노드 이후의 모든 시퀀스를 찾기 위해
	// 재귀적인 보조 메서드 collections(startingWith:after:)를 호출합니다.
	return collections(startingWith: prefix, after: current)
}
```

```swift
private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
	// 1 결과를 저장할 배열을 생성합니다.
	// 현재 노드가 종료 노드인 경우, 결과에 추가합니다.
	var results: [CollectionType] = []
	if node.isTerminating {
		results.append(prefix)
	}
	// 2 다음으로, 현재 노드의 자식들을 확인해야 합니다.
	// 각 자식 노드에 대해 collections(startingWith:after:)를 재귀적으로 호출하여 다른 종료 노드를 찾습니다.
	for child in node.children.values {
		var prefix = prefix
		prefix.append(child.key!)
		results.append(contentsOf: collections(startingWith: prefix, after: child))
	}
	return results
}
```

collection(startingWith:) 메서드의 시간 복잡도는 O(k * *m)입니다.*

여기서 k는 접두사와 일치하는 가장 긴 컬렉션의 길이를 나타내고, m은 접두사와 일치하는 컬렉션의 수를 나타냅니다.
**앞서 언급한 바와 같이 배열의 시간 복잡도는 O(k * n)이며, 여기서 n은 컬렉션의 요소 수입니다.

각 컬렉션이 균일하게 분포된 대규모 데이터에 대해서는, 트라이를 사용하는 것이 접두사 매칭에 대해 배열을 사용하는 것보다 훨씬 더 우수한 성능을 보입니다.

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
["car", "carbs", "care", "cared", "cars", "carapace", "cargo",
"card"]
Collections starting with "care"
["care", "cared"]
```

## Key Points

- 트라이는 접두사 매칭에 대해 훌륭한 성능 지표를 제공합니다.
- 트라이는 개별 노드를 여러 다른 값들 사이에서 공유할 수 있기 때문에 상대적으로 메모리 효율적입니다.
예를 들어, "car", "carbs", "care"는 단어의 처음 세 글자를 공유할 수 있습니다.