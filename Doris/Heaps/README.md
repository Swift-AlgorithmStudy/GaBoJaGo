# Heaps

> 힙은 또 다른 전통적인 트리 기반 데이터 구조로, 가장 큰 또는 가장 작은 요소를 빠르게 가져오는 데 특별한 속성을 가지고 있어 매우 효과적입니다. </br>
</br>

## What is a heap? 
> Heap이 뭘까요 ~ ? </br>

* 힙은 배열을 사용하여 구성할 수 있는 `완전 이진 트리`인 이진 힙으로 알려진 구조입니다.

> 이 힙을 메모리 힙과 다릅니다. 컴퓨터 과학에서는 때때로 힙이라는 용어가 메모리 풀을 가리키기 위해 혼란스럽게 사용됩니다. 메모리 힙은 다른 개념이며 여기서 공부하는 것과 관련이 없습니다. </br> 

힙은 두 가지 유형이 있습니다. </br>

1. 최대 힙(Max Heap) : 값이 더 큰 요소가 더 높은 우선순위를 갖는 힙
2. 최소 힙(Min Heap) : 값이 더 작은 요소가 더 높은 우선순위를 갖는 힙

</br> </br>

## The heap property
> 힙의 중요한 특성들을 알아보자 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/d0b56d48-17b0-4042-9514-8c4d5ee35ccd">
</br>

* 최대 힙의 경우, 부모 노드는 항상 자식 노드보다 `크거나 같은 값`을 가져야 합니다. 루트 노드에는 항상 가장 큰 값이 들어 있어야 합니다.
* 최소 힙의 경우, 부모 노드는 항상 자식 노드보다 `작거나 같은 값`을 가져야 합니다. 루트 노드에는 항상 가장 작은 값이 들어 있어야 합니다.
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/509686a3-b1e0-4005-9bc8-8fbe6802cddf">

힙의 또 다른 중요한 특성은 힙이`거의 완전한 이진 트리`라는 것 입니다. </br>
이는 마지막 레벨을 제외한 모든 레벨이 채워져 있어야 함을 의미합니다. </br>
이것은 마치 현재 레벨을 완료하지 않으면 다음 레벨로 넘어갈 수 없는 비디오 게임과 비슷한 원리입니다. </br>
</br>

## Heap application
> 힙 응용하기 ! ! </br>

* 컬렉션의 최소 또는 최대 요소 계산하기
* 힙 정렬 (heapsort)
* 우선순위 큐 구성하기
* 우선순위 큐를 사용하여 Prim 알고리즘 또는 Dijkstra 알고리즘과 같은 그래프 알고리즘 구성하기 

</br>
</br>

## Common heap operations
> 흔히 사용되는 힙 연산들 ! </br>

```swift
struct Heap<Element: Equatable> {
    
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool
    
    init(sort: @escaping (Element, Element) -> Bool) {
        self.sort = sort
    }

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
}
```
</br>

이 타입은 힙 내의 요소를 저장하기 위한 배열과 힙이 어떻게 정렬되어야 하는지를 정의하는 정렬 함수를 포함합니다. </br>
또한 초기화 과정에서 적절한 함수를 전달함으로써 최소 힙과 최대 힙을 모두 생성할 수 있습니다. </br>

## How do you represent a heap? 
> 힙을 어떻게 표현할까요 ? 
</br>

트리는 자식을 가리키는 노드를 저장합니다. 이진 트리의 경우, 이는 왼쪽과 오른쪽 자식을 가리키는 참조입니다. 힙은 사실상 **이진 트리**입니다. 하지만 간단한 **배열**로도 표현할 수 있습니다. 이 표현 방식은 트리를 구성하는 데에는 비정상적으로 보일 수 있습니다. 그러나 이 힙 구현의 장점 중 하나는 `시간 및 공간 복잡성`이 효율적이라는 점입니다. </br>
**힙의 요소들은 모두 메모리에 함께 저장**되기 때문입니다. 나중에 요소를 교환하는 것이 힙 연산에서 중요한 역할을 하는데, 배열을 사용하면 바이너리 트리 데이터 구조보다 조작이 더 쉽습니다.  </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/06bc5d43-96e6-4ae9-b3b5-df2bf9cb1ccc">
</br>

