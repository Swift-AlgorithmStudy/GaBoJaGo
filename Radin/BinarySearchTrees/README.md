## 1. **이진탐색트리란?**

이진탐색트리 또는 BST는 빠른 조회, 삽입 및 제거 작업을 용이하게 하는 데이터 구조입니다.
이진탐색트리는 아래의 두 속성을 사용하여 불필요한 검사를 하지 않도록 합니다.

- 왼쪽 자식의 값은 부모의 값보다 작아야 합니다.
- 오른쪽 자녀의 값은 부모의 값보다 크거나 같아야 합니다.

> 결과적으로, 조회, 삽입 및 제거는 배열 및 연결된 목록과 같은 선형 데이터 구조보다 
상당히 빠른 `O(log n)`의 평균 시간 복잡도를 가지고 있습니다.
> 

## 2. Case study: array vs. BST

BST와 배열과의 성능을 비교해볼까요?

### 1) Lookup

**배열**

정렬되지 않은 배열에 대한 요소 조회를 하는 유일한 방법은 처음부터 배열의 모든 요소를 확인하는 것입니다.

array.contains(_:)는 `O(n)` 연산입니다.

**BST**

검색 알고리즘이 BST의 노드를 방문할 때마다 다음 두 가지를 지켜야합니다.

- 검색 값이 현재 값보다 작으면, 왼쪽 하위 트리에 있어야 합니다.
- 검색 값이 현재 값보다 크면, 올바른 하위 트리에 있어야 합니다.

BST의 규칙을 활용해 불필요한 검사를 피하고 결정을 내릴 때마다 검색 공간을 절반으로 줄일 수 있기 때문에 BST의 Lookup은 `O(log n)` 입니다.

### 2) Insert

**배열**

배열에 값을 삽입하는 것은 기존 행에 삽입하는 것과 같습니다. 당신이 선택한 자리 뒤에 줄을 선 모든 사람들은 뒤로 밀어서 새로운 공간을 만들어야 합니다.

배열 앞에 삽입한다면 다른 모든 요소가 한 위치만큼 뒤로 이동하기 때문에 배열에 삽입하는 시간 복잡도는 `O(n)`입니다.

**BST**

BST에 대한 규칙을 활용해 삽입 위치를 찾기 위해 log n의 횡단만 하면 되며, 주변의 모든 요소를 섞을 필요가 없습니다.

BST에 요소를 삽입하는 것은 `O(log n)` 작업입니다.

### 3) Removal

**배열**

요소를 삭제할 때도 삽입과 마찬가지로 배열에서 요소를 이동시키는 작업이 발생합니다.

줄의 중간에서 삭제된다면 뒤에 있는 모든 사람들이 앞으로 가서 빈 공간을 차지해야 합니다.

**BST**

제거하려는 노드에 자식이 있을 때 관리해야 할 복잡한 문제가 있음에도 불구하고, BST에서 요소를 제거하는 것은  `O(log n)` 작업입니다.

## 3. 구현

```swift
//BinarySearchTree.swift
public struct BinarySearchTree<Element: Comparable> {
  public private(set) var root: BinaryNode<Element>?
  public init() {}
}
```

정의에 따르면, 이진 검색 트리는 비교 가능한 값만 보유할 수 있습니다.

### Inserting elements

```swift
extension BinarySearchTree {
	//첫 번째 삽입 메서드는 사용자에게 노출되고 두 번째 삽입 메서드는 private로 사용됩니다
  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }

  private func insert(from node: BinaryNode<Element>?, value: Element)
      -> BinaryNode<Element> {
    //이것은 재귀적 방법이므로 재귀를 종료하기 위한 사례가 필요합니다. 현재 노드가 nil이면 삽입이 아닌 새 BinaryNode를 반환하면 됩니다
    guard let node = node else {
      return BinaryNode(value: value)
    }
    //if 문은 다음 삽입 호출이 통과할 방향을 제어합니다. 
		//새 값이 현재 값보다 작으면 왼쪽 자식에서 삽입을 호출합니다. 그렇지 않으면, 오른쪽 자식에 대한 삽입을 호출합니다.
    if value < node.value {
      node.leftChild = insert(from: node.leftChild, value: value)
    } else {
      node.rightChild = insert(from: node.rightChild, value: value)
    }
    // 3 현재 노드를 반환합니다.
    return node
  }
}
```

