# Queue

서브웨이에 샌드위치를 사려고 사람들이 줄을 서고 있다. 이때 이 사람들이 서있는 줄을 영어로 뭐라 표현할까? 바로 **큐(queue)** 이다.

5명의 사람이 샌드위치를 사려고 기다리고 있다고 가정할때, 샌드위치를 가장 먼저 살 수 있는 사람은 **큐(queue)** 의 맨 앞 **(front)** 첫번째 사람일 것이고, 마지막으로 샌드위치를 구매 할 수 있는 사람은 가장 늦게 온 5번째 사람일 것이다. 또한 구매가 끝난 첫번째 사람은 샌드위치를 들고 **큐(queue)** 를 벗어날 것이고, 만약 새로운 사람이 샌드위치를 구매하려 왔다면 마지막 다섯번째 사람 뒤 **(rear)** 에 줄을 서야 할 것이다.

Queue 역시 이 경우와 같은 선입선출(First in, First Out)방식의 자료구조라고 할 수 있다.

## 큐의 특징

위 예시에서 언급한 바와 같이 샌드위치를 구매한 후 사람들이 빠져나가는 곳은 큐의 맨 앞이 되고, 새로운 사람이 줄을 서는 곳은 큐의 맨 뒤가 된다. 또한 가장 마지막에 온 사람이 큐의 맨앞에 설 수가 없고, 가장 나중에 줄에 선 사람이 앞의 사람들을 무시하면서 구매를 먼저하고 큐를 빠져 나갈 수도 없다.

이처럼 queue에서도 한쪽 끝에서는 삭제 작업만 이루어지며, 다른쪽 끝에서는 삽입 작업만이 이루어진다. 또한 원소가 들어온 순서대로 큐를 빠져나가게 된다.

이때 삭제연산만이 이루어 지는 곳을 프론트(front: 줄의 맨 앞)라고 하며, 삽입연산만 이루어지는 곳을 리어(rear: 줄의 맨 뒤)라고 한다. 나아가 큐의 리어에서 이루어지는 삽입연산을 인큐(enQueue: 사람들이 줄을 서는 것), 프론트에서 이루어지는 삭제연산을 디큐(deQueue: 사람들이 줄을 빠져 나가는 것)라고 한다.

## Swift에서 큐 구현하기 

### Array 기반

```swift
struct CalculatorItemQueue<T> {
    private var queue: [T] = []
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: T? {
        array.first
    }
    
    // 사람들이 서 있는 줄을 말함
    mutating func enqueue(data: T) {
        list.append(data)
    }
    // 샌드위치를 사러 온 사람이 맨 뒤에 줄을 서는 것, O(1) 빈곳에 사람이 줄을 서기 때문에
    mutating func dequeue() -> T? {
        list.removeFirst()
    }
    // 샌드위치를 구매 완료한 맨 앞의 사람의 줄을 떠나는 것, O(n) 모든사람이 앞으로 한칸씩 땡겨야 함
    mutating func removeAll() {
        list.removeAll()
    }
    // 구현 필수 조건 아님
}
```

### LinkedList 기반

**LinkedList**
```swift 
public class DoublyLinkedList<T> {
  
  private var head: Node<T>?
  private var tail: Node<T>?
  
  public init() { }
  
  public var isEmpty: Bool {
    head == nil
  }
  
  public var first: Node<T>? {
    head
  }
  
  public func append(_ value: T) {
    let newNode = Node(value: value)
    
    guard let tailNode = tail else {
      head = newNode
      tail = newNode
      return
    }
    
    newNode.previous = tailNode
    tailNode.next = newNode
    tail = newNode
  }
    
  // tailNode가 nil이면 head와 tail은 newNode가 된다. 이외에는 newNode의 previous는 tailNode가 되고 tailNode의 next는 newNode가 된다.
    
  public func remove(_ node: Node<T>) -> T {
    let prev = node.previous
    let next = node.next
    
    if let prev = prev {
      prev.next = next
    } else {
      head = next
    }
    
    next?.previous = prev
    
    if next == nil {
      tail = prev
    }
    
    node.previous = nil
    node.next = nil
    
    return node.value
  }
    
    // previous가 nil이 아니면 previous의 next가 next가 되고 나머지 경우는 head가 next가 된다. 이후 next 의 previous는 previous를 할당해준다. 그리고 next 가 nil이라면 마지막 값이라는 뜻이기 때문에 tail은 previous가 된다. 마지막으로 node의 previous와 next에 nil을 할당하여 연결을 끝어준다음 node의 value를 리턴한다.
}
```

