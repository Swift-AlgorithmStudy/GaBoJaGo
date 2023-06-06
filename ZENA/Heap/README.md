# Heap

힙은 가장 크거나 작은 요소를 빠르게 가져오는 데 좋은 특별한 속성을 가진 또 다른 고전적인 트리 기반 데이터 구조이다.

이번 챕터에서는 힙을 만들고 조작해보자. 컬렉션의 최소 및 최대 요소를 가져오는 것이 얼마나 편리한지 알게 될 것이다.

## What is heap?

힙은 배열을 사용하여 구성할 수 있는 이진 힙으로도 알려진 완전 이진 트리이다.

```
Note: 이 힙을 메모리 힙과 혼동하지 마라.
힙이라는 용어는 때때로 컴퓨터 과학에서 메모리 풀을 지칭하기 위해 혼동스럽게 사용된다. 
메모리 힙은 여기서 공부하고 있는 것이 아닌 다른 개념이다.
```

힙은 두가지 종류가 있따.

1. **Max heap** 더 높은 값을 가진 요소가 더 높은 우선 순위를 갖는 힙
2. **Min heap** 더 낮은 값을 가진 요소가 우선 순위가 더 높은 힙

## The heap property

힙은 항상 만족해야 하는 필수적인 특징을 지닌다. 이 특성은 **heap invariant 힙 불변** 또는 **heap property 힙 속성**으로 알려져 있다.

<img width="486" alt="스크린샷 2023-06-05 오후 6 43 52" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/8267f659-4fa5-4840-a8af-32b5b37571da">

최대 힙에서 부모 노드는 항상 그 자식 노드보다 크거나 같아야 한다. 루트 노드는 항상 가장 큰 값이어야 한다.

최소 힙에서 부모 노드는 항상 그의 자식보다 작거나 같은 값을 가져야 한다. 루트노드는 항상 가장 작은 값을 가진다.

<img width="487" alt="스크린샷 2023-06-05 오후 6 48 11" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/47b0155a-1689-4102-a07a-1800086ea83f">

힙의 또 다른 필수 속성은 거의 **완전 이진 트리**라는 것이다. 이는 마지막 레벨을 제외한 모든 레벨이 채워져야 한다는 것을 의미한다.

## Heap applications

힙의 몇 가지 실용적인 응용은 다음과 같다.

- 컬렉션의 최소 또는 최대 요소 계산
- 힙 정렬
- 우선 순위 대기열 구성
- Prim이나 Dijkstra와 같은 그래프 알고리즘은 우선순위큐로 구성

```
**Note**: Chapter 24. 우선순위큐, Chapter 32. 힙 정렬, Chapter 42 & 44. 다익스트라와 프림 알고리즘
```

## Common heap operations

다음과 같은 기본 `Heap` 유형을 정의해보자

```swift
struct Heap<Element: Equatable> {

  var elements: [Element] = []
  let sort: (Element, Element) -> Bool

  init(sort: @escaping (Element, Element) -> Bool) {
    self.sort = sort
  }
}
```

이 유형에는 힙의 요소를 담는 배열과 힙을 정렬하는 방법을 정의하는 정렬 함수가 포함되어 있다. 이니셜라이저에 적절한 함수를 전달함으로써, 이 타입은 최소와 최대 힙을 모두 만들 수 있다.

## How do you represent a heap?

트리는 자식에 대한 참조를 저장하는 노드를 보유하고 있다. 이진 트리의 경우, 이들은 왼쪽과 오른쪽 자식에 대한 참조이다. 힙은 실제로 이진수이지만, 간단한 배열로 나타낼 수 있다. 이 표현은 트리를 만드는 특이한 방법처럼 보일 수 있다. 하지만 이 힙 구현의 이점 중 하나는 힙의 요소가 모두 메모리에 함께 저장되기 때문에 *효율적인 시간과 공간의 복잡도*이다. 나중에 **스와핑** 요소가 힙 작업에서 큰 역할을 할 것이라는 것을 알게 될 것이다. 또, 이 방법은 이진 트리보다 배열로 하는 것이 더 쉽다. 배열을 사용하여 힙을 어떻게 나타낼 수 있는지 살펴보자. 

