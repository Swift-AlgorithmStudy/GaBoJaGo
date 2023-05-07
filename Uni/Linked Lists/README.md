# Chapter 6: Linked Lists

링크드리스트는 선형적이며 단방향으로 값이 나열된 자료구조. 다음과 같은 특징을 가진다.

- 삽입, 삭제: O(1)
- 탐색: O(n)

<img width="221" alt="스크린샷 2023-05-07 오후 8 44 38" src="https://user-images.githubusercontent.com/22979718/236678593-186d20f3-907f-4b40-be13-a88e7eabefb9.png">

아래의 그림과 같이 링크드리스트는 노드들의 체인으로 구성되며, 각 노드는 다음으로 구성된다.

1. 값 저장
2. 다음 노드에 대한 참조 저장. 리스트의 끝은 nil

<img width="196" alt="스크린샷 2023-05-07 오후 8 46 37" src="https://user-images.githubusercontent.com/22979718/236678613-1090e06f-311d-4f51-b999-adb906394dc9.png">

## Node

- Swift로 구현한 Node 예시

    ```swift
    public class Node<Value> {
      public var value: Value
      public var next: Node?
      public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
      }
    }
    extension Node: CustomStringConvertible {
      public var description: String {
        guard let next = next else {
          return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
      }
    }
    ```


## LinkedList

- Swift로 구현한 LinkedList 예시

    ```swift
    public struct LinkedList<Value> {
      public var head: Node<Value>?
      public var tail: Node<Value>?
      public init() {}
      public var isEmpty: Bool {
    		head == nil
    	}
    }
    extension LinkedList: CustomStringConvertible {
      public var description: String {
        guard let head = head else {
          return "Empty list"
        }
        return String(describing: head)
      }
    }
    ```

    <img width="192" alt="스크린샷 2023-05-07 오후 8 55 55" src="https://user-images.githubusercontent.com/22979718/236678668-88abed5a-85dc-4c67-a370-d8df844416a6.png">



## 추가 방법

링크드리스트에 값을 추가하는 방법은 아래의 세가지가 있다.

1. push - 리스트의 앞부분에 값을 추가
2. append - 리스트의 끝부분에 값을 추가
3. insert(after:) - 특정 리스트 노드 다음에 값을 추가

### push 작업

- 리스트의 앞부분에 값을 추가하는 방법
- head-first 삽입이라고도 함

```swift
public mutating func push(_ value: Value) {
  head = Node(value: value, next: head)
  if tail == nil {
		tail = head
	}
}
```

### append 작업

- 리스트의 끝부분에 값을 추가하는 방법
- tail-end 삽입이라고 함

```swift
public mutating func append(_ value: Value) {
  guard !isEmpty else {
    push(value)
		return
	}
  tail!.next = Node(value: value)
  tail = tail!.next
}
```

### insert(after:) 작업

리스트의 특정 위치에 값을 삽입하는 방법. 2단계가 필요함

1. 리스트에서 특정 노드 찾기

    ```swift
    public func node(at index: Int) -> Node<Value>? {
      var currentNode = head
      var currentIndex = 0
      while currentNode != nil && currentIndex < index {
        currentNode = currentNode!.next
        currentIndex += 1
      }
      return currentNode
    }
    ```

2. 새로운 노드를 삽입하기

    ```swift
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
      guard tail !== node else {
        append(value)
        return tail!
      }
      node.next = Node(value: value, next: node.next)
      return node.next!
    }
    ```


### 성능 분석

<img width="477" alt="스크린샷 2023-05-07 오후 9 05 55" src="https://user-images.githubusercontent.com/22979718/236678690-4bdd4dc7-c9fd-4c5c-91aa-568b9a913a01.png">


## 삭제 방법

링크드리스트에서 노드를 제거하는 방법은 아래의 세가지가 있다.

1. pop - 리스트의 맨 앞의 값을 제거
2. removeLast - 리스트의 끝의 값을 제거
3. remove(at:) - 리스트의 어디에서든(anywhere🎶) 값을 제거

### pop 작업

- 링크드리스트의 가장 앞에 있는 노드를 제거하는 방법
- 리스트가 비어있는 경우 nil이 반환됨
- Node에 nil을 설정하면 ARC(Automatic Reference Counting)에 의해 메모리에서 제거됨

```swift
@discardableResult
public mutating func pop() -> Value? {
  defer {
    head = head?.next
    if isEmpty {
			tail = nil }
	}
  return head?.value
}
```

### removeLast 작업

- 링크드리스트의 마지막 노드를 제거하는 방법
- 단방향 순회이기 때문에 two pointers(prev, current) 방식을 사용함

```swift
@discardableResult
public mutating func removeLast() -> Value? {
  guard let head = head else {
		return nil
	}
  guard head.next != nil else {
    return pop()
  }
  var prev = head
  var current = head
  while let next = current.next {
    prev = current
    current = next
  }
  prev.next = nil
  tail = prev
  return current.value
}
```

### remove(after:) 작업

- 리스트의 특정 지점의 특정 노드를 제거하는 방법