```swift
public class QueueLinkedList<T>: Queue {
  
  private var list = DoublyLinkedList<T>()
  public init() {}

  public var peek: T? {
    list.first?.value
  }
  
  public var isEmpty: Bool {
    list.isEmpty
  }
  
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
}
```

참조타입 힙영역저장으로 인해 새로운 리스트를 추가할때 만다지속적인 동적할당 생김 메모리적 부담이 생긴다.

## Ring buffer 기반

```swift
public struct RingBuffer<T> {
    
    private var array: [T?] // 고정된 크기의 배열
    private var readIndex = 0
    private var writeIndex = 0
    
    public init(count: Int) {
        array = Array<T?>(repeating: nil, count: count)
    }
    
    public var first: T? {
        array[readIndex]
        // RingBuffer 의 Read 인 readIndex 를 읽어오면 큐의 첫번째 값이다.
    }
    
    public mutating func write(_ element: T) -> Bool {
        if !isFull {
            array[writeIndex % array.count] = element
            writeIndex += 1
            return true
        } else {
            return false
        }
    }
    
    public mutating func read() -> T? {
        if !isEmpty {
            let element = array[readIndex % array.count]
                //다시 돌아오는 것을 표현
            readIndex += 1
            return element
        } else {
            return nil
        }
    }
    
    private var availableSpaceForReading: Int {
        writeIndex - readIndex
        // 읽을 수 있는 개수를 표현한 것
    }
    
    public var isEmpty: Bool {
        availableSpaceForReading == 0
    }
    
    private var availableSpaceForWriting: Int {
        array.count - availableSpaceForReading
        // 큐에 값을 추가하는 wirte 을 할 수 있는 것을 표현 것
        // 고정된 배열이기 때문에 배열의 크기에서 읽을 수 있는 개수 빼면 나머지가 입력할 수 있는 개수다.
    }
    
    public var isFull: Bool {
        availableSpaceForWriting == 0
    }
}

extension RingBuffer: CustomStringConvertible {
    public var description: String {
        let values = (0..<availableSpaceForReading).map {
            String(describing: array[($0 + readIndex) % array.count]!)
        }
        return "[" + values.joined(separator: ", ") + "]"
    }
}
```

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

## Leveraging arrays 기반

```swift
public struct QueueStack<T> : Queue {
    
    private var leftStack: [T] = [] // deQueue 를 담당할 왼쪽 스택
    private var rightStack: [T] = [] // enQueue 를 담당할 오른쪽 스택
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
    // dequeue 목록인 왼쪽 배열이 비어있지 않다면, 그냥 마지막 값을 반환만 하면 된다. 거꾸로 정렬해서 제일 먼저 들어온 값이 맨 끝으로 가므로 거꾸로 정렬한 이후 옮겨진 오른쪽 스택 값들은 모두 제거한다. 그리고 왼쪽 큐의 마지막 값을 리턴하면된다.
}

extension QueueStack: CustomStringConvertible {
    
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
        // 두 스택 모두가 큐의 전체 값이므로 큐를 표혀하려면 연결해서 표현
    }
}
```

# 문제풀이

## 1.Implement Queue using Stacks  

### 풀이.

```swift

class Stack {
    var array = [Int]()
    
    func push(_ x: Int) {
        array.append(x)
    }
    
    func pop() -> Int {
        array.removeFirst()
    }
    
    func peek() -> Int {
        array[0]
    }
    
    func empty() -> Bool {
        array.isEmpty
    }
}

class MyQueue {
    var stack1 = Stack()
    var stack2 = Stack()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        if stack2.empty() {
            stack1.push(x)
        } else {
            while !stack2.empty() {
                stack1.push(stack2.pop())
            }
            stack1.push(x)
        }
    }
    // stack2가 비어있다면 stack1에 맨뒤에 추가하면 push가 구현된다. 그러나 비어있지 않다면 모든 요소를 stack1에 옮겨 담은후 stack1에 push 하면 된다. 
    func pop() -> Int {
        if stack1.empty() {
            return stack2.pop()
        } else {
            while !stack1.empty() {
                stack2.push(stack1.pop())
            }
            return stack2.pop()
        }
    }
    // stack1을 stack2로 뒤에서 부터 담는다면 stack2의 마지막 요소는 전체 큐의 첫번째 요소가된다. 그래서 stack2에 담은다음 pop을 하면된다.
    func peek() -> Int {
        if stack2.empty() {
            
            return stack1.peek()
        } else {
            while !stack2.empty() {
                stack1.push(stack2.pop())
            }
            return stack1.peek()
        }
    }
    // stack1의 peek이 전체 큐의 peek이 된다.
    
    func empty() -> Bool {
        if stack1.empty() && stack2.empty() {
            return true
        } else  {
            return false
        }
    }
}

```