<img width="455" alt="스크린샷 2023-06-06 오후 8 13 39" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/ba1dcdbf-aa8b-44f1-9cbe-58ef54395386">

위의 힙을 배열로 나타내기 위해, 각 요소를 왼쪽에서 오른쪽으로 레벨별로 반복한다.

순회는 다음과 같이 보인다.

<img width="519" alt="스크린샷 2023-06-06 오후 8 13 48" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/fd6d5783-a5b9-40bb-b4b2-5907320bcb51">

레벨을 올라가면, 이전 레벨보다 두 배나 많은 노드를 갖게 될 것입니다.

이제 힙의 모든 노드에 쉽게 접근할 수 있다. 이를 배열의 요소에 접근하는 방법과 비교할 수 있다: 왼쪽 또는 오른쪽 브랜치를 순회하는 대신, 간단한 공식을 사용하여 배열의 노드에 액세스할 수 있다.

제로 기반 인덱스 i의 노드가 주어지면:

- 이 노드의 **left child**는 인덱스 `2*i + 1`에 있다.
- 이 노드의 **right child**는 인덱스 `2*i + 2`에 있다.
    

<img width="622" alt="스크린샷 2023-06-06 오후 8 21 22" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/deaa26d9-652f-40c5-aa95-883885c1bc8c">


노드의 부모를 얻고 싶을 수도 있다. 이 경우 `i`를 이용해 해결할 수 있다. 인덱스 `i`의 자식 노드라면, 이 자식의 부모 노드는 인덱스 `floor( (i - 1) / 2)`에서 찾을 수 있다.

```swift
Note: 노드의 왼쪽과 오른쪽 자식을 얻기 위해 실제 이진 트리를 가로지르는 것은 O(log n) 작업이다.
반면 배열과 같은 무작위 액세스 데이터 구조에서 위와 같은 작업은 O(1)일 뿐이다.
```

다음으로, 새로운 지식을 사용하여 `Heap`에 몇 가지 속성과 편리한 메소드를 추가해보자.

```swift
var isEmpty: Bool {
  elements.isEmpty
}

var count: Int {
  elements.count
}

func peek() -> Element? {
  elements.first
}

func leftChildIndex(ofParentAt index: Int) -> Int {
  (2 * index) + 1
}

func rightChildIndex(ofParentAt index: Int) -> Int {
  (2 * index) + 2
}

func parentIndex(ofChildAt index: Int) -> Int {
  (index - 1) / 2
}
```

이제 배열을 사용하여 힙을 나타내는 방법을 잘 이해했으므로, 힙의 몇 가지 중요한 작업을 살펴보자.

## Removing from a heap

기본적인 제거 작업은 힙에서 루트 노드를 제거하는 것이다. 최대 힙에서 다음과 같이 작업을 수행한다.

<img width="543" alt="스크린샷 2023-06-06 오후 8 29 06" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/09f708c3-2036-492f-88b4-363739227874">

제거 작업은 루트 노드의 최대 값을 제거한다. 그렇게 하려면, 먼저 루트 노드를 힙의 마지막 요소로 바꾼다.

<img width="544" alt="스크린샷 2023-06-06 오후 8 29 17" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/abd7203c-0185-44a3-a487-e6f637b239f1">

이거 왜 갑자기 10이었다가 7이 되고 10은 마지막 노드로 가고 다시 3이 됨?? 그림 잘못나온듯?

두 요소를 바꾸면, 마지막 요소를 제거하고 값을 저장하여 나중에 반환할 수 있다.

이제, 최대 힙의 무결성을 확인해야 한다. 하지만 먼저, 스스로에게 물어라, "여전히 최대 힙인가?"

**Remember**: 최대 힙의 규칙은 모든 부모 노드의 값이 자식의 값보다 크거나 같아야 한다. 힙이 더 이상 이 규칙을 따르지 않기 때문에, **sift down 선별 작업**을 수행해야 한다.

