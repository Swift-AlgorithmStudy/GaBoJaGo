# Chapter 22: Heaps

힙은 완전 이진 트리 형태로 일반적으로 배열로 구현되며 max값 또는 min값을 빠르게 가져오기에 효율적인 특징을 가지고 있습니다.

## 힙이란?

힙은 배열을 사용하여 구성할 수 있는 완전 이진 트리로, 이진 힙이라고도 불립니다.

> 💡 이 힙을 메모리 힙과 혼동하지 마세요.
> 힙이라는 용어는 때때로 컴퓨터 과학에서 메모리 풀을 가리키는 혼란스러운 용도로 사용됩니다.
> 메모리 힙은 다른 개념이며 여기에서 공부하는 내용과는 관련이 없습니다.

힙은 두 가지 종류로 나뉩니다:

1. 최대 힙(Max Heap): 값이 더 큰 요소일수록 우선 순위가 높은 힙입니다.
2. 최소 힙(Min Heap): 값이 더 작은 요소일수록 우선 순위가 높은 힙입니다.

## 힙의 속성

힙은 항상 만족되어야 하는 중요한 특성을 가지고 있습니다. 이 특성은 힙 불변식(heap invariant) 또는 힙 속성(heap property)이라고 알려져 있습니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 13 18" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/3bb81ce3-8b8f-4147-bd5a-ada6582eeeef">

최대 힙에서는 부모 노드는 항상 자식 노드보다 크거나 같은 값을 가지고 있어야 합니다. 루트 노드는 항상 가장 큰 값을 가지게 됩니다.

최소 힙에서는 부모 노드는 항상 자식 노드보다 작거나 같은 값을 가지고 있어야 합니다. 루트 노드는 항상 가장 작은 값을 가지게 됩니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 13 58" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/f51b8c13-b872-4621-ad59-88daa8733d8d">

힙의 또 다른 중요한 특성은 거의 완전한(nearly complete) 이진 트리라는 점입니다. 이는 마지막 레벨을 제외한 모든 레벨이 가득 차 있어야 한다는 의미입니다.

## 힙의 적용사례

- 컬렉션의 최솟값 또는 최댓값 계산
- 힙 정렬(Heapsort)
- 우선순위 큐
- 우선순위 큐를 이용한 Prim이나 Dijkstra와 같은 그래프 알고리즘 구현

## 힙의 일반적인 동작

```swift
struct Heap<Element: Equatable> {
	var elements: [Element] = []
	let sort: (Element, Element) -> Bool, Element) -> Bool) {
		self.sort = sort
	}
}
```

이 타입은 힙 내의 요소를 저장하기 위한 배열과 힙이 어떻게 정렬되어야 하는지를 정의하는 정렬 함수를 포함하고 있습니다. 초기화 시에 적절한 함수를 전달함으로써, 이 타입은 최소 힙과 최대 힙을 모두 생성할 수 있습니다.

## 힙은 어떻게 표현하나요?

트리는 자식 노드를 참조하는 노드를 가지고 있습니다. 이진 트리의 경우, 이는 왼쪽 자식과 오른쪽 자식을 참조합니다. 힙은 사실상 이진 트리입니다만, 간단한 배열로 표현할 수 있습니다. 이 힙 구현의 장점 중 하나는 효율적인 시간 및 공간 복잡도입니다. 힙의 요소들은 모두 메모리에 함께 저장되기 때문입니다. 나중에 보게 될 것처럼, 요소들을 교환하는 것은 힙 연산에서 중요한 역할을 합니다. 이러한 조작은 이진 트리 자료 구조보다 배열로 더 쉽게 수행할 수 있습니다. 배열을 사용하여 힙을 표현하는 방법을 살펴보겠습니다. 다음과 같은 이진 힙을 살펴봅시다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 24 58" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/1b21e187-6771-4ffc-8515-6ea710fb58b2">

위의 힙을 배열로 표현하기 위해 왼쪽에서 오른쪽으로 각 요소를 레벨별로 순회합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 25 39" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/bf5a4f2e-0bea-4898-a625-4ea78fbc45be">

레벨이 올라갈수록 이전 레벨보다 두 배 많은 노드가 있습니다.
이제 힙(heap)에서 어떤 노드든 쉽게 접근할 수 있습니다. 이는 배열에서 요소에 접근하는 방법과 비교할 수 있습니다: 왼쪽이나 오른쪽 브랜치를 따라 내려가는 대신, 간단한 공식을 사용하여 배열에서 해당 노드에 접근할 수 있습니다.
0부터 시작하는 인덱스 i가 주어진 노드인 경우:
• 이 노드의 왼쪽 자식은 인덱스 2i + 1에 있습니다.
• 이 노드의 오른쪽 자식은 인덱스 2i + 2에 있습니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 48 45" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/12441ae2-0bb1-470d-a21a-a901980514b9">