### Finding elements

균형 이진 검색 트리에서 O(log n) 연산입니다.

```swift
extension BinarySearchTree {
	public func contains(_ value: Element) -> Bool {
		// current를 루트 노드로 설정하는 것으로 시작
		var current = root
		// current가 nil이 아닐 때는 현재 노드의 값을 확인
		while let node = current {
		  // 값이 찾으려는 값과 같으면 true를 반환
		  if node.value == value {
		    return true
		  }
		  // 그렇지 않으면, 왼쪽 아이를 확인할 것인지 오른쪽 아이를 확인할 것인지 결정
		  if value < node.value {
		    current = node.leftChild
		  } else {
		    current = node.rightChild
		  }
		}
		return false
	}
}
```

### Removing elements

몇 가지 시나리오를 처리해야 하기 때문에 요소를 제거하는 것은 조금 까다롭습니다.

**Case1. Leaf node**
리프 노드를 제거하는 것은 간단합니다. 단순히 리프 노드를 분리하면 됩니다.

**Case2. Nodes with one child**
하나의 자식이 있는 노드를 제거할 때는 그 하나의 자식을 트리의 나머지 부분과 다시 연결하면 됩니다.

**Case 3. Nodes with two children**
두 자식이 있는 노드를 제거할 때, 제거한 노드를 오른쪽 하위 트리에서 가장 왼쪽 노드로 바꾸세요. 그리고 복사한 값인 리프 노드만 제거하면 됩니다.
새 노드가 오른쪽 하위 트리에서 가장 작았기 때문에, 오른쪽 하위 트리의 모든 노드는 여전히 새 노드보다 크거나 같을 것입니다. 그리고 새 노드가 오른쪽 하위 트리에서 왔기 때문에, 왼쪽 하위 트리의 모든 노드는 새 노드보다 작을 것입니다.

```swift
private extension BinaryNode { //재귀 min 속성을 추가하여 하위 트리에서 최소 노드를 찾습니다
  var min: BinaryNode {
    leftChild?.min ?? self
  }
}

extension BinarySearchTree {
  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }

  private func remove(node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element>? {
    guard let node = node else {
      return nil
    }
    if value == node.value {  //아래의 코드를 추가해 여러 제거 사례를 처리합니다.
      // more to come
    } else if value < node.value {
      node.leftChild = remove(node: node.leftChild, value: value)
    } else {
      node.rightChild = remove(node: node.rightChild, value: value)
    }
    return node
  }
}
```

```swift
// 노드가 리프 노드인 경우 단순히 0을 반환하여 현재 노드를 제거합니다.
if node.leftChild == nil && node.rightChild == nil {
  return nil
}
// 노드에 왼쪽 자식이 없으면 node.rightChild를 반환하여 오른쪽 하위 트리를 다시 연결합니다.
if node.leftChild == nil {
  return node.rightChild
}
// 노드에 오른쪽 자식이 없으면 node.leftChild를 반환하여 왼쪽 하위 트리를 다시 연결합니다.
if node.rightChild == nil {
  return node.leftChild
}
// 제거할 노드에 왼쪽 자식과 오른쪽 자식이 모두 있는 경우입니다. 
// 노드의 값을 오른쪽 하위 트리의 가장 작은 값으로 바꾼 다음 오른쪽 자식에서 제거를 호출하여 이 스왑된 값을 제거합니다.
node.value = node.rightChild!.min.value
node.rightChild = remove(node: node.rightChild, value: node.value)

```

## 🗝️ KeyPoints

- 이진 검색 트리는 정렬된 데이터를 보관하기 위한 강력한 데이터 구조입니다.
- 삽입, 제거 및 BST에 포함된 메서드의 시간 복잡도는 O(log n)입니다.
- 트리가 불균형 상태가 되면 성능이 O(n)로 저하됩니다.

### [이진탐색 더 알아보기](https://naver.me/xkqg83ea)

---

### **108. Convert Sorted Array to Binary Search Tree**

