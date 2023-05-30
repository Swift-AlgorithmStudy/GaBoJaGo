# AVL Trees 

AVL 트리는 자기 균형 이진 탐색 트리로서, 이진 탐색 트리의 **균형을 유지**하여 **탐색 성능을 최적화**하는데 사용됩니다. </br>
</br>

## Understancding balance
> 균형의 세 가지 주요 상태 이해하기 ! </br>

### 1. Perfect balance
> 완벽한 균형 상태 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/bbfce54d-fa80-43f6-9157-a007f2a09800">
</br>

* 완벽한 균형 상태는 이진 탐색 트리의 이상적인 형태입니다. 
* 기술적으로 말하면, 트리의 매 레벨마다 노드로 채워져 있는 상태를 의미합니다.
* 즉, 완벽한 균형 상태의 이진 탐색 트리는 뿌리 노드부터 시작하여 완전히 대칭적인 구조를 가지며, `가장 아래 레벨에 있는 모든 노드들이 채워져 있어야 합니다.`
* 이러한 구조는 최대한 모든 노드가 균등하게 분포되어 있음을 의미합니다.
* 완벽한 균형 상태는 이진 탐색 트리의 성능을 최적화하는 데 도움이 되며, 효율적인 탐색 및 삽입/삭제 연산을 가능하게 합니다.

</br>
</br>

### 2. "Good-enough" balance
> 균형 잡힌 트리 상태 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/380ffc66-fdfd-43eb-a989-b6fa99df27c2">
</br>

완벽한 균형 상태를 달성하는 것은 이상적이지만 실제로는 매우 드물게 발생합니다. </br>
에를 들어, 1개, 3개 또는 7개의 노드를 가진 트리는 완벽하게 군형 잡힌 상태일 수 있지만, 2개, 4개, 5개의 노드를 가진 트리는 마지막 레벨이 채워지지 않으므로 완벽하게 균형 잡힌 상태가 될 수 없습니다. </br>

* 균형 잡힌 트리는 맨 아래 레벨을 제외한 모든 레벨이 가득 차 있어야 합니다. 
* 즉, 모든 레벨이 가득 차 있지 않더라도 균형 잡힌 트리로 간주됩니다.
* 균형 잡힌 트리 상태에서는 모든 레벨이 가득 차 있지는 않지만, 트리의 균형을 유지하여 효율적인 탐색 및 삽입/삭제 연산을 수행할 수 있습니다.

</br>
</br>

### 3. Unbalanced
> 균형이 맞지 않는 상태 ! </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/a8bed3a7-cf49-4edc-bc49-c524a4b7a15f">
</br>

* 이진 탐색 트리가 균형이 맞지 않은 상태일 때는 균형이 맞지 않음의 정도에 따라 다양한 수준의 성능 손실이 발생합니다.
* 트리가 균형을 유지한다면 find, insert, remove 연산에서 O(log n)의 시간복잡도를 가지게 됩니다.

즉, 균형이 맞지 않은 상태에 있는 이진 탐색 트리는 성능 손실이 발생하며, 트리의 균형을 유지함으로써 O(log n)의 시간 복잡도를 유지할 수 있는 AVL 트리를 사용하는 것이 중요합니다.
</br>
</br>

## Implementation

### Measuring balance

이진 트리를 균형잡힌 상태로 유지하기 위해서는 트리의 균형을 측정할 수 있는 방법이 필요합니다. </br>
AVL 트리는 각 노드마다 높이(height) 속성을 이용해 균형을 유지합니다. </br>
트리에서 **노드의 높이**란 `현재 노드부터 리프 노드까지의 가장 긴 거리`를 의미합니다. </br> 

```swift
public var height = 0
```
</br>

특정 노드가 균형이 잡혀 있는지 확인하기 위해 `노드의 자식들의 상대적인 높이(relative height of a node’s children)`를 사용합니다. </br>
이 숫자를 `균형 인수(balance factor)`라고 합니다. </br>

```swift
// 균형 인수는 왼쪽 자식과 오른쪽 자식의 높이 차이를 계산합니다.
public var balanceFactor: Int {
	leftHeight - rightHeight
}
// 특정 자식이 nil일 경우 해당 자식의 높이는 -1로 간주합니다.
public var leftHeight: Int {
	leftChild?.height ?? -1
}
public var rightHeight: Int {
	rightChild?.height ?? -1
}
```
</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/cb41167d-f0e7-41ca-95e6-55b63de8ec96">
</br>

위의 다이어그램은 균형 잡힌 트리를 나타냅니다. </br>
맨 아래 레벨을 제외한 모든 레벨이 채워져 있습니다. </br> 노드 오른쪽에 있는 숫자는 `각 노드의 높이`를 나타내고, 왼쪽에 있는 숫자는 `balanceFactor`를 나타냅니다. </br>
다음은 40이 삽입된 업데이트된 다이어그램입니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/1c353e2e-8c54-4b69-b673-bfcdd1e11ca6">
</br>

40를 트리에 삽입하면 Unbalanced tree가 됩니다. </br>
balanceFactor가 2, -2 또는 그 이상의 값은 균형이 맞지 않은 트리를 나타냅니다. </br>
`즉, AVL Tree에서 balanceFactor의 절대값은 2를 넘지 않습니다.` </br>
하지만 각 삽입 또는 삭제 후에 확인함으로써, 균형이 더 이상 2의 절댓값보다 크게 되지 않도록 보장할 수 있습니다. </br> 한 개 이상의 노드가 잘못된 균형 인수를 가질 수 있지만, 균형 조정 절차는 균형 인수가 잘못된 가장 하위 노드인 25를 포함하는 노드에서만 수행하면 됩니다. 
</br>
여기서 회전이 필요합니다. </br>

### Rotations

### Balance

### Revisiting insertion

### Revisiting remove

## KEY POINTS

* AVL 트리는 트리가 균형을 유지하지 못하는 경우 트리의 일부를 재조정하여 균형을 유지합니다.

* 균형은 노드 삽입 및 삭제시에 발생하는 네 가지 유형의 트리 회전에 의해 달성됩니다.

1. 좌-좌 (LL) 회전
2. 우-우 (RR) 회전
3. 좌-우 (LR) 회전
4. 우-좌 (RL) 회전

**AVL 트리의 특징** </br>

1. `이진 탐색 트리`의 속성을 가집니다.
2. 왼쪽, 오른쪽 서브 트리의 높이 차이가 `최대 1`입니다.
3. 높이 차이가 1보다 커지면 `회전(rotation)`을 통해 균형을 맞춰 높이 차이를 줄입니다.
4. 삽입, 검색, 삭제의 시간 복잡도가 `O(log N)`입니다.