# Priority Queues

**큐**는 먼저 들어온 요소가 먼저 나가는(FIFO) 순서를 유지하는 리스트 입니다. </br>
**우선순위 큐**는 FIFO 순서가 아닌 우선순위 요소가 디큐되는 큐의 다른 버전입니다. </br>
예를 들어, 우선순위 큐는 다음 중 하나일 수 있습니다 </br>

* 최대 우선순위 큐(Max-priority queue) : 맨 앞의 요소가 항상 가장 큰 값
* 최소 우선순위 큐(Min-priority queue) : 맨 앞의 요소가 항상 가장 작은 값

</br>

우선순위 큐는 특히 요소 목록에서 `최대값 또는 최소값을 식별`하는 데 유용합니다. </br>

</br>

## Applications
> 우선순위 큐의 실제 응용 사례들을 알아보자 ! </br>

* **Dijkstra 알고리즘** : 최소 비용을 계산하기 위해 우선순위 큐 사용
* **A* 경로 탐색 알고리즘** : 최단 길이의 경로를 생성하는 미탐색 경로를 추적하기 위해 우선순위 큐 사용
* **힙 정렬** : 우선순위 큐를 사용해 구현 가능
* **Huffman 코딩** : 압축 트리를 구축하는데 사용됩니다. 최소 빈도를 가진 두 노드를 반복적으로 찾아 부모 노드가 없는 노드로 만듦

</br>
</br>

## Common operations
> 큐와 동일한 작업 ! </br>

```swift
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
```
</br>

위 코드는 Queue 프로토콜을 정의한 것으로, 우선순위 큐도 일반적인 큐와 동일한 작업을 수행합니다. 다만 구현 방식이 다를 뿐입니다. </br>

우선 순위 큐는 Queue 프로토콜을 채택하고 다음과 같은 공통 작업을 구현합니다. </br>

* **enqueue** : 요소를 큐에 삽입, 성공하면 true 반환
* **dequeue** : 가장 높은 우선순위를 가진 요소를 제거하고 반환, 큐가 비어있을 경우 nil을 반환
* **isEmpty** : 큐가 비어있는지 확인
* **peek** : 가장 높은 우선순위를 가진 요소를 제거하지 않고 반환, 큐가 비어있을 경우 nil을 반환

</br></br>

## Implementation


### 우선순위 큐로 구현할 수 있는 것

1. **정렬된 배열** 
이 방법은 요소의 **최대 또는 최소 값**을 `O(1)` 시간에 얻을 수 있어 유용합니다. </br>
그러나 **삽입 작업**은 느리며 정렬된 순서로 삽입해야 하므로 `O(n)`의 시간 복잡도를 가집니다. </br>

2. **균형 이진 탐색 트리**
이 방법은 **양쪽 끝에 있는 최소 및 최대 값**을 모두 `O(log n)` 시간에 얻을 수 있는 이준 우선순위 큐를 생성하는 데 유용합니다. </br>
삽입 작업은 정렬된 배열보다 좋으며 O(log n)시간이 걸립니다. </br>

3. **힙**
힙은 **부분적으로만 정렬**되어 있으면 되기 때문에 정렬된 배열보다 효율적입니다. </br>
힙의 모든 작업은 `O(log n)`시간이 소요됩니다. </br>
최소 우선순위 힙에서 최소 값을 추출하는 것은 빠른 `O(1)` 작업이고, 최대 우선순위 힙에서 최대 값을 추출하는 것 또한 `O(1)`의 시간이 걸립니다. </br>

### 힙을 사용해 우선순위 큐 구현

```swift
/* 
PriorityQueue는 Queue 프로토콜을 준수합니다. 
Element라는 제네릭 매개변수는 Equatable 프로토콜을 준수해야 하며, 요소들을 비교할 수 있어야 합니다.
*/
struct PriorityQueue<Element: Equatable>: Queue {

    // 우선순위 큐를 구현하는 데 사용될 힙
    private var heap: Heap<Element> 
    
    // 초기화 매서드를 통해 알맞은 함수를 전달함으로써 최소 우선순위 큐와 최대 우선순위 큐를 모두 생성할 수 있습니다.
    init(sort: @escaping (Element, Element) -> Bool, elements: [Element] = []) { 
        heap = Heap(sort: sort, elements: elements)
    }

    var isEmpty: Bool {
        heap.isEmpty
    }

    var peek: Element? {
        heap.peek()
    }

    // 1
    mutating func enqueue(_ element: Element) -> Bool { 
        heap.insert(element)
        return true
    }

    // 2
    mutating func dequeue() -> Element? {
        heap.remove()
    }
}
```
</br>

힙은 우선순위 큐에 적합한 자료구조입니다. </br>

1. 
enqueue(:)를 호출하면 힙에 삽입하고, 힙은 자체적으로 올바른 상태를 유지하기 위해 `sift up`을 수행합니다. </br>
enqueue(:)의 전체 시간 복잡도는 `O(log n)`입니다. </br>

2. 
dequeue()를 호출하면 힙에서 루트 요소를 제거하고, 마지막 요소로 대체한 후 `sift down`을 수행하여 힙의 유효성을 검사합니다. </br>
dequeue()의 전체 시간 복잡도는 `O(log n)`입니다. </br>

</br>

## Key Points
> 중요 중요 중요 !  </br>

* 우선순위 큐는 종종 우선순위 순서로 요소를 찾기 위해 사용됩니다. 
* 우선순위 큐는 큐의 핵심동작에 집중하고 힙 데이터 구조가 제공하는 추가기능을 배제하여 추상화 계층을 생성합니다.
* 이를 통해 우선순위 큐의 의도가 명확하고 간결해집니다. 그 역할은 요소를 enqueue하고 dequeue하는 것뿐입니다 ! 
* 조합 (composition) 승리 ?