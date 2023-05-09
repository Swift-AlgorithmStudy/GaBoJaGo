# Queue

큐 스택이란 영화 티켓을 구매하거나, 프린트 등을 하기 위해 줄을 서는 것과 매우 비슷한 자료 구조입니다.

큐는 ‘**FIFO’** 데이터 ****구조를 사용하여, 처음으로 추가된 요소가 가장 처음으로 제거되는 형식입니다.

## Commom operations

```swift
public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue()-> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}
```

- enqueue: queue의 가장 뒷 부분에 요소를 추가해주고, 만약 연산을 성공했으면 true를 반환해줍니다.
- dequeue: 큐의 가장 앞 부분의 요소를 제거해준 뒤, 큐를 반환해줍니다.
- isEmpty : 큐가 비어있는 지 확인합니다.
- peek : 큐에서 가장 앞에 있는 요소를 반환합니다.

큐는 맨 앞과 맨 뒤의 요소의 추가 및 제거만 신경쓰기 때문에, 그 사이에 어떤 내용이 있는 지는 알 필요가 없습니다. 
만약 알고 싶다면, 그냥 배열을 사용하면 될 것 입니다.

## Example of a queue

영화관에서 표를 사기 위해 줄을 서고 있는 사람들을 생각하면 될 것입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a527919e-3420-4bb9-b219-4eb8b29ab3a7/Untitled.png)

Ray가 티켓을 사면 줄을 나가는 방식이 dequeue()를 한 것입니다.

이제 줄의 맨 앞줄은 Brian이기 때문에, peek를 호출하면 Brian이 반환됩니다.

Vicki가 줄을 서기 위해 들어온 방식은 enqueue()를 한 것입니다.

뒤에서 큐를 만드는 4가지 방법에 대해서 다룰 예정입니다.

- 배열(array) 사용
- 링크드 리스트(doubly linked list) 사용
- 링 버퍼(ring buffer) 사용
- 스택 2개(2 stacks) 사용

## Array-based implementation

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/08cb56b0-d5f2-4042-aba0-69df12cb94e0/Untitled.png)

배열을 통해서 큐를 생성할 수 있습니다.

```swift
public struct QueueArray<T>: Queue {
    private var array: [T] = []
    public init() {}
}
```

제네릭타입으로 QueueArray정의하고 Queue 프로토콜을 적용하였습니다. 

```swift
public var isEmpty: Bool {
  array.isEmpty // 1
}

public var peek: T? {
  array.first // 2
}
```

1. 큐가 비어있는지 확인합니다.
2. 큐의 앞부분의 요소를 반환합니다.

이 연산은 O(1)입니다.

### Enqueue

큐에 요소를 추가하는 방법은 간단합니다. 그저 배열에 append를 해주면됩니다.

```swift
public mutating func enqueue(_ element: T) -> Bool {
  array.append(element)
  return true
}
```

 배열의 뒤에 빈 공간이 있기 때문에 이 연산은 O(1)입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/040f49d9-b6ac-43f8-9860-3e51fd15ee24/Untitled.png)

하지만 결국 배열이 가득 차게 될 것이고, 만약 공간을 더 할당하고 싶으면, 추가적인 공간을 위해 배열을 resize해줘야합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c4fb4a3a-7d4b-4d0e-bbbb-65f9b32296b7/Untitled.png)

여기서 놀라운 점은 배열의 크기를 변경(Sizing)하는 것은 O(n)연산인데, enqueue는 O(1)이라는 점입니다. 

배열의 크기를 변경하기 위해서는 새로운 메모리를 할당하고, 모든 기존 데이터를 새로운 배열로 복사해야하기 때문에 O(n)입니다. 

하지만 배열의 크기를 변경하는 연산이 발생하는 빈도는 매우 적습니다.

배열이 꽉 찰 때마다 배열의 크기는 2배로 증가하기 때문에, 평균 비용(amortized cost)을 계산하면 O(1)의 시간 복잡도를 가집니다. 

그러나 가장 worst-case인 경우에는 복사가 수행될 때인데, 이때는 O(n)의 시간 복잡도를 가질 수 있습니다.