<img width="543" alt="스크린샷 2023-06-06 오후 8 29 25" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/6050f0f2-10f5-415e-939d-7cdaac867f9d">

sift down을 수행하려면, 현재 값 3에서 시작하여 왼쪽과 오른쪽 자식을 확인해라. 자식 중 하나가 현재 값보다 큰 값을 가지고 있다면, 부모와 교환해라. 두 자식 모두 더 큰 값이라면, 부모를 더 큰 값을 가진 자식과 바꾼다.

<img width="543" alt="스크린샷 2023-06-06 오후 8 29 37" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/eb17406a-0b22-4966-8839-8b8e318af4ea">

그럼 이제 노드들의 값이 그의 자식들보다 크지 않다면 sift down을 계속 하면 된다.

<img width="543" alt="스크린샷 2023-06-06 오후 8 43 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/5c6783c6-dfab-43c1-9579-912c75d3c670">

끝에 도달했다면 끝난거다! 최대 힙의 속성이 복원됐따

### Implementation of remove

`Heap`에 다음 메소드를 추가해라.

```swift
mutating func remove() -> Element? {
  guard !isEmpty else { // 1
    return nil
  }
  elements.swapAt(0, count - 1) // 2
  defer {
    siftDown(from: 0) // 4
  }
  return elements.removeLast() // 3
}
```

1. 힙이 비어 있는지 확인하고, 만약 그렇다면, `nil`을 반환한다.
2. 루트를 힙의 마지막 요소로 바꾼다.
3. 마지막 요소(최대 또는 최소값)를 제거하고 반환한다.
4. 힙은 더 이상 최대 또는 최소 힙이 아닐 수 있으므로, 규칙을 준수하는지 확인하기 위해 sift down을 수행해야 한다.

이제, 노드를 sift down하는 방법을 보려면, `remove()` 후에 다음 방법을 추가한다:

```swift
mutating func siftDown(from index: Int) {
  var parent = index // 1
  while true { // 2
    let left = leftChildIndex(ofParentAt: parent) // 3
    let right = rightChildIndex(ofParentAt: parent)
    var candidate = parent // 4
    if left < count && sort(elements[left], elements[candidate]) {
      candidate = left // 5
    }
    if right < count && sort(elements[right], elements[candidate]) {
      candidate = right // 6
    }
    if candidate == parent {
      return // 7
    }
    elements.swapAt(parent, candidate) // 8
    parent = candidate
  }
}
```

`siftDown(from:)`은 임의의 인덱스를 받는다. 이 인덱스의 노드는 항상 부모 노드로 취급될 것이다. 메소드의 동작은 다음과 같다:

1. `parent` 인덱스를 저장하세요.
2. `return`할 때까지 sift을 계속한다.
3. 부모의 왼쪽과 오른쪽 자식 인덱스를 받는다.
4. `candidate` 변수는 부모와 스왑할 인덱스를 추적하는 데 사용된다.
5. 만약 왼쪽 자식이 있고, 부모보다 우선순위가 높다면, 그것을 `candidate`로 만든다.
6. 오른쪽 자식이 있고, 더 큰 우선순위를 가지고 있다면, 그것이 대신 `candidate`가 될 것이다.
7. `candidate`가 여전히 부모라면, 끝에 도달했고, 더 이상 sifting이 필요하지 않다.
8. candidate를 parent와 교환하고, sifting을 계속하기 위해 새로운 부모로 설정한다.

```swift
**Complexity**: **remove()**의 전반적인 복잡성은 **O(log n)**이다. 
배열의 요소를 바꾸려면 **O(1)**만 걸리는 반면, 힙의 요소를 sifting down하는 데는 **O(log n)** 시간이 걸린다.
```

이제 힙에 추가는 어떻게 할까?

## Inserting into a heap

아래 힙에 7의 값을 삽입한다고 가정해 보자

<img width="621" alt="스크린샷 2023-06-06 오후 8 51 56" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/b91e7f16-c837-4c14-9fc4-47f16a1edc7f">

먼저, 힙 끝에 값을 추가해라:


<img width="621" alt="스크린샷 2023-06-06 오후 8 52 36" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/fedd7229-75c7-4b6a-9420-c0ed02c50152">

이제, 최대 힙의 속성을 확인해야 한다. sifting down 대신, 방금 삽입한 노드가 부모보다 우선 순위가 높을 수 있기 때문에 이제는 sift up해야 한다. 이 sifting up은 현재 노드를 부모와 비교하고 필요한 경우 교환하여 sifting down하는 것과 매우 비슷하다.


<img width="621" alt="스크린샷 2023-06-06 오후 8 56 54" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/c936884f-3529-4eaf-a5ff-b4f04badae99">

<img width="621" alt="스크린샷 2023-06-06 오후 8 57 03" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/0b4e2613-c04c-4b2c-953c-1b718f092205">

<img width="620" alt="스크린샷 2023-06-06 오후 8 57 12" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/c482c912-3276-4e1b-8c5d-aa6c1ac961ea">

그러면 이제 힙이 최대 힙 조건을 만족했다!

### Implementation of insert

`Heap`에 다음 메소드를 추가한다:

```swift
mutating func insert(_ element: Element) {
  elements.append(element)
  siftUp(from: elements.count - 1)
}

mutating func siftUp(from index: Int) {
  var child = index
  var parent = parentIndex(ofChildAt: child)
  while child > 0 && sort(elements[child], elements[parent]) {
    elements.swapAt(child, parent)
    child = parent
    parent = parentIndex(ofChildAt: child)
  }
}
```

보시다시피, 구현은 꽤 간단하다:

- `insert`는 배열에 요소를 추가한 다음 sift up을 수행
- `siftUp`은 해당 노드가 부모보다 우선 순위가 높은 한 현재 노드를 부모와 교환

```swift
Complexity: insert(_:)의 전반적인 복잡성은 O(log n)이다. 
배열에 요소를 추가하려면 O(1)만 필요한 반면, 힙에서 요소를 선별하려면 O(log n)이 필요하다.
```

이게 힙에 요소를 삽입하는 전부이다.

지금까지 힙에서 **루트**를 제거하고 힙에 삽입하는 것을 봤다. 하지만 힙에서 **임의의 요소**를 제거하고 싶다면 어떨까?

## Removing from an arbitrary index

`Heap`에 다음을 추가해라:

```swift
mutating func remove(at index: Int) -> Element? {
  guard index < elements.count else {
    return nil // 1
  }
  if index == elements.count - 1 {
    return elements.removeLast() // 2
  } else {
    elements.swapAt(index, elements.count - 1) // 3
    defer {
      siftDown(from: index) // 5
      siftUp(from: index)
    }
    return elements.removeLast() // 4
  }
}
```

힙에서 요소를 제거하려면 인덱스가 필요하다. 어떻게 작동하는지 살펴보자:

1. 인덱스가 배열의 범위 내에 있는지 확인하고, 그렇지 않다면, `nil`을 반환한다.
2. 힙의 마지막 요소를 제거한다면, 특별한 것을 할 필요가 없다. 간단히 요소를 제거하고 반환한다.
3. 마지막 요소를 제거하지 않는다면, 먼저 요소를 마지막 요소로 바꾼다.
4. 그런 다음, 마지막 요소를 반환하고 제거한다.
5. 마지막으로, 힙을 조정하기 위해 sift down과 sift up을 수행한다.

하지만 — 왜 sift down과 up을 모두 수행해야 할까?

**5**를 제거하려고 한다고 가정해 보자. **5**를 마지막 요소인 **8**과 바꾼다. 이제 최대 힙 속성을 만족시키기 위해 sift up을 수행해야 한다.

<img width="621" alt="스크린샷 2023-06-06 오후 9 24 24" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/2b8f92a3-d448-420a-842f-ddc26af9e0a0">

이제, **7**을 제거하려고 한다고 가정해 보자. **7**을 마지막 요소인 **1**로 바꾼다. 이제 최대 힙 조건을 만족시키기 위해 sift down을 수행해야 한다.