노드의 부모를 얻고 싶을 수도 있습니다. 이 경우 i를 구할 수 있습니다. 주어진 인덱스 i에 있는 자식 노드의 경우, 이 자식의 부모 노드는 인덱스 floor((i - 1) / 2)에서 찾을 수 있습니다.

> 💡 실제 이진 트리에서 노드의 왼쪽과 오른쪽 자식을 얻기 위해 내려가는 작업은 O(log n) 연산입니다.
> 그러나 배열과 같은 랜덤 액세스 데이터 구조에서는 해당 작업이 단지 O(1)입니다.

다음으로, 힙(Heap)에 몇 가지 속성과 편의 메서드를 추가하기 위해 새로운 지식을 활용해보겠습니다:

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

힙(heap)을 배열을 사용하여 표현하는 방법에 대해 잘 이해하셨으므로, 이제 힙의 중요한 연산 몇 가지를 살펴보겠습니다. 힙에서 일반적으로 수행하는 주요 연산은 다음과 같습니다:

## 힙에서 삭제하기

기본적인 삭제 연산은 힙에서 루트 노드를 제거하는 것입니다. 다음과 같은 최대 힙을 살펴보겠습니다:

<img width="700" alt="스크린샷 2023-06-02 오후 2 51 41" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/4c570984-fa38-4ae5-a062-25076eff9b80">

삭제 연산은 루트 노드의 최대 값을 제거합니다. 이를 위해 우선 루트 노드를 힙의 마지막 요소와 교환해야 합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 52 08" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/61921b84-2bd6-4325-a370-78207e272325">

두 요소를 교환한 후, 마지막 요소를 제거하고 해당 값을 저장하여 나중에 반환할 수 있습니다.
이제 최대 힙의 무결성을 확인해야 합니다. 그러기 전에 스스로에게 질문을 하세요. "여전히 최대 힙인가요?"
기억하세요: 최대 힙의 규칙은 모든 부모 노드의 값이 자식들의 값보다 크거나 같아야 합니다. 힙이 이 규칙을 더 이상 따르지 않는다면, 아래로 내려가는(sift down) 작업을 수행해야 합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 53 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/d06134b6-567c-4c9b-97b5-d90157ee5fad">

아래로 내려가는(sift down) 작업을 수행하려면, 현재 값인 3에서 시작하여 왼쪽 자식과 오른쪽 자식을 확인합니다. 만약 자식 중 하나의 값이 현재 값보다 크다면, 그 자식과 부모를 교환합니다. 만약 양쪽 자식 모두 값이 더 크다면, 큰 값을 가진 자식과 부모를 교환합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 53 33" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/1dae8a04-989a-479f-bcb0-8f862d82d73c">

이제 노드의 값이 자식들의 값보다 작지 않을 때까지 계속해서 아래로 내려가야 합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 2 54 07" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/d71272b0-10c7-4dd6-a2f1-89ad3666d46d">

마지막 단계에 도달하면 작업이 완료되고 최대 힙의 속성이 복원됩니다!

## 삭제 구현

```swift
mutating func remove() -> Element? {
	// 힙이 비어 있는지 확인합니다.
	// 비어 있다면 nil을 반환합니다.
	guard !isEmpty else {
		return nil
	}
	// 루트와 힙의 마지막 요소를 교환합니다.
	elements.swapAt(0, count - 1)
	// 힙은 이제 더 이상 최대 힙 또는 최소 힙일 수 없으므로,
	// 규칙에 맞게 하기 위해 아래로 내려가는 작업을 수행해야 합니다.
	defer {
		siftDown(from: 0)
	}
	// 마지막 요소(최댓값 또는 최솟값)를 제거하고 반환합니다.
	return elements.removeLast()
}
```

이제 노드를 아래로 내려가는 방법을 확인해보기 위해 `remove()` 메서드 다음에 다음과 같은 메서드를 추가해보세요:

```swift
mutating func siftDown(from index: Int) {
	// 부모 인덱스를 저장합니다.
	var parent = index
	// 반환할 때까지 계속해서 내려갑니다.
	while true {
		// 부모의 왼쪽과 오른쪽 자식 인덱스를 얻습니다.
		let left = leftChildIndex(ofParentAt: parent)
		let right = rightChildIndex(ofParentAt: parent)
		// candidate 변수는 어떤 인덱스를 부모와 교환할지 추적하는 데 사용됩니다.
		var candidate = parent
		// 왼쪽 자식이 있고, 부모보다 우선 순위가 높다면, candidate로 설정합니다.
		if left < count && sort(elements[left], elements[candidate]) {
			candidate = left
		}
		// 오른쪽 자식이 있고, 그 우선 순위가 더 높다면, 대신 candidate로 설정됩니다.
		if right < count && sort(elements[right], elements[candidate]) {
			candidate = right
		}
		// candidate가 여전히 부모와 같다면,
		// 마지막에 도달한 것이므로 더 이상 내려가는 작업이 필요하지 않습니다.
		if candidate == parent {
			return
		}
		// candidate를 부모와 교환하고,
		// 이를 새로운 부모로 설정하여 계속해서 내려갑니다.
		elements.swapAt(parent, candidate)
		parent = candidate
	}
}
```

`siftDown(from:)` 메서드는 임의의 인덱스를 받아들입니다. 이 인덱스의 노드는 항상 부모 노드로 취급됩니다. 이 메서드는 다음과 같은 방식으로 작동합니다:

> 💡 복잡도: `remove()` 메서드의 전체 복잡도는 O(log n)입니다.
> 배열에서 요소를 교환하는 것은 O(1)에 수행되지만, 힙에서 요소를 아래로 내려가는 작업은 O(log n) 시간이 소요됩니다.

## 힙에 추가하기

아래의 힙에 값 7을 삽입한다고 가정해봅시다:

<img width="700" alt="스크린샷 2023-06-02 오후 3 02 04" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/8f1e6a92-fc32-4286-91e0-a546c0480b3f">

먼저, 값을 힙의 끝에 추가합니다:

<img width="700" alt="스크린샷 2023-06-02 오후 3 02 53" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/2f192f65-ab3b-4a7d-94fe-123656451a58">

이제 최대 힙의 속성을 확인해야 합니다. 이제 노드를 아래로 내려가는 대신, 방금 삽입한 노드가 부모보다 더 높은 우선순위를 가질 수 있으므로, 위로 올리는 작업을 수행해야 합니다. 이러한 위로 올리는 작업은 현재 노드를 부모와 비교하고 필요한 경우 교환하는 것과 같은 방식으로 작동합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 3 05 08" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/52ddc06c-39e0-4ea2-a72a-212f0246dbff">

이제 힙은 최대 힙 속성을 만족합니다!

## 삽입 구현

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

보시다시피, 구현은 매우 간단합니다:

- insert는 요소를 배열에 추가한 다음 sift up을 수행합니다.
- siftUp은 현재 노드가 부모보다 높은 우선순위를 가지는 한, 현재 노드와 부모를 교환합니다.

> 💡 시간 복잡도: `insert(_:)` 메서드의 전체 시간복잡도는 O(log n)입니다.
> 배열에 요소를 추가하는 것은 O(1)에 수행되지만, 힙에서 요소를 위로 올리는 작업은 O(log n) 시간이 소요됩니다.

힙에 요소를 삽입하는 것에 대해서는 이것으로 끝이에요.

지금까지 힙에서 루트 요소를 제거하고 힙에 삽입하는 방법을 살펴봤습니다.

그러나 힙에서 임의의 요소를 제거하려면 어떻게 해야 할까요?

## 임의의 인덱스에서 요소를 제거하는 방법

```swift
mutating func remove(at index: Int) -> Element? {
	// 인덱스가 배열의 범위 내에 있는지 확인합니다.
	// 그렇지 않으면 nil을 반환합니다.
	guard index < elements.count else {
		return nil
	}
	// 힙에서 마지막 요소를 제거하는 경우 특별한 작업이 필요하지 않습니다.
	// 단순히 요소를 제거하고 반환합니다.
	if index == elements.count - 1 {
		return elements.removeLast()
	} else {
		// 마지막 요소가 아닌 경우, 먼저 해당 요소를 마지막 요소와 교환합니다.
		elements.swapAt(index, elements.count - 1)
		// 마지막으로, 힙을 조정하기 위해 아래로 향하는 조정(sift down)과
		// 위로 향하는 조정(sift up)을 수행합니다.
		defer {
			siftDown(from: index)
			siftUp(from: index)
		}
		// 그런 다음 마지막 요소를 반환하고 제거합니다.
		return elements.removeLast()
	}
}
```

하지만 왜 sift down과 sift up을 모두 수행해야 하는지입니다.

5를 제거하려고 한다고 가정해 봅시다.

5를 마지막 요소인 8과 교환합니다.

