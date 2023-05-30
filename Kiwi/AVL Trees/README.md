# AVL Trees

Tree에서 균형은 아주 중요한 역할은 한다. 왜냐하면 탐색에 있어 균형이 맞는다면 O(log n)의 시간 복잡도를 가지게 되기 때문이다. 

## Understanding balance

- 완전 균형 상태 ( Perfect balance ) 

![](https://hackmd.io/_uploads/By9BPz7I2.png)

완벽하게 대칭적일 뿐만 아니라, 아래의 노드는 완전히 채워져야한다.

- 충분한 균형 상태 ( good-enough balance )

![](https://hackmd.io/_uploads/ryGwKGQU2.png)

가장 아래쪽 레벨을 제외하고 모든 레벨에서 노드가 가득 찬 상태

- 비 균형 상태 ( Unbalanced )

![](https://hackmd.io/_uploads/SymFKGXL2.png)

이진 검색 트리는 불균형의 정도에 따라 다양한 수준의 성능 손실을 겪는다.

## 구현

### AVLNode

```swift

class AVLNode<Element> {
    
    public var value: Element
    public var leftChild: AVLNode?
    public var rightChild: AVLNode?
    public var height = 0
    // 균형을 판단하는 기준이 된다.
    
    public var balanceFactor: Int {
        // 자식노드의 높이 차를 이용해서 unbalance 를 식별
        leftHeight - rightHeight
    }
    
    public var leftHeight: Int {
        // nil 이면 -1 이란 뜻은 자식 노드가 없는 곳의 높이를 -1 로 생각하라는 뜻
        leftChild?.height ?? -1
    }
    
    public var rightHeight: Int {
        rightChild?.height ?? -1
    }
    
    public init(value: Element) {
        self.value = value
    }
}

extension AVLNode {
    
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
    
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

```

>**Note❗️**
>
>*height*
>
>해당 노드부터 leaf 노드까지의 길이를 뜻한다.

![](https://hackmd.io/_uploads/BJCpaf7Ln.png)

>*balanceFactor*
>
> blance 상태는 heigt를 활용하여 balanceFactor를 통해 판별한다.

```swift

var balanceFactor: Int {
        leftHeight - rightHeight
    }

```

![](https://hackmd.io/_uploads/Hy9uB7mUh.png)


>어떤 노드의 balanceFactor 가 -2 or 2 를 가지면 unbalance 상태를 가지는 것이다.

### Rotations

```swift

 private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.rightChild!
        // pivot 은 '중심점' 을 뜻함.
        
        node.rightChild = pivot.leftChild
        // x 노드보단 크고 y(pivot) 노드 보단 작은 b 노드는 x노드의 오른쪽 노드가 된다.
        
        pivot.leftChild = node
        // pivot의 leftChild는 node가 된다.
        
        node.height = max(node.leftHeight, node.rightHeight) + 1 //height 수정
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        let pivot = node.leftChild!
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    

```

![](https://hackmd.io/_uploads/HkK9qm7Un.png)

```swift

private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else {
            return node // nil 이면 그냥 반환
        }
        node.rightChild = rightRotate(rightChild)
        // 먼저 오른 자식노드를 오른 회전 시킨 노드로 수정
        return leftRotate(node) // 최종 왼쪽 회전 시킨 노드를 반환
    }
    
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else {
            return node
        }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }

```

![](https://hackmd.io/_uploads/rkMsj7XU2.png)

### Balance

```swift

    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
    
        switch node.balanceFactor { .
        case 2:
            // 왼쪽 자식노드 쪽이 무거운 unbalance 트리.
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                // 양수 음수가 다르다면 다른쪽으로 꺾여있다는 뜻 그래서 두번 돌려주는 메서드를 호출
                return leftRightRotate(node)
            }else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rightLeftRotate(node)
            }else {
                return leftRotate(node)
            }
        default: 
            return node
        }
    }

```

### insert, remove

```swift

 private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value: value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }

private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }

```

