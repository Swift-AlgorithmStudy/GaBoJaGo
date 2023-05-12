# Chap3. Queues

Q. **일상생활에서 찾아볼 수 있는 큐의 예시에는 영화관 줄서기, 배식 줄서기가 있습니다. 무슨 특징이 있을까요?**

- 맨 처음 줄을 선 사람이 가장 먼저 줄을 빠져나갈 수 있다는 것입니다.

## 1. Queue

큐(Queue)는 데이터를 저장하고 검색하는 데 사용되는 선형 자료구조입니다. 큐에서 데이터는 먼저 들어온 것이 먼저 나가는 FIFO(First-In-First-Out) 원칙을 따릅니다.

### 공통 작업

**큐 프로토콜 정의**

```swift
public protocol Queue {
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
```

- enqueue: 대기열 뒤쪽에 요소를 삽입합니다. 작업이 성공하면 true를 반환합니다.
- dequeue: 큐 앞의 요소를 제거하고 반환합니다.
- isEmpty: 큐가 비어 있는지 확인합니다.
- peek: 제거하지 않고 큐의 앞에 있는 요소를 반환합니다.

큐는 앞쪽에서 제거하고 뒤쪽에 삽입하는 것에만 신경쓴다는 점에 유의해야합니다. 그 사이에 어떤 내용이 있는지 알 필요가 없고, 알아야한다면 배열을 사용하면 됩니다.


<br></br>
## 2. Array로 구현

**Queue 프로토콜을 채택한 generic QueueArray 구조체 정의**

```swift
public struct QueueArray<T>: Queue {
  private var array: [T] = []
  public init() {}

  public var isEmpty: Bool {
	  array.isEmpty // 큐가 비었는지 확인 O(1)
  }

	public var peek: T? {
	  array.first // 큐의 첫 요소 반환 O(1)
	}

	public mutating func enqueue(_ element: T) -> Bool {
		array.append(element) //큐 뒤에 요소 추가하기, 배열 뒤에 빈 공간이 있기 때문에 O(1)
	  return true
	}
	//여러 요소를 추가하면, 배열은 결국 가득 찰 것입니다. 
	//할당된 공간보다 더 많이 사용하고 싶을 때, 배열은 추가 공간을 만들기 위해 크기를 조정해야 합니다.

	public mutating func dequeue() -> T? {
	  isEmpty ? nil : array.removeFirst()
	}
	//대기열이 비어 있다면, dequeue는 nil을 반환. 그렇지 않다면, 배열의 앞에서 요소를 제거하고 반환 O(n) 
	//대기열 제거는 배열의 시작 부분에서 요소를 제거합니다. 이것은 배열의 나머지 모든 요소를 메모리에서 이동해야 하기 때문에 항상 선형 시간 작업입니다.
}
```

크기 조정이 O(n) 작업임에도 불구하고 enqueue는 O(1) 작업입니다. 크기를 조정하려면 배열이 새 메모리를 할당하고 모든 기존 데이터를 새 배열로 복사해야 합니다. 하지만 핵심은 이 복사가 자주 일어나지 않는다는 것입니다. 공간이 부족할 때마다 용량이 두 배가 되기 때문입니다. 결과적으로, 운영의 평균 비용을 계산하면, 대기열은 O(1)에 불과합니다. 즉, 최악의 성능은 복사가 수행될 때 O(n)입니다.

**배열로 구현한 큐의 강점과 약점**

대부분의 작업은 선형 시간이 걸리는 dequeue()를 제외하고 일정한 시간입니다. 저장 공간 또한 선형입니다.

| Operations | Average case | Worst case |
| --- | --- | --- |
| enqueue | O(1) | O(n) |
| dequeue | O(n) | O(n) |
| Space Complexity | O(n) | O(n) |

Enqueue는 O(1) append 덕분에 평균적으로 매우 빠릅니다.

