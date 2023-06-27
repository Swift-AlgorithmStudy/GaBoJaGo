# Chap18. Breadth-First Search

그래프의 정점을 가로지르거나 검색하기 위한 몇 가지 알고리즘이 존재한다. 그러한 알고리즘 중 하나는 너비 우선 탐색(BFS) 알고리즘이다.

**BFS의 활용**

- 최소 비용 신장 트리 생성
- 정점 사이의 가능한 경로 찾기
- 두 정점 사이의 최단 경로 찾기

## 예시

BFS는 그래프에서 임의의 정점을 선택하여 시작합니다. 알고리즘은 이 정점의 모든 이웃을 탐색한 후 해당 이웃들의 이웃을 탐색하고 이와 같은 과정을 반복합니다. 이 알고리즘은 너비 우선 접근을 취합니다.

다음 무방향 그래프를 사용하여 BFS 예제를 살펴보겠습니다.


<img src="https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/d12ade1b-90af-4182-94d2-f5fa7dcd88bc" width="300">
<br></br>

<aside>
👀 참고: 강조 표시된 정점은 방문한 정점을 나타냅니다.
</aside>
<br></br>

다음에 방문할 정점을 추적하기 위해 큐를 사용할 것입니다. 큐의 선입선출 접근 방식은 한 단계 더 깊이를 통과하기 전에 모든 정점의 이웃을 방문하도록 보장합니다.

![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/840a7ffd-5b98-4369-b6ca-d958acca1fd1)

1. 시작하려면, 시작할 소스 정점을 선택하세요. 여기서, 당신은 대기열에 추가된 A를 선택했습니다.
2. 대기열이 비어 있지 않은 한, 당신은 대기열을 해제하고 다음 정점을 방문합니다. 이 경우 A. 다음으로, A의 모든 인접 정점 [B, D, C]을 대기열에 추가합니다.
    
    <aside>
    👀 참고: 아직 방문되지 않았고 아직 대기열에 있지 않을 때만 대기열에 정점을 추가하는 것이 중요합니다.
    
    </aside>
    
    ![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/b8f046be-2d55-40f6-ba47-8d5df5c41685)
    
3. 대기열이 비어 있지 않으므로, 대기열을 해제하고 다음 정점인 B를 방문하세요. 그런 다음 B의 이웃 E를 대기열에 추가하세요. A는 이미 방문했기 때문에, 추가되지 않는다. 대기열에는 이제 [D, C, E]가 있다.
4. 다음 정점은 D이다. D는 방문하지 않은 이웃이 없다. 대기열에는 이제 [C, E]가 있다.
    
    ![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/af3efce0-4d6b-4ba3-b254-57ed84d07b90)
    

1. 다음으로, C의 대기열을 해제하고 이웃 [F, G]를 대기열에 추가합니다. 대기열에는 이제 [E, F, G]가 있다.
당신은 이제 A의 모든 이웃을 방문했다는 것을 알아두세요! BFS는 이제 이웃의 두 번째 단계로 이동한다.
2. E를 대기열에서 빼고 대기열에 H를 추가하세요. 대기열에는 이제 [F, G, H]가 있다. B가 이미 방문되었고 F가 이미 대기열에 있기 때문에 B 또는 F를 대기열에 추가하지 않습니다.
    
    ![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/14af9dff-f599-4ce2-9227-047448c1d9b9)
    
