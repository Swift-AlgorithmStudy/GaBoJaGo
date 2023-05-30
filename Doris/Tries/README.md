# Tries 

트라이는 영어 단어와 같은 컬렉션 형태로 표현될 수 있는 데이터를 저장하는 데 특화된 트리입니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/35b4da86-75ce-45fe-a9c1-64f0ed4fa7e5">

</br>

각 문자는 노드와 매핑되어 있으며, 위의 다이어그램에서 점으로 표시된 마지막 노드는 종료 노드입니다. </br>
트라이의 장점은 주로 `접두사 일치(prefix matching)`의 문맥에서 잘 설명됩니다. </br>
접두사의 문자를 기반으로 트라이를 탐색함으로써 동일한 접두사를 공유하는 모든 문자열을 빠르게 찾을 수 있습니다. </br>
이는 `자동 완성, 철자 검사, 공통 접두사를 가진 단어 검색` 등과 같은 작업에 효율적입니다. </br>

트라이에서는 각 문자열의 문자가 트리의 노드와 연결됩니다. </br>
노드는 문자를 나타내며, 노드 사이의 간선은 문자 간의 연결을 나타냅니다. </br>

</br>

## Example 

```swift
class EnglishDictionary {

  private var words: [String]

  // words(matching:) 메서드는 문자열 컬렉션을 순회하고 접두사와 일치하는 문자열을 반환합니다.
  func words(matching prefix: String) -> [String] {
    words.filter { $0.hasPrefix(prefix) }
  }
}
```
</br>

이 알고리즘은 words 배열에 있는 요소의 수가 적을 경우 합리적입니다. </br>
그러나 수천 개 이상의 단어를 처리해야 한다면, words 배열을 순회하는 시간은 허용할 수 없을 정도로 오래 걸릴 것입니다. </br>
words(matching:)의 시간 복잡도는 `O(k*n)`입니다.</br> 여기서 k는 컬렉션에서 가장 긴 문자열의 길이이고, n은 확인해야 할 단어의 수입니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/6adfec40-b005-416e-a4d3-365eea2879a2"> </br>


트라이(Trie) 데이터 구조는 이 문제에 대해 우수한 성능 특성을 갖고 있습니다. </br> 
다중 자식을 지원하는 노드로 구성된 트리로, 각 노드는 하나의 문자를 나타낼 수 있습니다. </br>
</br>
루트에서 종료자(terminator)로 표시된 특수한 표식인 검은 점을 갖는 노드까지 문자열 컬렉션을 따라가면 단어가 형성됩니다.</br> 
트라이의 흥미로운 특성 중 하나는 여러 단어가 동일한 문자를 공유할 수 있다는 점입니다. </br>
</br>

트라이의 성능 이점을 설명하기 위해, CU 접두사를 가진 단어를 찾아야 하는 다음 예시를 고려해보겠습니다. </br>

먼저 C를 포함하는 노드로 이동합니다. 이렇게 하면 검색 작업에서 다른 트라이의 가지를 빠르게 배제할 수 있습니다.

</br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/62dba72b-acad-48f6-a0c2-2d44501c580d"></br>

그 다음으로 다음 글자 U를 가진 단어를 찾아야 합니다. U 노드로 이동합니다. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/a334ae96-3847-460a-89f7-9ce044a43acc"> 
</br>

해당 프리픽스를 찾기 위해 해당 트라이에서 U 노드부터 형성된 노드 체인의 모든 컬렉션을 반환합니다. </br> 
이 경우, 단어 CUT과 CUTE가 반환됩니다. </br>
수백만 개의 단어가 포함된 트라이라면 얼마나 많은 비교를 피할 수 있는지 상상해보세요. </br>

<img width="60%" height="60%" alt="image" src="https://github.com/GYURI-PARK/SwiftUI_Archive/assets/93391058/110a4569-de3a-4159-bd95-a1d52deaa000"> </br>

