# Binary Search Trees
> 이진 탐색 트리에 대해 알아보자 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/89845986-5add-4bce-baaa-32c1413ce680"> </br>

* '이진 탐색 트리(Binary Search Tree, BST)'는 빠른 조회, 삽입 및 삭제 작업을 가능하게 하는 데이터 구조입니다.
* 위의 그림처럼 한 쪽을 선택하면 다른 쪽의 가능성을 모두 포기하게 되며, 가능성을 절반으로 줄이게 됩니다.

이진 탐색 트리에는 두 가지의 특징이 있습니다. </br>

1. **왼쪽 자식 노드**의 값은 부모 노드의 값보다 작아야 합니다.
2. **오른쪽 자식 노드**의 값은 부모 노드의 값보다 크거나 같아야 합니다.

이진 탐색 트리는 이러한 속성을 사용해 불필요한 확인 작업을 피할 수 있습니다. </br>
결과적으로, 조회, 삽입 및 삭제 작업의 평균 시간 복잡도는 `O(log n)`으로 배열이나 연결 리스트와 같은 선형 데이터 구조보다 훨씬 빠릅니다. </br>
</br>

## 💡 Case study : array vs BST
> 배열과 비교해보자 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/cb0eb750-1680-4bed-bd40-bf4dc9d2e9c7">

### 1. Lookup 

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/47b1435e-e523-43ad-b782-80b78a20b8d9"> </br>

정렬되지 않은 배열의 경우 처음부터 모든 요소를 확인해야 합니다. (linear search) </br>
따라서 배열의 array.contains(_:)는 `O(n)`의 시간 복잡도를 가지게 되고, 배열의 크기에 따라 시간 복잡도가 선형적으로 증가합니다. </br>


**이진 탐색 트리** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/c2bc0c50-0863-4120-9c3b-1cd6fb513ca8"> </br>

이진 탐색 트리는 노드 방문 시 다음 두가지의 성질을 지켜야 합니다. </br>

1. 검색 값이 현재 값보다 작을 경우, 왼쪽 하위 트리에 있어야 합니다.
2. 검색 값이 현재 값보다 클 경우, 오른쪽 하위 트리에 있어야 합니다.

BST의 성질을 활용하여 불필요한 확인 작업을 피하고, 결정을 내릴 때마다 검색 공간을 절반으로 줄일 수 있기 때문에 `O(log n)`의 시간 복잡도를 가집니다. </br>
</br>

### 2. Insertion 

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/d9ed325e-b23e-41d8-8ec5-2968089e28a8"> </br>

베열에서 값을 삽입할 경우, 이미 있는 공간에 끼어들듯이 동작하며, 추가 공간을 필요로 합니다. </br>

모든 요소가 한 자리씩 뒤로 밀려나게 되므로 `O(n)`의 시간 복잡도를 가집니다. </br>
</br>

**이진 탐색 트리** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/1eac899a-5ff2-4307-8bc6-d876531324e8">
</br>

이진 탐색 트리에서의 삽입은 모든 요소를 재배치할 필요가 없으므로 `O(log n)`의 시간 복잡도를 가지게 됩니다. </br>

</br>

### 3. Removal

**배열** </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/030a4855-3221-4ba3-8409-052d6e3a621c"> </br>

요소를 삽입할 경우와 동일하게 모든 요소들을 이동시키는 작업이 필요합니다. </br>
삭제된 요소 뒤에 있는 요소들은 앞으로 이동해 빈 자리를 메우게 됩니다. </br>

**이진 탐색 트리** 
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/457e8b25-4c47-4501-988f-bb94e4b1da22"> </br>

제거하려는 노드가 자식 노드를 가질 경우 복잡한 문제가 있음에도 불구하고, `O(log n)`의 시간 복잡도를 가집니다. </br>
</br>

## 💡 Implementation
> 구현 해보자 ! </br>

```swift
public struct BinarySearchTree<Element: Comparable> {

  public private(set) var root: BinaryNode<Element>?

  public init() {}
}

// nil이 아닐 경우 'root'를 문자열로 변환하여 반환
extension BinarySearchTree: CustomStringConvertible {

  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}
```
</br>

이진 탐색 트리는 Comparable 프로토콜을 준수하는 값만을 저장할 수 있습니다. </br>


### Inserting elements

### Finding elements

### Removing elements

## 💡 Key Points