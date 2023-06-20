# Heapsort

힙 정렬은 힙을 사용하여 배열을 오름차순으로 정렬하는 비교 알고리즘입니다. 

힙 정렬은 부분적으로 정렬된 이진 트리라고 정의된 힙을 활용합니다.

1. 최대 힙에서는 부모 노드가 자식보다 커야 합니다.
2. 최소 힙에서는 부모 노드가 자식보다 작아야 합니다.

<img width="438" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/8dce219a-3d99-4cb7-8e65-936b00cffa4b">


## Example

정렬되지 않은 배열을 오름차순으로 정렬하기 위해 힙 정렬은 이 배열을 최대 힙으로 변환해야 합니다.

<img width="522" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/ab880d53-0afc-41cc-b700-e20514ded9f4">

이 변환은 모든 부모 노드들을 내려가면서 올바른 자리에 도달하도록 합니다.

최대힙의 결과는 다음과 같습니다.

<img width="361" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/619e934c-de9d-49dc-b357-1155f0117375">


이를 배열로 표현하면 다음과 같습니다.

<img width="473" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/0fe8ebd8-9e76-48c1-92b4-034666661423">

한 번의 shift-down 연산의 시간 복잡도는 O(log n)이기 때문에, 힙을 만들기 위한 총 시간 복잡도는 O(n log n)입니다.

배열이 오름차순으로 정렬되었는지 확인해봅시다.

최대힙의 최대값은 루트에 있기 때문에 인덱스 0번째에 있는 첫 번째 요소와 인덱스 n-1에 있는 마지막 요소를 스왑해줍니다. 스왑을 한 후에, 배열의 마지막 요소는 올바른 위치에는 있지만 힙을 충족하지는 않습니다. 
그러므로 다음 단계에서는 루트에 있는 5가 올바른 위치에 올 때까지 sift down을 수행해줍니다.

<img width="426" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/0c859558-37b9-4a54-9ef9-94d35749490b">

힙의 마지막 요소는 힙의 일부가 아니라 정렬된 배열의 일부로 간주되기 때문에 제외해야 합니다.

5를 sifting down한 결과로 두 번째로 큰 요소인 21이 새로운 루트가 됩니다. 
21과 마지막 요소인 6을 스왑하고 6을 sifting down을 하는 이전 단계를 반복할 수 있습니다.

<img width="417" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/dd26a7dd-a3f7-466a-99bd-681d44845d0e">

이제 패턴이 보이십니까? 힙정렬은 매우 직관적입니다. 
처음과 마지막 요소를 스왑함으로써, 큰 요소들은 배열에 올바른 위치에 들어가게 됩니다.
힙의 크기가 1이 될 때까지 스왑과 sifting을 반복하면, 배열이 완전히 정렬됩니다.

<img width="354" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/b7b6e188-5669-4412-ad64-da2f8b860230">


## Implementation

정렬 알고리즘을 수행할 것인데, siftDown 메소드를 통해 값 옮기기를 진행했기 때문에 매우 간단합니다.

```swift
extension Heap {
  func sorted() -> [Element] {
    var heap = Heap(sort: sort, elements: elements) // 1
    for index in heap.elements.indices.reversed() { // 2
      heap.elements.swapAt(0, index) // 3
      heap.siftDown(from: 0, upTo: index) // 4
    }
    return heap.elements
  }
}
```

1. 힙의 복사본을 만듭니다. 힙 정렬로 배열을 정렬했다면, 더 이상 유효한 힙이 아닙니다. 
힙의 복사본에서 작업한다면, 힙이 유효할 것입니다.
2. 배열의 마지막 요소부터 시작하며 순회합니다.
3. 첫 번째 요소와 마지막 요소를 스왑합니다. 이는 정렬되지 않은 요소 중 가장 큰 값을 올바른 위치로 이동시켜줍니다.
4. 힙이 유효하지 않기 때문에, 새로운 루트 노드를 sift down해줘야 합니다. 결과적으로, 다음으로 가장 큰 요소는 새로운 루트가 됩니다.

```swift
let heap = Heap(sort: >, elements: [6, 12, 2, 26, 8, 18, 21, 9, 5])
print(heap.sorted()

[2, 5, 6, 8, 9, 12, 18, 21, 26]
```

## Performance

힙 정렬은 항상(최상, 평균, 최악) O(n log n)의 시간복잡도를 가집니다. 
이러한 성능에 대한 통일성은 리스트를 한 번 순회(n)해야 하고, 스왑할 때마다 sift down을 수행(log n)해야 하기 때문입니다.

힙 정렬은 요소들이 힙에 어떻게 정렬되어 있는지에 의존하기 때문에 불안정한 정렬입니다.

- 안정한 정렬 (stable sort) vs 불안정한 정렬(unstable sort)
    
    안정한 정렬
    
    - 중복된 값의 경우 입력 순서와 동일하게 유지해서 정렬하는 것
    
     <img width="352" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/6974f68a-676c-42b0-b137-9c5bbd552a8d">

    
    5의 위치가 바뀌지 않았음
    
    불안정한 정렬
    
    - 중복된 값을 입력 순서와 상관없이 무작위로 뒤섞인 상태에서 정렬이 이루어지는 것
    
    <img width="342" alt="image" src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/104834390/e2456260-50fb-48a5-99f4-642cf1783a58">

    
    5의 위치가 무작위로 선정되어 두 자리가 바뀜
    

## Key points

- 힙정렬은 배열의 요소를 정렬하기 위해 최대힙 자료 구조를 활용합니다.
- 힙정렬은 간단한 패턴을 통해 정렬합니다.
    1. 처음과 마지막 요소를 스왑합니다.
    2. 힙의 조건을 충족하기 위해 sift-down을 진행합니다. 
    3. 마지막에 있는 요소가 가장 큰 요소이기 때문에 배열의 크기를 1까지 줄입니다.
    4. 배열의 첫 부분에 올 때까지 해당 단계를 반복합니다.