```swift
@discardableResult
public mutating func remove(after node: Node<Value>) -> Value? {
  defer {
    if node.next === tail {
			tail = node
		}
    node.next = node.next?.next
  }
  return node.next?.value
}
```

### 성능 분석

<img width="416" alt="스크린샷 2023-05-07 오후 9 37 29" src="https://user-images.githubusercontent.com/22979718/236678694-79ef51f0-efd3-4081-a267-5d961753c1ab.png">


## 키 포인트

- 연결 리스트는 선형적이며 단방향적입니다. 하나의 노드에서 다른 노드로 참조를 옮기면 돌아갈 수 없습니다.
- 연결 리스트는 head-first 삽입에 대해 O(1)의 시간 복잡도를 가집니다. 배열은 head-first 삽입에 대해 O(n)의 시간 복잡도를 가집니다.
- Sequence 및 Collection과 같은 Swift collection 프로토콜을 준수하면 다양한 유용한 메서드에 대한 액세스 권한이 자동으로 제공됩니다.
- Copy-on-write 동작을 통해 좋은 성능을 유지하면서 값 의미 체계를 달성할 수 있습니다.

## Leetcode 문제

### 21. Merge Two Sorted Lists

- 오름차순으로 정렬된 두 링크드리스트를 하나의 링크드리스트로 만들어 반환하는 문제
- list1, list2가 nil인 경우, list1 혹은 list2가 nil인 경우 등등을 고려하다보니 return answer.next로 구현하게 되었는데, 좀 더 깔끔한 방법을 찾아야 할듯
- Time: 12 ms (45.89%), Space: 14.1 MB (37.87%) - LeetHub

```swift
class Solution {
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        let answer = ListNode()
        var list1 = list1, list2 = list2, dummy = answer
        while list1 != nil || list2 != nil {
            dummy.next = ListNode()
            dummy = dummy.next!
            if list1 == nil {
                dummy.val = list2!.val
                list2 = list2!.next
            } else if list2 == nil {
                dummy.val = list1!.val
                list1 = list1!.next
            } else if list1!.val < list2!.val {
                dummy.val = list1!.val
                list1 = list1!.next
            } else {
                dummy.val = list2!.val
                list2 = list2!.next
            }
        }
        return answer.next
    }
}
```

### 203. Remove Linked List Elements

- 링크드리스트에서 val과 같은 값을 가지는 노드를 제거하는 문제
- 제거하지 않고 새로운 링크드리스트에 val과 다른 값을 가지는 노드를 추가하는 방식으로 구현했다. 9.36%인걸 보니 효율적인 방식은 아닌듯...
- Time: 58 ms (9.36%), Space: 16.2 MB (8.77%) - LeetHub

```swift
class Solution {
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        let answer = ListNode()
        var cur = head, dummy = answer
        while cur != nil {
            if cur!.val != val {
                dummy.next = ListNode(cur!.val)
                dummy = dummy.next!
            }
            cur = cur!.next
        }
        return answer.next
    }
}
```

### 206. Reverse Linked List

- 주어진 링크드리스트를 반대로 뒤집는(reverse) 문제
- head를 순회하면서 answer 링크드리스트의 맨 앞에 노드를 추가하는 방식으로 구현. 비효율적인 방식인듯
- Time: 17 ms (6.70%), Space: 15 MB (23.94%) - LeetHub

```swift
class Solution {
    func reverseList(_ head: ListNode?) -> ListNode? {
        guard head != nil else {return nil}
        var answer = ListNode(head!.val)
        var cur = head
        cur = cur!.next
        while cur != nil {
            var dummy = answer
            answer = ListNode(cur!.val)
            answer.next = dummy
            cur = cur!.next
        }
        return answer
    }
}
```

### 876. Middle of the Linked List

- 주어진 링크드리스트의 중간 이후의 리스트를 반환하는 문제
- 리스트 head의 전체를 순회하여 노드의 갯수를 센 후, 다시 순회하면서 갯수의 절반이상이 되면 반환하는 방식으로 구현
- Time: 3 ms (76.66%), Space: 13.9 MB (64.27%) - LeetHub

```swift
class Solution {
    func middleNode(_ head: ListNode?) -> ListNode? {
        guard head != nil else {return nil}
        var cur = head, count = 0
        while cur != nil {
            count += 1
            cur = cur!.next
        }
        let middle = Int(count / 2)
        cur = head
        var index = 0
        while cur != nil {
            if index >= middle {
                break
            }
            cur = cur!.next
            index += 1
        }
        return cur
    }
}
```

### 1290. Convert Binary Number in a Linked List to Integer

- 2진수로 이루어져있는 링크드리스트를 10진수 값으로 변환하는 문제
  ex) [1, 0, 1] -> 5
- Time: 7 ms (29.09%), Space: 13.8 MB (76.36%) - LeetHub

```swift
class Solution {
    func getDecimalValue(_ head: ListNode?) -> Int {
        var answer = 0, cur = head
        while cur != nil {
            answer *= 2
            answer += cur!.val
            cur = cur!.next
        }
        return answer
    }
}
```