3. 당신은 F를 대기열에서 제거했고, 모든 이웃이 이미 대기열에 있거나 방문했기 때문에, 대기열에 아무것도 추가하지 않습니다.
4. 이전 단계와 마찬가지로, 당신은 G를 대기열에서 빼고 대기열에 아무것도 추가하지 않습니다.
    
    ![image](https://github.com/Swift-AlgorithmStudy/GaBoJaGo/assets/100195563/f7fa9039-c632-4246-b496-81d81e99c248)
    
5. 마지막으로, 당신은 H를 뺍니다. 대기열이 이제 비어 있기 때문에 폭 우선 검색이 완료되었습니다!
6. 정점을 탐색할 때, 각 레벨의 정점을 보여주는 나무와 같은 구조를 구성할 수 있습니다: 먼저 당신이 시작한 정점, 그 다음에는 이웃, 그 다음에는 이웃의 이웃 등.

## 구현

이전 장에서 만든 그래프의 구현이 포함되어 있습니다. 또한 BFS를 구현하는 데 사용할 스택 기반의 큐 구현도 포함되어 있습니다. 그래프 코드 아래에 추가하세요:

```swift
extension Graph where Element: Hashable {
  func breadthFirstSearch(from source: Vertex<Element>) -> [Vertex<Element>] {
    var queue = QueueStack<Vertex<Element>>() // 1
    var enqueued: Set<Vertex<Element>> = [] // 2
    var visited: [Vertex<Element>] = [] // 3

    queue.enqueue(source) // 4
		enqueued.insert(source)
		
		while let vertex = queue.dequeue() { // 5
		  visited.append(vertex) // 6
		  let neighborEdges = edges(from: vertex) // 7
		  neighborEdges.forEach { edge in
		    if !enqueued.contains(edge.destination) { // 8
		      queue.enqueue(edge.destination)
		      enqueued.insert(edge.destination)
		    }
		  }
		}
    return visited
  }
}
```

여기서, 세 가지 데이터 구조를 사용하는 메서드 breadthFirstSearch(from:)를 정의했습니다. 

1. queue는 다음에 방문할 이웃 정점을 추적한다.
2. enqueued는 이전에 큐에 있던 정점을 기억하므로, 같은 정점을 두 번 큐에 띄지 않습니다. 
여기서 Set 타입을 사용하면 조회가 저렴하고 O(1)만 사용할 수 있습니다.
3. visited는 정점이 탐험된 순서를 저장하는 배열이다.
4. 먼저 source 정점을 enqueue(삽입)하여 BFS 알고리즘을 시작합니다.
5. 큐가 비어 있을 때까지 큐에서 정점을 계속 제거합니다.
6. 정점을 큐에서 제외할 때마다, 방문한 정점 목록에 추가합니다.
7. 그런 다음, 현재 정점에서 시작하여 반복되는 모든 가장자리를 찾습니다.
8. 각 가장자리에 대해, 대상 정점이 이전에 매겨졌는지 확인하고, 그렇지 않은 경우 코드에 추가합니다.

이웃 정점(neighboring vertices)에서 명심해야 할 한 가지는 방문하는 순서가 그래프를 어떻게 구성하느냐에 따라 결정된다는 것입니다. A와 B 사이에 하나를 추가하기 전에 A와 C 사이에 가장자리를 추가할 수 있었습니다. 이 경우, 출력은 B 앞에 C를 나열할 것이다.

## 성능

BFS를 사용하여 그래프를 횡단할 때, 각 정점은 한 번 매겨진다. 이 과정은 O(V)의 시간 복잡성을 가지고 있다. 이 횡단 동안, 당신은 또한 모든 가장자리를 방문합니다. 모든 가장자리를 방문하는 데 걸리는 시간은 O(E)이다. 이 둘을 함께 추가하면 폭 우선 검색의 전체 시간 복잡성이 O(V + E)라는 것을 의미합니다.

queue, enqueued 및 visited의 세 가지 개별 구조에 정점을 저장해야 하기 때문에 BFS의 공간 복잡성은 O(V)입니다.

## 🗝️ Key points

- 너비 우선 탐색(BFS)은 그래프를 가로지르거나 검색하는 알고리즘이다.
- BFS는 다음 단계의 정점을 통과하기 전에 현재 정점의 모든 이웃을 탐구한다.
- 그래프 구조에 인접한 정점이 많거나 가능한 모든 결과를 찾아야 할 때 일반적으로 이 알고리즘을 사용하는 것이 좋습니다.
- 큐 데이터 구조는 더 깊은 단계로 내려가기 전에 정점의 가장자리를 가로지르는 것을 우선시하는 데 사용됩니다.