- amortized cost
    
    최악의 경우에 대한 평균적인 비용을 나타내는 개념입니다. 
    예를 들어, 배열의 크기를 동적으로 조정하는 알고리즘에서는 배열 크기 변경 연산의 비용이 크지만, 해당 연산이 발생하는 빈도가 적고, enqueueing 연산의 비용이 매우 작기 때문에 amortized cost를 통해 O(1)의 시간 복잡도를 가진다고 볼 수 있는 것입니다.
    

## Dequeue

```swift
public mutating func dequeue() -> T? {
  isEmpty ? nil : array.removeFirst()
}
```

만약 큐가 비어있다면, nil을 반환하고, 만약 아니라면, 배열의 첫 번째 요소를 제거하고 반환합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5b92e6a4-3536-4c39-a7c5-5a20c8448174/Untitled.png)

큐의 첫 번째 요소를 제거하는 것은 O(n)의 시간복잡도를 가집니다. 

이것은 항상 O(n)인데, 이유는 배열에 남아있는 모든 메모리의 위치를 이동(shifted)해야 하기 때문입니다.

## Debug and test

디버깅을 하기 위해서 CustomStringConvertible 프로토콜을 채택합니다.

```swift
extension QueueArray: CustomStringConvertible {
  public var description: String {
    String(describing: array)
  }
}
```

### 장점과 단점

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/d7fdc382-1d68-43b7-98a4-da02d0ade45b/Untitled.png)

Array-based Queue를 이용하면 enqueue을 통해 매우 빠른 연산을 수행할 수 있습니다.

하지만 단점 또한 존재합니다.

큐에서는 요소를 삭제하는 것이 매우 비효율적인데, 첫 번째 요소를 삭제하고 나머지 요소들의 위치를 옮겨야하기 때문입니다.

또한 매우 큰 큐에서도 문제가 될 수 있는데, 만약 배열이 커진다면, 사이즈를 키워 필요없는 공간을 차지할 수도 있기 때문입니다.

## Doubly linked list implementation

Doubly linked list란 이전의 노드 또한 참조하고 있는 linked list입니다.

```swift
public class QueueLinkedList<T>: Queue {
  private var list = DoublyLinkedList<T>()
  public init() {}
}
```

### Enqueue

큐에 요소를 추가하기 위해선 단순히 append를 해주면됩니다.

```swift
public func enqueue(_ element: T) -> Bool {
  list.append(element)
  return true
}
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a4f6341f-f2b1-48c7-bfad-df3f6a347506/Untitled.png)

이것은 O(1)의 시간 복잡도를 가집니다.

### Dequeue

큐에서 요소를 제거하기 위해서는 다음과 같은 식을 수행합니다.

```swift
public func dequeue() -> T? {
  guard !list.isEmpty, let element = list.first else {
    return nil
  }
  return list.remove(element)
}
```

리스트가 비어있는지 확인 후 없다면 nil을 반환하고, 있다면 첫 번째의 요소를 제거하고 반환합니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fb387ffa-9fb8-4e56-b870-b2419420532e/Untitled.png)

요소들을 이동할 필요가 없기 때문에, O(1)의 시간 복잡도를 가집니다.

### Checking the state of a queue

```swift
public var peek: T? {
  list.first?.value
}

