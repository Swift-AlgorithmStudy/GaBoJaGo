
지난 챕터에서 배운 이진 탐색 트리는 O(log n)의 시간복잡도를 가지나, 성능을 악화시키는 unbalanced tree라면 시간복잡도가 O(n)까지 떨어질 수 있다. 그래서 self-balancing binary search tree로 처음 고안된 것이 AVL Tree이다.

## Understanding balance

- **Perfect balance**
    
    이진 탐색 트리의 가장 이상적인 형태는 **perfectly balanced state**이다. 이는 트리가 완전 대칭이며, 최하위 계층까지 노드들이 완전히 채워져있는 형태이다.
    
    ![스크린샷 2023-05-26 오후 10.51.52.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4bec2c7c-7fcd-423b-9188-eeb148b54a6b/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.51.52.png)
    
- **“Good-enough” balance**
    
    완전 균형이 가장 이상적이나 이루기는 거의 불가능하다. 완전 균형 트리는 최하위층의 모든 노드를 채우기 위해 특정 개수의 노드가 필요하기 때문에 1, 3, 7개의 노드가 있다면 완전 균형을 이룰 수 있지만, 노드가 2, 4, 5, 6개라면 불가능하다.
    
    따라서 balanced tree는 **최하위층을 제외하고** 모든 레벨이 채워진 트리이다. 대부분의 이진 트리에서는 이것이 최선!
    
    ![스크린샷 2023-05-26 오후 10.59.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1ecad9a3-393f-431f-9146-e4ea253d27fb/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_10.59.04.png)
    
- **Unbalanced**
    
    이진 탐색 트리는 unbalanced state일 때 불균형 정도에 따라 성능 loss가 발생한다.
    
    ![스크린샷 2023-05-26 오후 11.01.11.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4f9f8be6-8772-497e-8b3c-6776b3eaa059/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.01.11.png)
    
    트리의 균형을 유지하는 것은 조회, 삽입, 삭제 operation의 시간복잡도를 O(log n)일 수 있도록 한다. AVL tree는 불균형해지는 트리의 구조를 조정함으로써 균형을 유지한다.
    

## Implementation

AVL과 Binary search tree의 구현 방식은 매우 비슷하며, AVL에는 balancing component가 추가된다.

### Measuring balnace

이진 트리를 균형있게 하려면 트리의 balance를 측정할 방법이 필요하다. AVL tree는 각 노드에 height 속성을 줌으로써 측정한다. 트리의 측면에서 노드의 height는 현재 노드에서 leaf 노드까지 가장 긴 거리를 의미한다.

![스크린샷 2023-05-26 오후 11.09.47.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/eaaa9f87-17f9-4199-8c46-2d72f066bea0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.09.47.png)

```swift
/* 
 * 자식 노드의 상대적인 height를 이용해 특정 노드가 균형이 맞는지 검사
 * 각 노드의 left, right child 자식의 height는 최대 차이는 1
 * 이를 균형 계수(balance factor)라 한다.
 */
public var height = 0

/* 
 * left, right child의 height 차이를 계산하는 속성
 * 어떤 자식 노드가 nil이라면 height는 -1로 처리
 */

public var balanceFactor: Int {
    leftHeight - rightHeight
}

public var leftHeight: Int {
    leftChild?.height ?? -1
}

public var rightHeight: Int {
    rightChild?.height ?? -1
}
```

![an example of an AVL tree](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/238a25bc-e2a1-40a7-82f7-3c17dd1bbbf6/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.19.21.png)

an example of an AVL tree

![**40**이라는 값의 노드 추가되면서 unbalanced](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/73c202f8-2c1b-4db2-8b4e-a46768ea6539/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.20.52.png)

**40**이라는 값의 노드 추가되면서 unbalanced

balanceFactor의 변화를 확인해보자. balanceFactor는 2, -2 또는 더 극단적으로 unbalanced tree임을 나타내는 값이다. 삽입 또는 삭제 후 이를 확인해줌으로써 정도가 2보다는 크지 않음을 보장할 수 있다.

비록 하나 이상의 노드가 나쁜 balanceFactor값을 가지나, 잘못된 balanceFactor값을 가지는 bottom-most node(25 노드)에 대해서만 균형을 맞추는 절차를 수행하면 된다.

### Rotations

이진 탐색 트리의 균형을 맞추는 절차이다. 트리가 unbalance해질 수 있는 네 개의 방향에 대한 네 방향에 대한 rotation이 있다. 

**Left Rotation 좌회전**

노드 40이 추가되면서 생긴 불균형은 left rotation으로 해결할 수 있다.

![Node X에 대한 좌회전 전후 example](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/50d5d88e-7c64-4baa-bb38-5facda4abcb5/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-26_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.29.48.png)

Node X에 대한 좌회전 전후 example

- 노드들을 전위 순회하는 것은 그대로 유지
- 로테이션 이후 트리 높이의 한 층이 제거된다.

코드로는 insert(from:value:) method를 AVL Tree에 추가한다.

```swift
private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    let pivot = node.rightChild!
    node.rightChild = pivot.leftChild
    pivot.leftChild = node
    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
    return pivot
}
```

left rotation을 수행하기 위한 단계

