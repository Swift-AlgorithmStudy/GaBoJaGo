# LinkedList

연결리스트(LinkedList)는 노드가 데이터와 포인터를 가지고 한 줄로 연결 되어 있는 방식으로 데이터를 저장하는 자료 구조이다.

![](https://i.imgur.com/XdsOWoo.png)

이름 그대로 연결리스트는 위에 그림과 같은 노드들이 연결된 리스트를 말한다. 노드는 두 영역으로 나누어지는데 바로 데이터 영역과 포인터이다. 데이터 영역에는 당연히 데이터를 담는 영역이며, 포인터는 다음이나 이전의 노드의 참조값을 가지고 있어 다른 노드와의 연결을 담당한다.

## LinkedList 특징

LinkedList의 첫번째 특징으로는 하나의 메모리 공간에 순차적으로 데이터를 보관하는(정적할당) 배열과는 달리 연결리스트는 각각 떨어진 공간에 존재하는 데이터를 참조값을 통해 연결해 놓은 것(동적할당)이라는 점이다.

-   그림1

![](https://i.imgur.com/0gwNJfq.jpg)

또 배열처럼 중간에 요소를 삽입 또는 삭제 시 재배치에 발생하는 오버헤드도 발생하지 않는다.(배열의 경우는 마치 일자로 된 교회의자에 앉아 있는 사람들 사이에 앉으려는 행위와 같다: 한명 때문에 많은 사람이 한칸씩 당겨 안거나 한칸씩 비켜줘야함)

-   연결리스트 재배치 예시

![](https://i.imgur.com/firYI3v.jpg)

그림1의 연결리스트 3,8,5에서 3과 8사이에 6을 집어 넣으려면 3의 포인터 참조값을 8->6으로 6의 참조값을 8로만 설정해주면 된다.

단점으로는 배열처럼 Index값을 가지고 있는 것이 아니기 때문에 데이터에 접근하려면 첫 번째 데이터부터 원하는 데이터까지 순차적으로 찾아가야만 한다는 것이다(8을 찾아가려면 각 노드의 포인터를 따라 3->6->8). 결과적으로 접근 속도가 느리다는 단점을 가지게 된다.

또한 연결 정보(포인터)를 저장하는 별도의 영역이 필요하기 때문에 저장공간의 효율이 높지 않다.

## head

-   head: 가장 첫 노드를 가르키는 프로퍼티를 뜻함

그림1의 경우 3이란 data를 가지고 있는 노드를 head라 할 수 있음

## Swift에서 LinkedList와 Node 구현하기

-   Node

```swift
class Node<T: CalculateItem> {
    private var data: T?
    var next: Node<T>?
    // 다음 노드의 참조값을 담는 영역이기때문에 Node자체를 타입으로 가지고 있다.
    init(data: T, next: Node?) {
        self.data = data
        self.next = next
    }
}

extension Node: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        lhs === rhs
    }
}
// 제네릭 타입은 무슨 형태의 타입이 대입 될지 모르기 때문에 Equatable 프로토콜을 채택하고 있지 않다(Int, String등은 채택하고 있음). 그렇기 때문에 추후 값을 비교 하고 싶다면 채택을 별도로 해주어야 한다.
```

-   LinkedList

```swift
struct Linkedlist<T>: CalculateItem {
    private(set) var head: Node<T>?
    private(set) var tail: Node<T>?
    
    init() { }
    
    var isEmpty: Bool {
        return head == nil
    }
}
```

## 리스트에 값 추가하기

Linked List에 값을 추가하는 방법에는 세 가지가 있으며, 각각의 고유한 성능 특성을 가지고 있다.

1. push: 리스트 앞에 값을 추가한다.
2. append: 리스트 끝에 값을 추가한다.
3. insert(after:): 특정 노드 뒤에 값을 추가한다.

```swift
 mutating func push(_ data: T) {
        head = Node(data: data, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    // head에 입력받은 data를 가진 노드를 할당한다. 만약 tail이 nil이라면 tail은 head는 tail이된다.
    
    mutating func append(_ data: T) {
      guard !isEmpty else {
        push(data)
        return
      }
        
      tail!.next = Node(dat: data)
      tail = tail!.next
    }
    
    // 비어있는 리스트라면 push를 통해 data를 더해주고, 비어있지 않다면 tail의 다음값에 새로운 node를 할당한다. 이후 새로운 tail값을 설정한다.
    
    func findNode(at index: Int) -> Node<Value>? {
      var currentNode = head
      var currentIndex = 0
      while currentNode != nil && currentIndex < index {
        currentNode = currentNode!.next
        currentIndex += 1
      }
      return currentNode
    }
    
    //입력받은 인덱스값 이하의 모든 리스트를 반복문을 통해 훑어보고 해당 node를 찾아낸다.
    
    @discardableResult
    mutating func insert(_ data: T, after node: Node<T>) -> Node<T> {
      guard tail !== node else {
        append(data)
        return tail!
      }
      node.next = Node(data: data, next: node.next)
      return node.next!
    }
    
    //찾아낸 node가 tail인지 확인하고(tail이라면 그냥 append) 아니면 해당 node의 다음값에 할당한다.
```

## 리스트 값 제거하기

마찬가지로 값을 제거하는 방법에는 3가지가 있다.

1. pop: 리스트의 맨 앞의 값을 제거
2. removeLast: 리스트의 맨 뒤의 값을 제거
3. remove(at:): 특정 위치의 값을 제거

```swift
mutating func pop() -> T? {
        if head == nil {
            return nil
        }
        
        let firstElement = head?.data
        head = head?.next
        return firstElement
    }
    
    // head가 nil면 nil을 리턴한다. 그렇지 않으면 head의 data를 리턴하고 head의 다음값을 head로 설정한다.
    
    @discardableResult
    public mutating func removeLast() -> T? {
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        
        return current.data
    }
    
    // head가 nil이 아니고 head의 다음값이 nil(nil이면 pop을 하면됨)이 아니라면, while 반복문을 통해 마지막 node 값을 찾고 마지막 노드값의 이전값(prev)에 nil을 할당하여 연결을 끊어버린다. 그리고 tail 값을 prev값으로 설정한다.
    
    @discardableResult
    mutating func remove(after node: Node<T>) -> T? {
        if node.next === tail {
            tail = node
        }
        node.next = node.next?.next
        
        return node.next?.data
    }
    
    // 특정 node의 다음값이 tail과 같다면 tail은 입력받은 node로 설정한다. 그렇지 않다면 입력받은 node의 다음의 다음값을 node의 다음값으로 설정한다.
    
```

# 문제풀이

## 1. Merge Two Sorted Lists 

### 풀이.

```swift
func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
    if list1 == nil {
        return list2
    } else if list2 == nil {
        return list1
    }
    
    var head: ListNode?
    var tail: ListNode?
    
    if list1!.val < list2!.val {
        head = list1
        tail = mergeTwoLists(list1!.next, list2)
    } else {
        head = list2
        tail = mergeTwoLists(list1, list2!.next)
    }
    head!.next = tail
    
    return head
}
```

### 설명.

list1또는 list2가 nil이 아닌지 확인 작업을 거친다. list1 또는 list2가 nil이라면 큰수는 당연히 다른 나머지가 된다. 둘 다 nil이 아닐 경우, list1,2의 value값을 비교한다. list1의 value 크다면 head는 list1이 된다. 그리고 tail은 재귀함수를 통해 list1.next value값과 list2의 value값을 다시한번 비교해서 설정한다. list2가 클 경우도 동일하다. 그리고 마지막으로 head의 next를 tail로 설정하고 head를 return 하면 된다.

시간 복잡도 O(n) -> 재귀함수

### 주의할점.

linked list의 요소(Nord)는 참조값을 가진 클래스 객체이다. 그렇기 때문에 문제를 풀때 하나의 객체로서 생각하는 마인드가 필요한거 같다. array처럼 생각하면 안될듯.

## 2. Remove Linked List Elements 

### 풀이.

```swift
func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
    var previous: ListNode? = ListNode(0)
    var result = previous
    var current = head
    previous?.next = current
    
    while current != nil {
        if current?.val == val {
            previous?.next = current?.next
        } else {
            previous = current
        }
        
        current = current?.next
    }
    
    return result?.next
}
```

### 설명.

node를 하나를 만들고 previous에 할당한다. previous는 head를 할당받은 current의 앞에 있는 node이다. 그 다음 current의 값이 nil이 될때까지 while 반복문을 돌린다. 이때 current의 value가 입력받은 value값과 같다면 previous의 next 값에 current의 next 값을 할당한다. 같지 않다면 previous 값에 current를 할당한다. 이후 current에 current의 next 값을 할당한다. 마지막으로 result의 next값을 리턴하면 끝난다.

### 주의할점.

node를 만들고 previous에 할당하는것과 그냥 previous를 빈 node로 바로 만든는 것이 뭐가 다른지 모르겠다.

## 3. Reverse Linked List 

### 풀이.

```swift
func reverseList(_ head: ListNode?) -> ListNode? {
    guard let head = head else { return nil }
    guard var current = head.next else { return head }
    var previous = head
    previous.next = nil
    
    while let next = head.next {
        current.next = previous
        previous = current
        current = next
    }
    current.next = previous

    return current
}
```

### 설명.

답을봐도 모르겠다 미치겠다 너무 어렵다. 머리가 안돌아간다. 나는 뭐하는 놈인가.

### 주의할점.



## 4. Middle of the Linked List

### 풀이.

```swift
func middleNode(_ head: ListNode?) -> ListNode? {
    var slow = head
    var fast = head

    while fast?.next != nil {
        fast = fast?.next?.next
        slow = slow?.next
    }

    return slow
}
```

### 설명.

slow와 fast를 선언하고 fast가 두번이동 할 동안 slow가 한번이동하면 fast가 끝에 도달할때 slow는 중간부터 끝까지의 값이 되게 된다.

### 주의할점.

어렵다. 

## 5. Convert Binary Number in a Linked List to Integer

### 풀이.

```swift
 func getDecimalValue(_ head: ListNode?) -> Int {
    var node = head
    var result = ""
    
    while node != nil {
        result.append(String(node?.val ?? 0))
        node = node?.next
    }
    
    return Int(result, radix: 2)!
}
```

### 설명.

result를 빈 문자열로 선언해준다음 입력받은 리스트의 요소들을 String 값으로 더해주었다. 그런다음 radix를 사용하여 10진법으로 변환하였다.

### 주의할점.

시간복잡도 생각.
너무어려움.