<img width="582" alt="스크린샷 2023-06-06 오후 9 25 41" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/27209328-c3c0-44de-9957-e31bdd39e25e">

힙에서 임의의 요소를 제거하는 것은 `O(log n)` 작업이다. 하지만 삭제하고 싶은 요소의 인덱스를 어떻게 찾을까?

## Searching for an element in a heap

삭제하려는 요소의 인덱스를 찾으려면, 힙에서 검색을 수행해야 한다. 불행히도, 힙은 빠른 검색을 위해 설계되지 않았다. 이진 검색 트리를 사용하면 `O(log n)` 시간에 검색을 수행할 수 있지만, 힙은 배열을 사용하여 구축되고 배열의 노드 순서가 다르기 때문에 이진 검색도 수행할 수 없다.

```swift
Complexity: 힙에서 요소를 검색하는 것은 최악의 경우 O(n) 연산이다.
왜냐하면 배열의 모든 요소를 확인해야 할 수도 있기 때문이다.
```

```swift
func index(of element: Element, startingAt i: Int) -> Int? {
  if i >= count {
    return nil // 1
  }
  if sort(element, elements[i]) {
    return nil // 2
  }
  if element == elements[i] {
    return i // 3
  }
  if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
    return j // 4
  }
  if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
    return j // 5
  }
  return nil // 6
}
```

위 코드를 살펴보자:

1. 인덱스가 배열의 크기보다 크거나 같으면 검색이 실패한 것이므로 `nil`을 리턴한다.
2. 찾고 있는 요소가 인덱스 `i`의 현재 요소보다 우선 순위가 높은지 확인한다. 만약 그렇다면, 찾고 있는 요소는 힙에서 더 낮을 수 없다.
3. 요소가 인덱스 `i`의 요소와 같다면, `i`를 반환한다.
4. `i`의 왼쪽 자식부터 시작하는 요소를 재귀적으로 검색한다.
5. `i`의 오른쪽 자식부터 시작하는 요소를 재귀적으로 검색한다.
6. 두 검색이 모두 실패하면, 검색에 실패한 것이다. `nil`을 리턴한다.

```swift
**Note**: 검색은 **O(n)**의 시간이 걸리지만, 
힙의 조건을 활용하고 검색할 때 요소의 우선 순위를 확인하여 검색을 최적화하기 위해 노력해야 한다.
```

## Building a heap

이제 힙을 나타내는 데 필요한 모든 도구를 가지고 있따. 이 장을 마무리하기 위해, 기존 요소 배열에서 힙을 만들고 테스트해보자. 다음과 같이 힙의 이니셜라이저를 업데이트해라:

```swift
init(sort: @escaping (Element, Element) -> Bool,
     elements: [Element] = []) {
  self.sort = sort
  self.elements = elements

  if !elements.isEmpty {
    for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
      siftDown(from: i)
    }
  }
}
```

이니셜라이저는 이제 추가 매개 변수를 사용한다. 비어 있지 않은 배열이 제공되면, 이것을 힙의 요소로 사용한다. 힙의 속성을 만족시키기 위해, 첫 번째 리프가 아닌 노드에서 시작하여 배열을 뒤로 반복하고 모든 부모 노드를 sift down 한다. **리프** 노드를 sifting down하는 것은 의미가 없고 부모 노드만 있기 때문에 요소의 절반만 반복한다.

~~*Testing 생략*~~

## 🔑 Key points

- 다음은 이 장에서 구현한 힙 작업의 알고리즘 복잡성에 대한 요약이다:

<img width="779" alt="스크린샷 2023-06-06 오후 9 36 15" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/57654681/7d3c59f4-e8c9-43bd-aea0-7f87139a0110">

- 힙 데이터 구조는 가장 높거나 가장 낮은 우선순위 요소를 유지하는 데 좋다.
- 힙의 요소는 요소 조회를 위한 간단한 공식을 사용하여 인접한 메모리에 포장된다.
- 항목을 삽입하거나 제거할 때마다, 힙의 **힙 속성 heap property**를 보존하도록 주의해야 한다.