시행에는 몇 가지 단점이 있습니다. 제거하면 모든 요소가 하나씩 이동하기 때문에 대기열 앞쪽에서 항목을 제거하는 것은 비효율적일 수 있고 이는 매우 큰 큐에 차이가 있습니다. 배열이 가득 차면, 크기를 조정해야 하며 사용하지 않는 공간이 있을 수 있습니다. 이것은 시간이 지남에 따라 당신의 메모리 footprint를 증가시킬 수 있습니다. 


<br></br>
## 3. Doubly linked list로 구현

이중 연결 리스트는 단순히 노드가 이전 노드를 참조하는 연결 리스트입니다.

**Queue 프로토콜을 채택한 generic QueueLinkedList 구조체 정의**

```swift
public class QueueLinkedList<T>: Queue {
	private var list = DoublyLinkedList<T>()
  public init() {}

	public func enqueue(_ element: T) -> Bool {
	  list.append(element)
	  return true
	}
	//리스트의 뒤에서, 이중 연결 리스트은 새로운 노드에 대한 꼬리 노드의 이전 및 다음 참조를 업데이트할 것이다. O(1)
	
	public func dequeue() -> T? {
	  guard !list.isEmpty, let element = list.first else {
	    return nil
	  }
	  return list.remove(element)
	} 
	//리스트가 비어 있지 않고 큐의 첫 번째 요소가 존재하는지 확인합니다. 
	//첫번째 요소가 없으면 nil을 반환하고, 요소가 있으면 큐 앞에 있는 요소를 제거하고 반환한다.
	//목록의 맨 앞에서 제거하는 것 또한 O(1) 작업입니다. 
	//배열로 구현할 때와 달리 요소를 하나씩 이동할 필요가 없었습니다. 
	//대신, 링크된 목록의 처음 두 노드 사이의 다음 및 이전 포인터를 업데이트하기만 하면 됩니다.
	
	public var peek: T? {
	  list.first?.value
	}
	
	public var isEmpty: Bool {
	  list.isEmpty //DoublyLinkedList에 구현
	}
}
```

**이중연결리스트로 구현한 큐의 강점과 약점**

| Operations | Average case | Worst case |
| --- | --- | --- |
| enqueue | O(1) | O(1) |
| dequeue | O(1) | O(1) |
| Space Complexity | O(n) | O(n) |

 QueueArray의 주요 문제 중 하나는 항목을 dequeuing하는 데 선형 시간이 걸린다는 것입니다. 연결 리스트로 구현하면 일정한 작업 O(1)로 줄일 수 있고, 이는  노드의 이전 및 다음 포인터를 업데이트하기만 하면 됩니다.

 QueueLinkedList의 주요 약점은 테이블에서 분명하지 않습니다. O(1) 성능에도 불구하고, 그것은 높은 오버헤드로 고통받고 있습니다. 각 요소는 앞으로 및 뒤로 참조를 위한 추가 저장 공간이 있어야 합니다. 게다가, 새로운 요소를 만들 때마다, 상대적으로 비싼 동적 할당이 필요합니다. 대조적으로, QueueArray는 더 빠른 대량 할당을 한다.

큐의 크기가 고정되어 있고 큐의 크기가 더 이상 커지지 않는 경우, Ring Buffer 방법을 사용하여 이러한 문제를 해결할 수 있습니다.

<br></br>
## 4. Ring buffer로 구현

Ring Buffer(원형 버퍼)는 고정 크기가 고정된 배열로, 데이터를 저장하는 자료구조입니다. 이 자료구조는 배열의 끝에서 더 이상 제거할 항목이 없을 때 시작 지점으로 랩핑(wrapping)됩니다.

예를 들어, 크기가 4인 Ring Buffer를 만든다면, 이 버퍼에는 4개의 항목만 저장할 수 있습니다. 이 버퍼는 순환하게 사용되며, 새 항목은 버퍼의 끝에 추가됩니다. 그러나 버퍼가 꽉 차게 되면, 새 항목을 추가할 수 없습니다. 이 경우, 버퍼는 다시 시작 지점에서부터 새로운 항목을 추가하기 시작합니다.