위의 힙을 배열로 표현하기 위해서는 왼쪽부터 오른쪽으로 각 요소를 레벨별로 순서대로 반복해야 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/42ae20a4-e6f6-415f-9562-53bf4b92375f"> </br>


한 레벨 올라갈 때마다 이전 레벨보다 두 배 많은 노드가 있습니다. </br>

이제 힙에서 어떤 노드든 쉽게 접근할 수 있습니다. 이를 배열에서 요소에 접근하는 방식과 비교할 수 있습니다. 왼쪽 또는 오른쪽 브랜치를 따라 탐색하는 대신, 간단한 공식을 사용하여 배열에서 노드에 접근할 수 있습니다. </br>

0을 기준으로 한 노드의 인덱스 i가 주어졌을 때: </br>

* 이 노드의 `왼쪽 자식 노드`는 인덱스 2i + 1에 있습니다.
* 이 노드의 `오른쪽 자식 노드`는 인덱스 2i + 2에 있습니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/765336da-0d93-4bb3-bb9c-e5ae5fd95136">
</br>

노드의 부모노드를 알고 싶을 경우 i값을 구할 수 있습니다. </br>
인덱스 i에 있는 자식 노드가 주어졌을 때, 이 자식의 부모 노드는 인덱스 `floor((i - 1) / 2)`에 위치합니다. </br>

> 참고 : 실제 이진 트리를 탐색하여 노드의 왼쪽과 오른쪽 자식을 얻는 것은 O(log n) 연산입니다. 그러나 배열과 같은 임의 접근 데이터 구조에서는 해당 연산이 단순한 O(1)입니다. </br>

</br>

## Removing from a heap

기본적인 삭제 연산은 힙에서 루트 노드를 제거하는 것 입니다. </br>
삭제 연산은 루트 노드에서 최대값을 제거합니다. </br>

<img width="60%" height="60%"  alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/44760d16-891a-4094-8efc-6dae8f2f5738">

</br>

먼저 루트 노드를 힙의 `마지막 요소`와 교환해야 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/1d34d5fc-2e7a-44f4-8b56-8c3c5c312cb3">
</br>

두 요소를 교환한 후, 마지막 요소를 제거하고 해당 값을 저장하여 나중에 반환할 수 있습니다. </br>

이제 최대 힙의 무결성을 확인해야 합니다. </br>

최대 힙의 규칙은 각 부모 노드의 값이 해당 자식 노드의 값보다 크거나 같아야 한다는 것입니다. 힙이 이 규칙을 더 이상 따르지 않으므로, **아래로 내려보내는 작업**을 수행해야 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/99b2415a-d003-4cde-9054-9a38e5ccc1f3"> </br>

아래로 내려보내는 작업을 수행하기 위해, 현재 값인 3부터 시작하여 왼쪽과 오른쪽 자식을 확인합니다. 자식 중 하나의 값이 현재 값보다 큰 경우, 그 자식과 부모를 교환합니다. 만약 양쪽 자식 모두 더 큰 값을 갖는다면, 부모와 더 큰 값을 갖는 자식을 교환합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/157ee9b5-6e50-4821-b759-4f7775db1f47"> </br>

이제 노드의 값이 자식들의 값보다 작아질 때까지 계속해서 아래로 내려가야 합니다. 

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/95b07a0e-f48f-450b-a1fa-4cd710c5c3ed">
</br>

끝까지 도달하면 작업이 완료되며, 최대 힙의 속성이 복원됩니다! </br>

</br>

### Implementation of remove

```swift
mutating func remove() -> Element? {
  
  // 1.
  // 힙이 비어 있는지 확인합니다. 비어 있다면 nil을 반환합니다.
  guard !isEmpty else { 
    return nil
  }

  // 2.
  //  루트와 힙의 마지막 요소를 교환합니다.
  elements.swapAt(0, count - 1) 

  // 4.
  // 힙이 더 이상 최대 힙 또는 최소 힙이 아닐 수 있으므로, 규칙을 따르도록 아래로 내려가는 작업을 수행해야 합니다.
  defer {
    siftDown(from: 0) // 4
  }

  // 3.
  // 마지막 요소(최대 또는 최소값)를 제거하고 반환합니다.
  return elements.removeLast() 
}
```
</br>

