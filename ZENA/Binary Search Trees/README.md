
# Binary Search Trees (BST)

이진 탐색 트리는 빠른 검색(lookup), 삽입, 삭제 처리를 용이하게 한다.
결정트리에서 한 쪽을 선택하면 반대쪽의 가능성은 없어져서 문제가 절반으로 줄어든다.
이를 이진 트리에 사용해 동일한 작업을 수행할 수 있다.
이진 탐색 트리는 이진 트리에 두 가지 규칙이 추가된다.

1. leftChildNode.value < parentNode.value
2. rightChildNode.value >= parentNode.value

이진 탐색 트리의 조회, 삽입 및 제거는 평균 O(log n)의 시간복잡도를 가지며, 선형 자료구조보다 빠르다.


## Case study: array vs BST