Enqueue 작업은 새 요소를 버퍼의 다음 위치에 추가하고, Dequeue 작업은 가장 오래된 요소를 버퍼의 첫 번째 위치에서 제거합니다. 이를 통해 할당 오버헤드를 제거하고, Dequeue 작업을 상수 시간 O(1)으로 처리할 수 있습니다.

**Queue 프로토콜을 채택한 generic  QueueRingBuffer 구조체 정의**

```swift
public struct QueueRingBuffer<T>: Queue {
  private var ringBuffer: RingBuffer<T>

  public init(count: Int) {
    ringBuffer = RingBuffer<T>(count: count)
  }
	//링 버퍼의 크기가 고정되어 있기 때문에 count 매개 변수를 포함해야 합니다.

  public var isEmpty: Bool { // O(1)
    ringBuffer.isEmpty
  }

  public var peek: T? { // O(1)
    ringBuffer.first
  }
	public mutating func enqueue(_ element: T) -> Bool { //O(1)
	  ringBuffer.write(element)
	}
	//요소를 추가하려면, write(_:)를 호출하기만 하면 됩니다. 이는 쓰기 포인터를 하나씩 증가시킵니다.
	//대기열의 크기가 고정되어 있기 때문에, 요소가 성공적으로 추가되었는지 여부를 나타내기 위해 true 또는 false를 반환해야 합니다. 
	
	public mutating func dequeue() -> T? {
	  ringBuffer.read()
	}
	//큐 앞쪽에서 항목을 제거하려면, read()를 호출하기만 하면 됩니다. 
	//큐의 뒤에서, 링버퍼가 비어 있는지 확인하고, 비었다면 0을 반환합니다. 
	//그렇지 않다면 버퍼의 앞에서 항목을 반환하고 읽기 포인터를 하나씩 증가시킵니다.

}
```

**원형 버퍼로 구현한 큐의 강점과 약점**

| Operations | Average case | Worst case |
| --- | --- | --- |
| enqueue | O(1) | O(1) |
| dequeue | O(1) | O(1) |
| Space Complexity | O(n) | O(n) |

링 버퍼 기반 큐는 연결 리스트 구현과 같은 enqueue와 dequeue에 대한 시간 복잡도을 가지고 있다. 유일한 차이점은 공간의 복잡성입니다. 링 버퍼는 고정된 크기를 가지고 있으며, 이는 enqueue가 실패할 수 있다는 것을 의미합니다.

<br></br>
## 5. Two stacks로 구현

 Two stacks의 spatial locality이 연결 리스트보다 좋고, 링 버퍼처럼 고정된 크기가 필요하지 않습니다.

요소를 큐에 삽입할 때마다, 그것은 오른쪽 스택으로 들어갑니다.

큐의 요소를 제거할 때, 오른쪽 스택을 뒤집고 왼쪽 스택에 배치하여 FIFO 순서를 사용하여 요소를 검색할 수 있습니다.

**Queue 프로토콜을 채택한 generic  QueueStack 구조체 정의**

