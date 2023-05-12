# Chapter 8: Queues

우리는 모두 줄을 서기에 익숙합니다.

가장 좋아하는 영화 티켓을 사기 위해 줄을 서거나 파일을 출력하기 위해 기다리는 경우 등, 이러한 실제 시나리오들은 큐 데이터 구조와 유사합니다.

큐는 FIFO(First In First Out, 선입선출) 순서를 사용합니다.

즉, 추가된 첫 번째 요소는 항상 먼저 제거됩니다. 큐는 나중에 처리할 요소의 순서를 유지해야 할 때 유용합니다.

# **공통 구현 내용**

큐에 대한 프로토콜을 만들어 보겠습니다:

```swift
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
```

프로토콜은 큐의 핵심 작업을 설명합니다:

- enqueue: 큐의 뒤쪽에 요소를 삽입합니다. 작업이 성공하면 true를 반환합니다.
- dequeue: 큐의 맨 앞의 요소를 제거하고 반환합니다.
- isEmpty: 큐가 비어 있는지 확인합니다.
- peek: 큐의 맨 앞의 요소를 제거하지 않고 반환합니다.

큐는 맨 앞에서 제거하고 맨 뒤에 삽입하는 것만 신경 쓰므로, 중간에 내용이 무엇인지 알 필요가 없습니다. 만약 알아야 한다면, 아마 배열을 사용할 것입니다.

# **큐 예시**

큐가 작동하는 방식을 이해하는 가장 쉬운 방법은 동작하는 예시를 보는 것입니다. 영화 티켓을 사기 위해 줄을 서 있는 사람들의 그룹을 상상해보세요.

<img width="249" alt="스크린샷 2023-05-08 오후 9 39 58" src="https://github.com/zhunhe/zhunhe/assets/22979718/77b6bf46-c441-432a-9b07-4f24d0a87fe4">

큐에는 현재 Ray, Brian, Sam 및 Mic이 있습니다. Ray가 티켓을 받으면 줄에서 나오게 됩니다. dequeue()를 호출하여 Ray가 큐의 맨 앞에서 제거됩니다.

peek를 호출하면 이제 Brian이 맨 앞에 있으므로 반환됩니다. 이제 티켓을 구매하기 위해 줄에 합류한 Vicki가 있습니다. enqueue("Vicki")를 호출하여 Vicki가 큐의 뒤쪽에 추가됩니다.

다음 섹션에서는 다음 네 가지 방법으로 큐를 만드는 방법을 배우게 됩니다:

- 배열을 사용한 구현
- 이중 연결 리스트를 사용한 구현
- 링 버퍼를 사용한 구현
- 더블 스택을 사용한 구현

# 배열

## 구현 내용

```swift
public struct QueueArray<T>: Queue {
  private var array: [T] = []

  public init() {}

  public var isEmpty: Bool {
    array.isEmpty
  }

  public var peek: T? {
    array.first
  }

  public mutating func enqueue(_ element: T) -> Bool {
    array.append(element)
    return true
  }

  public mutating func dequeue() -> T? {
    isEmpty ? nil : array.removeFirst()
  }
}
```

## **시간복잡도**

<img width="294" alt="스크린샷 2023-05-12 오후 1 17 22" src="https://github.com/zhunhe/zhunhe/assets/22979718/cffd393a-62e3-4786-9396-ec9ad338fa36">

# **이중 연결 리스트**

## 구현 내용

```swift
public class QueueLinkedList<T>: Queue {
  private var list = DoublyLinkedList<T>()
  public init() {}

  public func enqueue(_ element: T) -> Bool {
    list.append(element)
    return true
  }

  public func dequeue() -> T? {
    guard !list.isEmpty, let element = list.first else {
      return nil
    }
    return list.remove(element)
  }

  public var peek: T? {
    list.first?.value
  }

  public var isEmpty: Bool {
    list.isEmpty
  }
}
```

## **시간복잡도**

<img width="308" alt="스크린샷 2023-05-12 오후 1 19 47" src="https://github.com/zhunhe/zhunhe/assets/22979718/44e44bfe-f640-4ef8-af8e-299f60b95f36">

# **링 버퍼**

## 구현 내용

```swift
public struct QueueRingBuffer<T>: Queue {
  private var ringBuffer: RingBuffer<T>

  public init(count: Int) {
    ringBuffer = RingBuffer<T>(count: count)
  }

  public var isEmpty: Bool {
    ringBuffer.isEmpty
  }

  public var peek: T? {
    ringBuffer.first
  }

  public mutating func enqueue(_ element: T) -> Bool {
    ringBuffer.write(element)
  }

  public mutating func dequeue() -> T? {
    ringBuffer.read()
  }
}
```

## **시간복잡도**

<img width="285" alt="스크린샷 2023-05-12 오후 1 20 01" src="https://github.com/zhunhe/zhunhe/assets/22979718/b73ae92e-dfdb-4faf-b4a2-ca6fce73bf47">

# **더블 스택**

## 구현 내용

```swift
public struct QueueStack<T> : Queue {
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  public init() {}

  public var isEmpty: Bool {
    leftStack.isEmpty && rightStack.isEmpty
  }

  public var peek: T? {
    !leftStack.isEmpty ? leftStack.last : rightStack.first
  }

  public mutating func enqueue(_ element: T) -> Bool {
    rightStack.append(element)
    return true
  }

  public mutating func dequeue() -> T? {
    if leftStack.isEmpty {
      leftStack = rightStack.reversed()
      rightStack.removeAll()
    }
    return leftStack.popLast()
  }
}
```

## **시간복잡도**

<img width="314" alt="스크린샷 2023-05-12 오후 1 22 12" src="https://github.com/zhunhe/zhunhe/assets/22979718/caf0c745-e4aa-4f10-a61b-cc2fd2d64e61">

# **Key points**

- 큐는 FIFO 전략을 사용합니다. 즉, 먼저 추가된 요소는 먼저 제거되어야 합니다.
- Enqueue는 요소를 큐의 뒤쪽에 삽입합니다.
- Dequeue는 큐의 맨 앞의 요소를 제거합니다.
- 배열의 요소는 연속적인 메모리 블록에 놓이고, 연결 리스트의 요소는 캐시 미스 가능성이 높은 더 분산된 위치에 놓입니다.
- 링 버퍼 큐 기반의 구현은 크기가 고정된 큐에 적합합니다.
- 다른 데이터 구조와 비교하여, 두 개의 스택을 활용하면 dequeue(_:)의 시간 복잡도를 평균 O(1) 작업으로 개선할 수 있습니다.
- 두 개의 스택을 활용한 구현은 저장소 지역성 측면에서 이중 연결 리스트를 능가합니다.
