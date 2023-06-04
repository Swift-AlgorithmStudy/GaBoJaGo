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