```swift
public struct QueueStack<T> : Queue {
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  public init() {}

	public var isEmpty: Bool { //O(1)
	  leftStack.isEmpty && rightStack.isEmpty
	}
	//왼쪽과 오른쪽 스택이 모두 비어 있는지 확인합니다. 
	//대기열을 제거해야 할 요소가 없고, 새로운 요소가 대기열에 추가되지 않았다는 것을 의미합니다.
	
	public var peek: T? { //O(1) 
	  !leftStack.isEmpty ? leftStack.last : rightStack.first
	}
	//왼쪽 스택이 비어 있지 않다면, 이 스택 위에 있는 요소는 큐 앞에 있는 것입니다.
	//왼쪽 스택이 비어 있으면, 오른쪽 스택이 반전되어 왼쪽 스택에 배치됩니다.
	//이 경우, 오른쪽 스택 하단의 요소는 대기열의 다음입니다.
	
	public mutating func enqueue(_ element: T) -> Bool { // O(1)
	  rightStack.append(element)
	  return true
	} 
	//오른쪽 스택이 삽입하는 데 사용되므로 배열에 추가하여 스택으로 푸시하기만 하면 됩니다. 

	public mutating func dequeue() -> T? {
	  if leftStack.isEmpty { // 왼쪽 스택이 비었는지 확인
	    leftStack = rightStack.reversed() // 왼쪽 스택이 비었다면, 오른쪽 스택 순서를 뒤집어 왼쪽 스택에 저장 
	    rightStack.removeAll() // 모든 것을 왼쪽으로 옮겼으니,오른쪽 스택 전체 삭제
	  }
	  return leftStack.popLast() // 왼쪽 스택에서 마지막 요소를 제거
	}
	//왼쪽 스택이 비어 있을 때만 오른쪽 스택의 요소를 전송한다는 것을 기억하세요!
	//배열의 내용을 뒤집는 것은 O(n)입니다. 전체 대기열 비용은 여전히 O(1) 상각됩니다. 
	//왼쪽과 오른쪽 스택에 많은 항목이 있다고 상상해 보세요. 
	//모든 요소의 대기열을 제거하면, 먼저 왼쪽 스택에서 모든 요소를 제거한 다음, 오른쪽 스택을 한 번만 역복사한 다음, 왼쪽 스택에서 요소를 계속 제거합니다.
}
```

**더블 스택로 구현한 큐의 강점과 약점**

| Operations | Average case | Worst case |
| --- | --- | --- |
| enqueue | O(1) | O(n) |
| dequeue | O(1) | O(n) |
| Space Complexity | O(n) | O(n) |

 배열 기반 구현과 비교하여, 두 개의 스택을 활용하여 dequeue(_:)를 상각된 O(1) 작업으로 변환할 수 있었습니다.

 게다가, 두 스택 구현은 완전히 동적이며 링 버퍼 기반 큐 구현과 같은 고정된 크기 제한이 없습니다. 최악의 성능은 오른쪽 대기열을 되돌리거나 용량이 부족할 때 O(n)이다. 용량 부족은 일어날 때마다 두 배로 늘리기 때문에 자주 발생하지 않는다.

 마지막으로, 공간적 위치 측면에서 연결리스트를 능가합니다. 메모리 블록에서 배열 요소가 서로 옆에 있기 때문입니다. 그래서 많은 수의 요소가 처음 액세스할 때 캐시에 로드됩니다. 배열은 간단한 복사 작업을 위해 O(n)가 필요하지만, 메모리 bandwidth에 가까운 매우 빠른 O(n)입니다.

>> 요소가 인접한 메모리 블록에 있지 않은 연결된 목록. 이 비지역성은 더 많은 캐시 누락으로 이어질 수 있으며, 이는 액세스 시간을 증가시킬 것이다.

<br></br>
## 🗝️ Key points

- 큐는 FIFO 전략을 사용합니다. 먼저 추가된 요소를 먼저 제거해야 합니다.
- Enqueue는 요소를 큐 뒤에 삽입합니다.
- Dequeue는 큐 맨 앞에 있는 요소를 제거합니다.
- 배열의 요소들은 인접한 메모리 블록에 배치되는 반면, 연결리스트의 요소들은 캐시누락 가능성으로 인해 더 분산되어있습니다.
- 링 버퍼 대기열 기반 구현은 크기가 고정된 큐에 적합합니다.
- 다른 데이터 구조에 비해 두 개의 스택을 활용하면 상각된 O(1) 작업에 대한 dequeue(_:) 시간 복잡도가 개선됩니다.
- 이중 스택 구현은 스토리지 인접성 측면에서 연결리스트를 능가합니다.

<br></br>
# 🌱 연결리스트 문제 풀이