```swift
class Solution {
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        return make(nums, 0, nums.count - 1)
    }
    
    func make(_ nums: [Int], _ first: Int, _ last: Int) -> TreeNode? {
        guard first <= last else { return nil } //first가 last보다 큰 경우, nil반환

        var mid = (first + last) / 2
        
        var node = TreeNode(nums[mid]) //배열의 중간 인덱스 값으로 루트노드 초기화
        
        //트리만들기
        node.left = make(nums, first, mid - 1)
        node.right = make(nums, mid + 1, last)
        return node
    }
}
```

### **풀이**

주어진 배열을 가운데 값을 구해 왼쪽, 오른쪽 나누어 이진탐색트리 생성

### **653. Two Sum IV - Input is a BST**

```swift
class Solution {
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        return traverse(root, root, k)
    }
    func traverse(_ root: TreeNode?, _ node: TreeNode?, _ k: Int) -> Bool{
        guard let node = node else { return false }
        var key: Int = k - node.val
        if key != node.val && find(root, key) { // 현재 노드와 합이 k가 되는 값이 현재 노드와 같지 않고, 트리에서 해당 값을 찾는다면
            return true // 합이 k가 되는 두 노드가 존재하므로 true 반환
        }
        return traverse(root, node.left, k) || traverse(root, node.right, k) // 왼쪽 서브트리와 오른쪽 서브트리에서도 탐색 수행
    }
    
    func find(_ root:TreeNode?, _ key: Int) -> Bool{
        guard let root = root else {return false}
        
        if root.val == key { return true}
        else if root.val > key {
            return find(root.left, key)
        }
        else {
            return find(root.right, key)
        }
    }
}
```

### **700. Search in a Binary Search Tree**

```swift
class Solution {
    func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        guard let root = root else { return nil }
        if root.val == val { 
            return root 
        }
        else if root.val > val {
            return searchBST(root.left, val)
        }
        else {
            return searchBST(root.right, val)
        }
    }
}
```

### **풀이**

BST 규칙에 기반해서 풀었다. 
찾으려는 값이 루트 값보다 작으면 왼쪽으로 재귀 호출, 루트값보다 크면 오른쪽으로 재귀 호출

### **783. Minimum Distance Between BST Nodes**

```swift
class Solution {
    var prev: Int?
    var minimum = Int.max

    func minDiffInBST(_ root: TreeNode?) -> Int {
        guard let root = root else {return 0}
        inorder(root)
        return minimum
    }
    
    func inorder(_ root: TreeNode?) {
        guard let root = root else {return}
        
        inorder(root.left) //왼쪽 서브트리를 순회

        if let prev = prev { //현재 노드 값을 이전prev값과 비교하여 최소 차이를 업데이트

            minimum = min(minimum, root.val - prev)
        } 
        
        prev = root.val     //현재 노드 값을 이전(prev) 값으로 설정
        inorder(root.right) //오른쪽 서브트리를 순회
    }
}
```

### **풀이**

중위 순회를 사용해 BST에서 노드 값을 오름차순으로 순회합니다!

 왼쪽 서브트리를 순회한 후에 현재 노드와 이전 값의 차이를 계산하고, 현재 노드를 이전 값으로 업데이트한 후에 오른쪽 서브트리를 순회합니다. 이렇게 하면 BST의 모든 노드를 중위 순서로 방문해 최소 차이를 찾을 수 있습니다.

> 문제 이해를 바로 옆에 붙어있는 노드(부모자식간의 최소 차이)인 줄 알았다.
> 

### **897. Increasing Order Search Tree**

```swift
class Solution {
    var res = TreeNode(0)
    var cur: TreeNode?

    func increasingBST(_ root: TreeNode?) -> TreeNode? {
        guard let root = root else {return nil}
				// 재구성된 트리의 루트 노드를 설정하고 참조 변수를 초기화
        cur = res 
        dfs(root)
 
        return res.right
    }
    
		// 깊이 우선 탐색(DFS)을 통해 이진 트리를 증가 순서로 재구성
    func dfs(_ root: TreeNode?) {
        guard let root = root else {return}
        
				dfs(root.left)
        
				// 현재 노드의 왼쪽 자식을 nil로 설정하고, 재구성된 트리에 현재 노드를 연결
        root.left = nil
        cur!.right = root
        cur = cur!.right
        
        dfs(root.right)
    }
}
```

### **풀이**

dfs로 풀었다.