이제 최대 힙 속성을 만족하기 위해 sift up을 수행해야 합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 3 14 10" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/126df288-ade2-43b8-94da-62383287c15e">

이제 7을 제거하려고 한다고 가정해 봅시다. 7을 마지막 요소인 1과 교환합니다. 이제 최대 힙 속성을 만족하기 위해 sift down을 수행해야 합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 3 14 43" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/541ce84d-c240-41c5-bbed-93e6597d2fa5">

힙에서 임의의 요소를 제거하는 것은 O(log n)의 시간 복잡도를 가진 작업입니다. 그러나 삭제하려는 요소의 인덱스를 어떻게 찾을 수 있는지요?

## 힙에서 요소 검색하기

삭제하려는 요소의 인덱스를 찾으려면 힙에서 검색 작업을 수행해야 합니다. 그러나 힙은 빠른 검색을 위해 설계되지 않았습니다. 이진 검색 트리를 사용하면 O(log n)의 시간 안에 검색을 수행할 수 있지만, 힙은 배열을 사용하여 구성되며 배열에서의 노드 순서가 다르기 때문에 이진 검색조차 수행할 수 없습니다.

> 💡 힙에서 요소를 검색하는 것은 최악의 경우 O(n)의 작업입니다.
> 왜냐하면 배열의 모든 요소를 확인해야 할 수 있기 때문입니다.

```swift
func index(of element: Element, startingAt i: Int) -> Int? {
	// 인덱스가 배열의 요소 수보다 크거나 같으면 검색 실패입니다. nil을 반환합니다.
	if i >= count {
		return nil
	}
	// 찾고자 하는 요소가 현재 인덱스 i의 요소보다 우선 순위가 높은지 확인합니다.
	// 그렇다면 찾고자 하는 요소는 힙에서 더 낮을 수 없습니다.
	if sort(element, elements[i]) {
		return nil
	}
	// 요소가 인덱스 i의 요소와 동일한 경우 i를 반환합니다.
	if element == elements[i] {
		return i
	}
	// i의 왼쪽 자식부터 재귀적으로 요소를 검색합니다.
	if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
		return j
	}
	// i의 오른쪽 자식부터 재귀적으로 요소를 검색합니다.
	if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
		return j
	}
	// 두 개의 검색이 모두 실패한 경우 검색 실패입니다. nil을 반환합니다.
	return nil
}
```

## 힙 구축하기

이제 힙(heap)을 표현하는 데 필요한 모든 도구를 갖추었습니다. 이 장을 마무리하기 위해 기존 요소 배열에서 힙을 구축하고 테스트해보겠습니다. Heap의 초기화자(initializer)를 다음과 같이 업데이트하세요.

```swift
init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) {
	self.sort = sort
	self.elements = elements
	if !elements.isEmpty {
		for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
			siftDown(from: i)
		}
	}
}
```

이제 초기화자(initializer)는 추가 매개변수를 받습니다. 비어 있지 않은 배열이 제공되면 이를 힙의 요소로 사용합니다. 힙의 속성을 만족하기 위해 배열을 뒤에서부터 반복하여 첫 번째 비단말 노드부터 모든 부모 노드를 아래로 내려갑니다. 잎 노드를 아래로 내리는 것은 의미가 없으므로 반복은 요소의 절반만큼만 수행합니다.

<img width="700" alt="스크린샷 2023-06-02 오후 3 45 48" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/19f287d7-1248-4d69-83ea-bbffd253021a">

## 테스트

```swift
var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])
while !heap.isEmpty {
	print(heap.remove()!)
}
```

이 반복문은 >를 정렬 조건으로 사용하여 최대 힙(max heap)을 생성하며, 요소를 하나씩 제거하여 비워집니다. 주목할 점은 요소가 가장 큰 값부터 작은 값으로 제거되며, 다음 숫자들이 콘솔에 출력됩니다.

```swift
12
8
7
6
4
3
1
1
```

## **Key points**

- 이번 장에서 구현한 힙 연산의 알고리즘 복잡도 요약입니다:

<img width="700" alt="스크린샷 2023-06-02 오후 3 48 08" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/22979718/d90aac62-70aa-4b6e-94b3-0d832de08a0d">

- 힙(heap) 자료 구조는 가장 높은 우선순위 또는 가장 낮은 우선순위 요소를 유지하는 데에 적합합니다.
- 힙의 요소들은 연속적인 메모리에 담기며, 간단한 공식을 사용하여 요소를 찾을 수 있습니다.
- 요소를 삽입하거나 제거할 때마다 힙의 속성을 유지하는 것에 주의해야 합니다.