## **232. Implement Queue using Stacks**

```swift
class MyQueue {
    var queue: [Int]
    init() {
        self.queue = []
    }
    
    func push(_ x: Int) {
        queue.append(x)
    }
    
    func pop() -> Int {
        queue.removeFirst()
    }
    
    func peek() -> Int {
        queue.first ?? 0
    }
    
    func empty() -> Bool {
        queue.count > 0 ? false : true
    }
}
```

## **225. Implement Stack using Queues**

```swift
class MyStack {
    var stack: [Int]
    init() {
        self.stack = []
    }
    
    func push(_ x: Int) {
        stack.append(x)
    }
    
    func pop() -> Int {
        return stack.count > 0 ? stack.removeLast() : 0
    }
    
    func top() -> Int {
        return stack.last ?? 0
    }
    
    func empty() -> Bool {
        return stack.isEmpty
    }
}
```

## **387. First Unique Character in a String**

```swift
class Solution {
    func firstUniqChar(_ s: String) -> Int {
        var queue: [Character] = []
        var same: [Bool] = []
        for str in s {
            if let index = queue.firstIndex(of: str) {
                queue.append(str)
                same.append(true)
                same[index] = true
            }
            else {
                queue.append(str)
                same.append(false)
            }
        }
        return same.firstIndex(of: false) ?? -1
    }
}
```

### **풀이**

queue 리스트에 s를 캐릭터 타입으로 저장

same 리스트에는 같으면 true저장

same 리스트에서 false인 인덱스 반환하고 false가 없으면 -1

### **새로 알게된 개념**

특정 문자의 인덱스를 알고 싶을 때 firstIndex(of:)를 사용해서 원하는 문자가 있는 인덱스를 구할 수 있다.

반환형은 옵셔널이므로 언래핑 후 사용해야 된다.

## **1700. Number of Students Unable to Eat Lunch**

```swift
class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        var resultStudents: [Int] = students // 학생들의 대기 명단
        var resultSandwich: [Int] = sandwiches // 샌드위치 목록
        var count = 0 // 샌드위치를 못 먹는 학생의 수
        
        while !resultSandwich.isEmpty { // 샌드위치가 다 나눠질 때까지 반복
            if resultSandwich[0] == resultStudents[0] { // 맨 앞의 샌드위치와 맨 앞의 학생이 같으면
                resultSandwich.remove(at: 0) // 샌드위치를 제거하고
                resultStudents.remove(at: 0) // 학생을 제거하고
                count = 0 // 샌드위치를 못 먹는 학생 수를 0으로 초기화
            }
            else { // 맨 앞의 샌드위치와 맨 앞의 학생이 다르면
                resultStudents.append(resultStudents[0]) // 학생을 대기 명단의 맨 뒤로 보냄
                resultStudents.remove(at: 0) // 대기 명단에서 맨 앞의 학생을 제거
                
                count += 1 // 샌드위치를 못 먹는 학생 수를 1 증가시킴
                
                if count > resultSandwich.count { // 샌드위치를 못 먹는 학생 수가 샌드위치 수보다 크면
                    break // 반복 종료
                }
            }
        }
        return resultSandwich.count // 남은 샌드위치 수 반환
    }
}
```

## **2073. Time Needed to Buy Tickets**

```swift
class Solution {
    func timeRequiredToBuy(_ tickets: [Int], _ k: Int) -> Int {
        var ticket: [Int] = tickets
        var count: Int = 0
        
        while true {
            for i in 0 ..< ticket.count {
                if ticket[i] > 0 {
                    ticket[i] -= 1
                    count += 1
                }
                if ticket[k] == 0 {
                    return count
                }
            }
        }
    }
}
```

### **풀이**

ticket 리스트에 ticket를 정수 타입으로 저장

ticket 리스트를 돌면서 ticket[i]가 0보다 크면 1 감소, count 증가

ticket[k]가 0되면 count 반환
