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

# 문제 풀이

## 1. Baseball Game

### 풀이.

```swift
func calPoints(_ operations: [String]) -> Int {
    return solution(elements: operations)
}

func solution(elements: [String]) -> Int {
    var convertedArray: [Int] = []
    
    for element in elements {
        if let number = Int(element) {
            convertedArray.append(number)
        } else if element == "D" {
            var lastNumber = (convertedArray.last ?? 0) * 2
            convertedArray.append(lastNumber)
        } else if element == "C" {
            convertedArray.popLast()
        } else if element == "+" {
            convertedArray.append((convertedArray.last ?? 0) + convertedArray[convertedArray.count - 2])
        }
    }
    
    return convertedArray.reduce(0) { $0 + $1 }
}


```

### 설명.

입력받은 배열을 반복문을 통해 각각의 요소를 조건문을 통해 걸러낸다. 정수일 경우 새로운 결과배열에 더해주고, "D"일 경우 결과배열의 마지막 요소에 2를 곱한다. 
이런식으로 각각의 요소들을 해당하는 계산을 진행한다음 결과 배열을 반환한다.

### 주의할점.

switch문 생각할것.
suffix array 매서드 공부.

## 2. Remove All Adjacent Duplicates In String

### 풀이.

```swift
func removeDuplicates(_ s: String) -> String {
    var result = ""
    
    for i in s {
        if result.last != i {
            result.append(i)
        } else {
            result.popLast()
        }
    }
    
    return result
}
```

### 설명.

결과값을 저장할 문자열값을 선언하고, 입력받은 문자열을 반복문을 통해 결과값과 비교한다. 이때 결과값의 마지막 문자가 반복문으로 나누어진 문자와 같다면 결과값에서 제거해주고, 다르다면 결과값에 더해준다.

### 주의할점.

print문 주의.

## 3. Crawler Log Folder

### 풀이.

```swift
func minOperations(_ logs: [String]) -> Int {
    var a = 0
    
    for i in logs {
        if i == "../", a >= 1 {
            a -= 1
        } else if i == "./" {
            continue
        } else if i != "../" {
            a += 1
        }
    }
    
    return a
}
```

### 설명.

폴더의 깊이를 a라고 표현한다면, 요소값이 "../" 이면서, a가 1보다 크다면(음수값이 나오면 안되기 때문), a에서 1을 뺀다. 그리고 요소값이 "./"이라면 깊이의 변화가 없기 때문에 continue문을 사용하여 변화가 없게 한다. 마지막으로 위에 언급한 경우 외의 요소값들은 a에 1을 더해준다.

### 주의할점.

max 공부.

## 4. Maximum Nesting Depth of the Parentheses

### 풀이.

```swift
func maxDepth(_ s: String) -> Int {
    var result = 0
    var result2 = 0
    
    for i in s {
        if i == "(" {
            result += 1
        } else if i == ")" {
           
            if result > result2 {
                result2 = result
            }
            result -= 1
        }
    }
    
    return result2
}
```

### 설명.

반복문을 통한 요소의 값이 "("경우 result에 1을 더한다. ")"경우에는 result가 result2보다 클경우 result를 result2에 할당한 이후에 result에서 1을 뺀다. 그리고 result2를 반환한다.

### 주의할점.

switch문 사용.
max

## 5. Number of Students Unable to Eat Lunch

### 풀이.

```swift
 func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
    var a = students
    var b = sandwiches
    
    while b.count != 0 {
        if b[0] != a[0] {
            a.append(a[0])
            a.removeFirst()
            
            if a.contains(b[0]) == false {
                return b.count
            }
        } else {
            a.removeFirst()
            b.removeFirst()
        }
    }
    
    return b.count
}
```

### 설명.

파라미터는 immutable한 값이기 때문에 해당 값들을 임의의 변수에 할당한다음 계산한다. b의 첫번째 요소와 a의 첫번째 요소가 같다면 두 요소를 제거해 주고, 다르다면 a의 첫번째 요소를 a의 맨 뒤로 보낸다. 이러한 과정을 while 반복문을 통해 b의 갯수가 0이 될때까지 식을 반복한다. 그러나 a가 b의 첫번째 요소를 포함하고 있지 않다면 남은 b의 갯수를 리턴한다.

### 주의할점.

없음