```swift
// siftDown(from:) 메서드는 임의의 인덱스를 받습니다. 이 인덱스에 있는 노드는 항상 부모 노드로 처리됩니다. 
mutating func siftDown(from index: Int) {

  var parent = index // 1. 부모 인덱스를 저장합니다.
  while true { // 2. 반환될 때까지 아래로 내려가는 작업을 계속합니다.

    // 3. 부모의 왼쪽과 오른쪽 자식 인덱스를 구합니다.
    let left = leftChildIndex(ofParentAt: parent) 
    let right = rightChildIndex(ofParentAt: parent)

    // 4. candidate 변수는 부모와 교환할 인덱스를 추적하는 데 사용됩니다.
    var candidate = parent 

    // 5. 왼쪽 자식이 있고 그 우선순위가 부모보다 높다면, candidate로 지정합니다.
    if left < count && sort(elements[left], elements[candidate]) {
      candidate = left 
    }

    // 6. 오른쪽 자식이 있고 그 우선순위가 더 높다면, 대신 candidate가 됩니다.
    if right < count && sort(elements[right], elements[candidate]) {
      candidate = right
    }

    // 7. candidate가 여전히 부모라면, 끝에 도달했으며 더 이상 아래로 내려갈 필요가 없습니다.
    if candidate == parent {
      return 
    }

    // 8. candidate와 부모를 교환하고 새로운 부모로 설정하여 계속해서 아래로 내려갑니다.
    elements.swapAt(parent, candidate) 
    parent = candidate
  }
}
```
</br>

> 복잡도 : remove()의 전체 복잡도는 `O(log n)`입니다. 배열에서 요소를 교환하는 데는 O(1)만큼의 시간이 소요되며, 힙에서 요소를 아래로 내려가는 데는 O(log n)의 시간이 소요됩니다. </br>

</br>

## Inserting into a heap

다음 힙에 7이라는 값을 삽입한다고 가정해 봅시다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/7f19b1d1-7665-4935-93cb-e331cd1c9500"> </br>

먼저 값 7을 힙의 끝에 추가합니다. </br>

<img width="60%" height="60%"  alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/aa332dbc-acc9-48a5-a234-dd6796a25ab8"> </br>


이제 최대 힙의 속성을 확인해야 합니다. 이제는 아래로 내려가는 대신, 방금 삽입한 노드가 부모보다 높은 우선순위를 가질 수 있으므로 **위로 올려야 합니다.** 이러한 위로 올리기 작업은 현재 노드와 그 부모를 비교하고 필요한 경우에 교환하는 방식으로 작동합니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/1664132f-31cc-4ead-b816-53efe8e9072e"> </br>

</br>

### Implementation of insert

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
</br>

보시다시피, 구현은 꽤 간단합니다 ! </br>

* insert는 요소를 배열에 추가한 다음 sift up을 수행합니다. 
* siftUp은 현재 노드가 부모보다 우선순위가 높을 때까지 현재 노드와 부모를 교환합니다.

> 복잡도: insert(_:)의 전체 복잡도는 `O(log n)입`니다. 배열에 요소를 추가하는 것은 O(1)만큼의 시간이 소요되며, 힙에서 요소를 위로 올리는 데는 O(log n)의 시간이 소요됩니다.
</br>

요소를 힙에 삽입하는 방법을 살펴보았습니다. 지금까지 힙에서 루트 요소를 제거하고 힙에 삽입하는 방법을 살펴보았습니다.
</br>

그러나 힙에서 **임의의 요소**를 제거하려면 어떻게 해야 할까요?
</br>
</br>

## Removing from an arbitrary index

```swift
// 힙에서 임의의 요소를 제거하려면 인덱스가 필요합니다.
mutating func remove(at index: Int) -> Element? {

  // 1. 배열의 범위 내에 인덱스가 있는지 확인합니다. 그렇지 않으면 nil을 반환합니다.
  guard index < elements.count else {
    return nil 
  }

  // 2. 힙에서 마지막 요소를 제거하는 경우 특별한 처리가 필요하지 않습니다. 단순히 마지막 요소를 제거하고 반환합니다.
  if index == elements.count - 1 {
    return elements.removeLast() 
  } else {
    elements.swapAt(index, elements.count - 1)
    // 3. 마지막 요소가 아닌 경우, 해당 요소를 마지막 요소와 교환합니다.
    defer {

      // 5. 마지막으로, 힙을 조정하기 위해 sift down과 sift up을 수행합니다.
      siftDown(from: index) 
      siftUp(from: index)
    }

    // 4. 그런 다음 마지막 요소를 반환하고 제거합니다.
    return elements.removeLast()
  }
}
```
</br>