### 설명.

스택을 두개 선언하고, push와 pop을 이용해 요소를 옮겨가며 문제를 푼다.

### 주의할점.

문제를 잘 좀 읽자

## 2.  

### 풀이.

```swift
class Queue {
    var array = [Int]()
    
    func push(_ x: Int) {
        array.append(x)
    }
    
    func pop() -> Int {
        array.removeFirst()
    }
    
    func peek() -> Int {
        array.first!
    }
    
    func empty() -> Bool {
        array.isEmpty
    }
    
    func count() -> Int {
        array.count
    }
}

class MyStack {
    var queue1 = Queue()
    var queue2 = Queue()
    
    init() {
        
    }
    
    func push(_ x: Int) {
        queue1.push(x)
    }
    // push는 queue1에 더하면 끝이다.
    
    func pop() -> Int {
        if !queue1.empty() {
            while queue1.count() != 1 {
                queue2.push(queue1.pop())
            }
            return queue1.pop()
        } else {
            while queue2.count() != 1 {
                queue1.push(queue2.pop())
            }
            return queue2.pop()
        }
    }
    // 다른 큐로 하나가 남을때까지 옮긴다음 하나가 남으면 그것을 pop한다. 그러면 마지막 요소가 사라진다.
    
    func top() -> Int {
        if !queue1.empty() {
            while queue1.count() != 1 {
                queue2.push(queue1.pop())
            }
            defer {
                queue2.push(queue1.pop())
            }
            return queue1.peek()
        } else {
            while queue2.count() != 1 {
                queue1.push(queue2.pop())
            }
            defer {
                queue1.push(queue2.pop())
            }
            
            return queue2.peek()
        }
    }
    
    // pop과 같은 원리지만 요소가 사라지면 안되기 때문에 defer문을 활용하여 마지막으로 다른큐로 옮겨 준다.
    
    func empty() -> Bool {
        if queue1.empty() && queue2.empty() {
            return true
        }
        return false
    }
}

```

### 설명.

queue를 두개 이용해서 두개를 왔다리 갔다리 하면서 한다.

### 주의할점.

defer문의 활용
count라는 메서드를 임의로 만들었는데 허용가능한건가?

## 3. 

### 풀이.

```swift
func firstUniqChar(_ s: String) -> Int {
    var array: [String] = []
    var result: [String] = []
    var index = 0
    
    for i in s {
        array.append(String(i))
    }
    
    for i in array {
        array.remove(at: index)
        result = array
        
        if result.contains(i) {
            array.insert(i, at: index)
            index += 1
            continue
        } else {
            return index
        }
    }
    
    if index == array.count {
        return -1
    }
    
    return index
}
```

### 설명.

입력 받은 문자열 값을 array에 담는다. 그다음 첫번째 요소부터 해당 요소를 제외한 배열과(result)와 비교한다. result 배열이 해당 요소를 포함하고 있으면 index값을 하나 더한다음 반복문을 진행시키고 포함하지 않는다면 그 즉시 리턴한다. 만약 반복문을 다 진행한다음 index값이 array의 요소 갯수와 같다면 -1을 반환한다.

### 주의할점.

print문 제거 주의
시간복잡도 개망
능지이슈

## 4. Time Needed to Buy Tickets

### 풀이.

```swift
func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
    tickets.enumerated().reduce(0) { $0 + min(tickets[k], $1.1) + ($1.1 >= tickets[k] && $1.0 > k ? -1 : 0) }
}
```

### 설명.

능지처참.

### 주의할점.

알콜성 치매.
지능 저하.
30대 이슈.