1. right child가 pivot으로 선택된다. 이 노드는 rotated node를 하위 subtree의 root로 대체해 한 레벨을 올려줄 것이다.
2. rotate되어야 하는 노드는 피봇의 left child가 되며 한 레벨 내려갈 것이다. 이는 위 그림의 node B이다. B는 Y보다 작지만 X보다는 크기 때문에 Y를 대신하여 X의 right child가 될 수 있기 때문이다. 따라서 rotated node의 right child를 pivot의 left child로 업데이트한다.
3. 피봇의 왼쪽 자식은 이제 rotated node로 설정한다.
4. rotated node와 pivot의 height를 업데이트한다.
5. 마지막으로, 피벗을 반환하여 트리에서 rotated node로 대체한다.

![25 노드에 대한 left rotation에 대한 example](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/db5dd951-9361-4818-84d8-e57342827753/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.33.08.png)

25 노드에 대한 left rotation에 대한 example

**Right Rotation 우회전**

좌회전과 대칭적으로 반대되는 것이 우회전이다. left children에 불균형이 발생했을 때 우회전을 수행한다.

![스크린샷 2023-05-29 오후 9.39.28.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fecaf355-629a-4b21-bfbf-977fc988a962/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.39.28.png)

```swift
// 코드는 이러하다 !

private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    
    let pivot = node.leftChild!
    node.leftChild = pivot.rightChild
    pivot.rightChild = node
    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
    return pivot
}
```

**Right-Left Rotation**

![Node 36이 추가된 예시](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/49d07460-2fc0-4964-8d22-b9023a2f0c5e/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.52.29.png)

Node 36이 추가된 예시

좌회전을 수행한다고 해도 균형잡힌 트리가 되지 않는다. 이런 경우는 좌회전 이전에 우회전을 먼저 수행해 해결해야 한다. 

![스크린샷 2023-05-29 오후 9.54.04.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ca73a849-be29-4422-9c1b-58c22f8c8fe0/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_9.54.04.png)

1. Node 37에 대해 우회전한다.
2. 노드 25, 36, 37은 모두 right children이다. 트리 균형을 맞추려면 좌회전을 적용하면 된다.

```swift
private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    
    gaurd let rightChild = node.rightChild else { return node }
    node.rightChild = rightRotate(rightChild)
    return leftRotate(node)
}
```

**Left-Right Rotation**

우회전과 마찬가지로 right-left rotation과 대칭적으로 반대된다.

![스크린샷 2023-05-29 오후 11.14.32.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1a87b698-b501-4859-8e0b-e8f1c4a906b4/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.14.32.png)

1. 노드 10에 대해 좌회전을 적용한다.
2. 그럼 이제 25, 15, 10의 노드들은 모두 left children이므로 우회전을 적용해 균형을 맞출 수 있다!

```swift
private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {

  guard let leftChild = node.leftChild else { return node }
  node.leftChild = leftRotate(leftChild)
  return rightRotate(node)
}
```

### Balance

다음으로 할 일은 balanceFactor로 노드의 균형을 맞춰줘야 할지 확인하는 메소드를 구현하는 일이다. 

```swift
private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {

  switch node.balanceFactor {
  case 2:
    // ...
  case -2:
    // ...
  default:
    return node
  }
}
```

고려해야 할 세가지 경우

1. balanceFactor가 2라는 것은 **왼**쪽 자식의 value **> 오른**쪽 자식의 value라는 것을 시사한다. 즉 우회전 또는 좌-우회전을 하고 싶을 것이다.
2. balanceFactor가 -2라는 것은 **오른**쪽 자식의 value **> 왼**쪽 자식의 value라는 것이다. 좌회전 또는 우-좌회전이 하고 싶을 것!
3. 디폴트 케이스는 노드가 균형잡혀 있음을 뜻한다. 아무것도 안하고 바로 노드를 반환하면 된다.

![balanceFactor의 값은 한 번 또는 두 번의 회전이 필요한지 결정하는데 사용된다. ](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/404e233a-ead3-4d3b-af3f-c2fc98aa3294/%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA_2023-05-29_%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE_11.26.27.png)

balanceFactor의 값은 한 번 또는 두 번의 회전이 필요한지 결정하는데 사용된다. 

```swift
private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {

  switch node.balanceFactor {
  case 2:
    if let leftChild = node.leftChild,
           leftChild.balanceFactor == -1 {
      return leftRightRotate(node)
    } else {
      return rightRotate(node)
    }
  case -2:
    if let rightChild = node.rightChild,
           rightChild.balanceFactor == 1 {
      return rightLeftRotate(node)
    } else {
      return leftRotate(node)
    }
  default:
    return node
  }
}
```

balanced()는 적절한 액션을 취할 때 결정하기 위해 balanceFactor를 검사한다. 남은 건 적절한 지점에 balanced() 부르기!

### Revisiting insertion

insert()를 수정하자

```swift
private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
  guard let node = node else { return AVLNode(value: value) }
  if value < node.value {
    node.leftChild = insert(from: node.leftChild, value: value)
  } else {
    node.rightChild = insert(from: node.rightChild, value: value)
  }
  let balancedNode = balanced(node)
  balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
  return balancedNode
}
```

추가한 다음에 노드를 바로 리턴하는 것이 아니라, balanced()를 거친 후에 반환하도록 하면 call stack의 모든 노드에 대한 밸런싱이 보장된다. 노드의 height도 매번 갱신해주면 된다.

## 🔑 Key Points

- self-balancing tree는 add 또는 remove할 때 밸런싱 과정을 거침으로 성능 저하를 피할 수 있다.
- AVL Tree는 트리가 더 이상 균형이 맞지않으면 일부를 readjusting함으로써 밸런스를 유지한다.
- Balance는 노드의 삽입, 삭제에 대해 네가지 타입의 회전으로 이룰 수 있다.