public var isEmpty: Bool {
  list.isEmpty
}
```

위 식을 통해 peek와 isEmpty를 구성할 수 있습니다.

### Debug and test

디버깅을 위해 아래의 요소를 추가해줍니다.

```swift
extension QueueLinkedList: CustomStringConvertible {
  public var description: String {
    String(describing: list)
  }
}
```

### 장점과 단점

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bea8120c-aaf7-4dba-afcb-c51884b64cc2/Untitled.png)

Linked List로 만들면 dequeueing 또한 O(1)의 시간 복잡도를 가집니다. 

단점은 사실 테이블에서는 잘 보여지지 않습니다. O(1)의 성능에도 불구하고, 높은 오버헤드가 나타납니다. 
모든 요소들은 앞의 참조와 뒤의 참조를 저장하는 저장소를 포함해야 합니다.

게다가 새로운 요소를 추가할 때마다 동적 할당을 진행하기 때문에 상대적으로 비용이 많이 듭니다(비효율적). 
반대로 QueueArray는 더욱 빠른 할당을 부여합니다.

만약 고정된 크기에서 큐가 커질 일이 없다면, ring buffer를 이용할 수 있습니다. 

## Ring buffer implementation

circular buffer라고도 불리는 ring buffer는, 고정된 사이즈의 배열(fixed-size array)입니다.

이 자료 구조는 끝에서 제거할 항목이 없을 때 시작점으로 돌아가도록 구성되어 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/603d383f-ebec-4f1d-b625-47a47c57310a/Untitled.png)

크기가 4로 고정된 ring buffer를 생성합니다. ring buffer에는 두 가지를 추적할 수 있는 두 개의 포인터가 있습니다.

1. **read pointer**는 큐의 앞 부분을 추적합니다.
2. **write pointer**는 이용 가능한 다음 슬롯을 추적하여 이미 읽힌(read) 요소를 재정의(override)할 수 있습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c1421c56-5232-4f3d-8b86-0735d1a59544/Untitled.png)

아이템을 큐에 넣을 때마다, write pointer는 하나가 증가합니다.

여러 요소를 더 추가해보겠습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9f180646-bed0-45d5-85b9-d29b049e69c4/Untitled.png)

write pointer는 read pointer에 2칸 더 앞서있습니다. 이는 큐가 비어있지 않다는 뜻입니다.

여기서 2개의 아이템을 dequeue해보겠습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/05b3aa9a-21be-4481-89fb-dd900e11176a/Untitled.png)

Dequeuing하는 것은 ring buffer를 읽는 것과 같습니다. 

그 다음 하나의 아이템을 추가해보겠습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/645ba2ba-095e-4c2d-a15e-4228993387e6/Untitled.png)

write pointer가 끝에 도달했기 때문에, 시작 인덱스로 돌아갑니다. 이로 인해 circular buffer라고 불립니다.

마지막으로, 두 개의 아이템을 dequeue해보겠습니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9345cc08-f07c-44d3-a486-3e955dddf1c7/Untitled.png)

read pointer 또한 시작으로 돌아갔습니다.

만약 read와 write pointer가 같은 인덱스에 있다면, 큐는 비어있습니다.

큐를 생성해보겠습니다.

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
}
```

ring buffer는 고정된 사이즈이기 때문에 count 변수를 추가해주어야 합니다.

### Enqueue

```swift
public mutating func enqueue(_ element: T) -> Bool {
  ringBuffer.write(element)
}
```

큐에 요소를 추가하기 위해서 write()를 불러옵니다. 이는 write pointer를 한 번 증가시켜줍니다.

큐는 고정된 사이즈이기 때문에, 요소가 성공적으로 추가되었는지에 대해 true나 false를 반환해야합니다.

O(1)의 시간 복잡도를 사용하고 있습니다.

### Dequeue

```swift
public mutating func dequeue() -> T? { 
	ringBuffer.read()
}
```

아이템을 없애기 위해서, read()를 호출하여 read pointer를 한 번 증가시켜줍니다.

이것 뒤에, ringBuffer가 비어있는지 확인 후, 비어있다면 nil을 반환합니다.

### Debug and test

```swift
extension QueueRingBuffer: CustomStringConv ertible {
	public var description: String { 
		String(describing: ringBuffer)
	} 
}
```

기초가 되는 ring buffer에 위임하여 큐의 문자열을 표현합니다.

### 장점과 단점

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0cb87382-c060-45f0-afa9-f7b558adb029/Untitled.png)

linked list와 시간 복잡도는 같지만, 공간 복잡도가 다릅니다. 

ring buffer는 고정된 크기를 가지고 있기 때문에, enqueue가 실패할 수도 있습니다. 

## Double-stack implementation