* siftDown과 siftUp을 모두 수행해야 하는 이유는 ? 

5를 제거하려고 가정해 봅시다. 5를 마지막 요소인 8과 교환합니다. 이제 max 힙 속성을 만족시키기 위해 `sift up`을 수행해야 합니다. 

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/f05c4ed3-5cbe-4e40-90d2-75868d3494ed">
</br>


이제 7을 제거하려고 가정해 봅시다. 7을 마지막 요소인 1과 교환합니다. 이제 max 힙 속성을 만족시키기 위해 `sift down`을 수행해야 합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/40a7d867-df54-419f-b643-1258d270bc80">
</br>


임의의 요소를 힙에서 제거하는 것은 `O(log n)`의 작업입니다. 하지만 삭제하려는 요소의 인덱스를 어떻게 찾을까요? </br>

## Searching for an element in a heap

삭제하려는 요소의 인덱스를 찾기 위해 힙에서 **검색**을 수행해야 합니다. 하지만 힙은 빠른 검색을 위해 설계되지 않았습니다. 이진 탐색 트리를 사용하면 O(log n)의 시간에 검색을 수행할 수 있지만, 힙은 배열을 사용하여 구성되고 배열에서의 노드 순서가 다르기 때문에 `이진 탐색조차 수행할 수 없습니다.`

</br>

복잡도: 힙에서 요소를 검색하는 것은 최악의 경우 `O(n)`의 작업입니다. 배열의 모든 요소를 확인해야 할 수 있기 때문입니다.
</br>

```swift
func index(of element: Element, startingAt i: Int) -> Int? {

  // 1. 
  // 인덱스가 배열의 요소 수보다 크거나 같으면 검색 실패로 간주하고 nil을 반환합니다.
  if i >= count {
    return nil 
  }

  // 2. 
  // 찾고자 하는 요소가 현재 인덱스 i의 요소보다 우선순위가 높다면, 찾고자 하는 요소는 힙에서 더 낮은 위치에 있을 수 없습니다. 따라서 nil을 반환합니다.
  if sort(element, elements[i]) {
    return nil 
  }

  // 3.
  // 요소가 인덱스 i의 요소와 동일하다면, i를 반환합니다.
  if element == elements[i] {
    return i 
  }

  // 4.
  // 왼쪽 자식 인덱스에서 시작하여 요소를 재귀적으로 검색합니다.
  if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
    return j 
  }

  // 5. 
  // 오른쪽 자식 인덱스에서 시작하여 요소를 재귀적으로 검색합니다.
  if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
    return j 
  }

  // 6.
  // 위의 두 검색이 모두 실패한 경우, 검색 실패로 간주하고 nil을 반환합니다.
  return nil
}
```
</br>
</br>

## Building a heap

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
</br>

이 이니셜라이저는 추가 매개변수를 사용합니다. 비어있지 않은 배열이 제공되면, 이를 힙의 요소로 사용합니다. 힙의 속성을 만족시키기 위해 배열을 거꾸로 반복하면서 첫 번째 비단말 노드부터 모든 부모 노드를 sift down합니다. 반복은 요소의 절반만큼만 수행합니다. 왜냐하면 리프 노드는 sift down할 필요가 없기 때문입니다. 부모 노드만 sift down하면 됩니다.
</br>
</br>

## Key Points 
> 중요 중요 중요 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/d337e6d9-b581-4dcc-9539-69774aa081d0">

</br>

* 힙 데이터 구조는 가장 높은 또는 가장 낮은 우선순위 요소를 유지하는 데 좋습니다.
* 힙의 요소는 요소 조회를 위한 간단한 공식을 사용하여 연속적인 메모리에 패킹됩니다.
* 요소를 삽입하거나 제거할 때마다 힙의 힙 속성을 유지하기 위해 주의해야 합니다.