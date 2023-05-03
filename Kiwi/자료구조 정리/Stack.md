# Stacks

스택은 우리 일상에 어디에나 있다. 팬케이크, 책, 돈다발 등이 그 예이다.
가장 마지막에 더하는것은 맨 위에 쌓이고, 가장 맨 위에서 부터 사용된다(LIFO).

스택에서 가장 중요한 기능은 두가지이다.

PUSH: 스택에 가장 위에 요소를 더하는 것
POP: 스택의 맨 위의 요소를 없애는 것

## 스위프트에서의 사용

1. iOS에서는 네비게이션 스택을 사용하여 뷰 컨트롤러를 PUSH,POP 한다.
2. 구조적인 수준에서 메모리를 할당할때 스택을 사용한다. 지역 변수의 메모리도 스택을 사용하여 관리된다.

## 구현

```swift
public struct Stack<Element> {

  private var storage: [Element] = []

  public init(_ elements: [Element]) {
    storage = elements
  }
// 어떠한 타입의 요소가 될지 모르니 제네릭을 사용하여 플레이스 홀더 타입을 구현. 그리고 해당 타입의 빈 배열을 선언한다.

  public mutating func push(_ element: Element) {
    storage.append(element)
  }

  @discardableResult
  public mutating func pop() -> Element? {
    storage.popLast()
  }
// array메서드를 통한 push,pop 구현. 구조체의 내부 프로퍼티 값을 변경하기 위해 mutating 키워드 사용. 
    
  public func peek() -> Element? {
    storage.last
  }

  public var isEmpty: Bool {
    peek() == nil
  }
// 필수는 아니나, 구현하면 좋음
}
```