```swift
public struct QueueStack<T> : Queue { 
	private var leftStack: [T] = [] 
	private var rightStack: [T] = [] 
	public init() {}
}
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4367c5e2-46bd-4234-af9d-f24333d6752e/Untitled.png)

enqueue를 하려고 할 때는 오른쪽 스택에 넣어주면 되고, dequeue를 할 때는오른쪽 스택의 순서를 변경하여 왼쪽 스택에 넣고, 그 중에서 요소를 선택하면 FIFO 구조처럼 데이터를 다룰 수 있습니다.

예를 들어 two stack은 요소를 enqueue할 때, Right stack에 데이터를 push한다고 가정합니다. (1, 2, 3)

여러가지 값들이 들어온 후에, dequeue를 하려고 할 때, Right Stack의 값을 Left Stack으로 옮겨줍니다.

이때, 스택은 LIFO이기 때문에, Left Stack에는 밑에서부터 3, 2, 1로 값이 쌓이게 됩니다. 

여기서 Left Stack을 pop하게 되면 1이 삭제되고, 순서대로 다시 Right Stack에 쌓으면 2,3 순서로 들어오기 때문에, FIFO 구조를 가질 수 있습니다.

```swift
public var isEmpty: Bool { 
	leftStack.isEmpty && rightStack.isEmpty
}
```

큐가 비어있는지 확인하기 위해서는 오른쪽, 왼쪽 스택이 모두 비어있는지 확인합니다. 

```swift
public var peek: T? {
!leftStack.isEmpty ? leftStack.last : rightStack.first 
}
```

peeking은 가장 앞의 요소를 보고 있습니다. 만약 왼쪽 스택이 비어있지 않다면, 왼쪽 스택의 가장 위에 있는 요소가 큐의 가장 앞에 있는 것입니다.

만약 왼쪽 스택이 비어있다면, 오른쪽 스택은 거꾸로 변환되어 왼쪽 스택에 위치할 것입니다.

### enqueue

```swift
public mutating func enqueue(_ element: T) -> Bool {
	rightStack.append(element)
	return true
}
```

요소를 추가하기 위해 오른쪽 스택을 호출합니다.

배열에 append를 통해 스택에 추가하는데, 이 방식은 (QueueArray에서 봤듯이) O(1)의 시간 복잡도를 가집니다.

### Dequeue

two-stack-based에서 아이템을 제거하는 것은 약간 복잡합니다. 

```swift
public mutating func dequeue() -> T? { 
	if leftStack.isEmpty { // 1
		leftStack = rightStack.reversed() // 2
		rightStack.removeAll() // 3 
	}
	return leftStack.popLast() // 4 
}
```

1. 왼쪽이 비어있는지 확인합니다.
2. 만약 왼쪽이 비어있다면, 왼쪽을 오른쪽의 반대로 추가합니다.
3. 오른쪽 스택을 비워둡니다.
4. 왼쪽이 비어있을 때까지 오른쪽으로 이동시킵니다.

NOTE. 사실 배열을 뒤집는 것은 O(n) 복잡도이지만, 평균 비용(amortized cost)은 O(1)입니다.

***>> 이래서 배열로 문제를 풀었을 때에도 시간 복잡도가 매우 작았던 것입니다 !!!***

### Debug and test

```swift
extension QueueStack: CustomStringConvertible {
	public var description: String { 
		String(describing: leftStack.reversed() + rightStack) 
	}
}
```

단순하게 거꾸로 정렬된 왼쪽 스택과 오른쪽 스택을 더해줍니다.

### 장점과 단점

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/34953e68-1f90-4c3c-8fe3-0bda5779dc4f/Untitled.png)

enqueue는 O(1)가 나타나고, dequeue 또한 평균 O(1) 연산이 실행됩니다.

게다가 two-stack은 동적이기 때문에 ring-buffer에서 가지고 있는 문제(고정된 크기)를 해결할 수 있습니다. 

worst-case가 O(n)까지 갈 수 있지만, 크기를 늘려주기 때문에, 그럴 일은 거의 없습니다.

마지막으로 linked list에 비해 공간 복잡도에서 우수합니다. 

linked list는 연속된 공간에 저장되어 있는 것이 아니지만, 스택은 연속된 공간에 할당되어 있기 때문에 훨씬 더 효율적입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/2b701ef1-e22c-46c3-b694-3e9b24c1b601/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a8d6b537-a3a5-40f1-a2e6-9bd93cc5a2d3/Untitled.png)

## Key points

- Queue는 FIFO 데이터 구조이기 때문에, 처음으로 추가된 요소가 처음으로 제거됩니다.
- Enqueue는 큐의 뒷 부분에 요소를 추가합니다.
- Dequeue는 큐의 앞 부분의 요소를 제거합니다.
- 배열에 있는 요소들은 연속된 메모리 블락에 할당되어 있는 반면, linked list는 비연속적이기 때문에 cache miss에 대한 잠재성이 있습니다.
- ring-buffer-queue-based는 고정된 크기의 큐에 적합합니다.
- 다른 자료 구조와 비교했을 때, two stacks의 dequeue는 평균 O(1)의 시간 복잡도를 가집니다.
- Double-stack은 linked listdㅔ 비해 공간 복잡도에서 우수한 성능을 보여줍니다.
