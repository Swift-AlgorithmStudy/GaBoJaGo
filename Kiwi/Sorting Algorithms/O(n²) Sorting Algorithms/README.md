# O(n²) Sorting Algorithms

버블 정렬, 선택 정렬, 삽입 정렬은 시간 복잡도가 O(n²)로 성능이 좋지 않지만, 공간 복잡도가 좋은 편이다. 이러한 정렬 알고리즘들은 상수 O(1)의 추가 메모리 공간만 필요로 하기 때문에, 메모리 사용량이 매우 작다.

이러한 알고리즘들은 작은 데이터셋의 정렬에 특히 유용하다. 작은 데이터셋의 경우, 입력 크기가 작기 때문에 알고리즘의 성능 저하가 크게 나타나지 않는다. 동시에, 메모리 사용량도 크게 증가하지 않아 유리한 면을 가진다. 따라서 작은 규모의 정렬 작업이나 간단한 상황에서 이러한 알고리즘들은 유용하게 사용될 수 있다.

## Bubble sort


버블 정렬은 가장 간단한 정렬 알고리즘 중 하나로, 인접한 값들을 반복적으로 비교하고 필요한 경우에는 위치를 교환하여 정렬을 수행한다. 이렇게 하면 집합 내에서 더 큰 값들이 "올라가서"(bubble up) 컬렉션의 끝으로 이동하게 된다.

다음과 같은 카드 패가 있다고 가정해보자:
![](https://hackmd.io/_uploads/ryTd00ZDn.png)

버블 정렬 알고리즘의 단일 패스는 다음 단계들로 구성된다:

- 배열의 앞 두 요소 9와 4를 비교한다. 9가 4보다 큰 수기 때문에 이 값들은 교환되어야 한다. 컬렉션은 [4, 9, 10, 3]이 된다.

- 이후 9와 10을 비교한다. 이들은 이미 정렬된 상태이다.

- 10과 3을 비교한다. 컬렉션은 [4, 9, 3, 10]이 된다.

- 이러한 방식으로 연속된 두 수를 비교하여 정렬시킨다.

## Selection sort

선택 정렬(Selection Sort)은 간단하면서도 효과적인 정렬 알고리즘이다. 선택 정렬은 주어진 배열에서 최솟값을 선택하여 정렬된 부분과 교환하는 과정을 반복하여 정렬을 수행한다. 다음은 선택 정렬의 동작 방식을 단계별로 설명한 것이다:

- 주어진 배열에서 정렬되지 않은 부분을 선택한다. 초기에는 전체 배열이 정렬되지 않은 상태로 시작한다.

- 선택된 정렬되지 않은 부분에서 가장 작은 값을 찾는다. 이를 최솟값으로 간주한다.

- 최솟값을 선택된 정렬되지 않은 부분의 첫 번째 요소와 교환한다. 이를 통해 최솟값이 정렬된 부분의 맨 앞으로 이동하게 된다.

- 그다음 작은수를 두번째 인덱스 값과 교환한다.

- 정렬되지 않은 부분이 없어질 때까지 위의 과정을 반복한다.

## Insertion sort

삽입 정렬은 간단하고 직관적인 정렬 알고리즘 중 하나이다. 데이터를 하나씩 적절한 위치에 삽입하여 정렬하는 방식으로 동작한다. 다음과 같은 단계로 이루어진다:

- 정렬되지 않은 부분의 첫 번째 요소를 선택한다. 이 요소는 이미 정렬된 부분의 마지막 요소로 간주된다.

- 선택한 요소를 이미 정렬된 부분의 올바른 위치에 삽입한다. 정렬된 부분에서 선택한 요소보다 큰 값들을 오른쪽으로 한 칸씩 이동시키고, 선택한 요소를 적절한 위치에 삽입한다.

- 정렬되지 않은 부분의 다음 요소를 선택하고, 위의 단계를 반복한다. 정렬되지 않은 부분이 없을 때까지 계속한다.

- 이러한 과정을 통해 정렬되지 않은 부분의 요소들을 하나씩 정렬된 부분에 삽입하여 전체 데이터를 정렬한다.

삽입 정렬은 비교적 작은 데이터셋에 대해서는 성능이 좋다. 이미 정렬되어 있는 경우에는 최선의 시간 복잡도인 O(n)을 가진다. 그러나 정렬되지 않은 데이터셋에 대해서는 평균적으로 O(n²)의 시간 복잡도를 가지므로, 큰 데이터셋에 대해서는 다른 효율적인 정렬 알고리즘보다 느릴 수 있다.

## 구현


### Bubble sort

```swift

func bubbleSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  // 1
  guard array.count >= 2 else {
    return
  }
  // 2
  for end in (1..<array.count).reversed() {
    var swapped = false
    // 3
    for current in 0..<end {
      if array[current] > array[current + 1] {
        array.swapAt(current, current + 1)
        swapped = true
      }
    }
    // 4
    if !swapped {
      return
    }
  }
}

/*
1. 배열의 길이가 2 이상인지 확인합니다. 만약 2보다 작다면 이미 정렬되어 있는 상태이므로 정렬을 수행할 필요가 없기 때문에 함수를 종료합니다.

2. 정렬의 마지막 위치(end)부터 시작하여 첫 번째 위치까지 반복합니다. 이는 정렬의 각 패스에서 가장 큰 값이 컬렉션의 끝으로 "올라가는(bubble up)" 과정을 수행하기 위한 반복문입니다.

3. 현재 위치(current)를 0부터 end까지 반복합니다. 이 반복문에서는 현재 위치와 다음 위치의 값을 비교하여 정렬이 필요한 경우 위치를 교환합니다. 비교 후 값이 교환되면 swapped 변수를 true로 설정합니다.

4. 내부 반복문이 종료된 후, 만약 swapped 변수가 false인 경우, 즉 정렬 중 교환이 발생하지 않은 경우에는 이미 정렬이 완료되었으므로 함수를 종료합니다.
*/

```

### Selection sort

```swift

func selectionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  guard array.count >= 2 else {
    return
  }
  // 1
  for current in 0..<(array.count - 1) {
    var lowest = current
    // 2
    for other in (current + 1)..<array.count {
      if array[lowest] > array[other] {
        lowest = other
      }
    }
    // 3
    if lowest != current {
      array.swapAt(lowest, current)
    }
  }
}

/*
1.배열의 크기가 2 이상인지 확인합니다. 2보다 작다면 정렬할 필요가 없으므로 함수를 종료합니다.

2.현재 위치를 나타내는 current 변수를 사용하여 배열을 반복합니다. current는 정렬된 부분과 정렬되지 않은 부분의 경계를 나타냅니다.

3.current 위치부터 배열의 끝까지를 탐색하면서 가장 작은 값을 찾습니다. 작은 값이 발견되면 lowest 변수에 해당 위치를 저장합니다.

4.내부 반복문이 끝나면 현재 위치(current)와 가장 작은 값의 위치(lowest)를 비교합니다. 만약 두 값이 다르다면, 가장 작은 값과 현재 위치의 값을 교환합니다.

5.반복문이 끝나면 배열이 정렬되어 있습니다.
*/

```

## Insertion sort

```swift

func insertionSort<Element>(_ array: inout [Element])
    where Element: Comparable {
  guard array.count >= 2 else {
    return
  }
  // 1
  for current in 1..<array.count {
    // 2
    for shifting in (1...current).reversed() {
      // 3
      if array[shifting] < array[shifting - 1] {
        array.swapAt(shifting, shifting - 1)
      } else {
        break
      }
    }
  }
}

/*
1.배열의 크기가 2 이상인지 확인합니다. 2보다 작다면 정렬할 필요가 없으므로 함수를 종료합니다.

2.두 번째 요소부터 배열을 순회합니다. current 변수는 현재 삽입할 요소의 인덱스를 나타냅니다.

3.현재 삽입할 요소를 이미 정렬된 부분의 올바른 위치에 삽입하기 위해 역순으로 배열을 순회합니다. shifting 변수는 삽입할 요소를 이동시킬 인덱스를 나타냅니다.

4.현재 요소를 정렬된 부분의 요소와 비교하여 정렬 순서가 맞지 않으면 두 요소를 교환합니다. 그렇지 않으면 반복문을 종료합니다.

5.내부 반복문이 종료되면 현재 요소가 올바른 위치에 삽입되었습니다.

6.외부 반복문을 통해 모든 요소가 정렬될 때까지 위의 과정을 반복합니다.
*/

```
