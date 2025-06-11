# NoSQL Database
- MongoDB
- Redis
  - Bloom Filter
- Design Pattern

---

# Redis
## Bloom Filter
Redis에서 제공하는 확률적 자료구조(Probabilistic Data Structure)
특정 요소가 존재하는지 여부를 빠르고 메모리 효율적으로 검사를 할 수 있게한다.

- 특징
  - 시간복잡도 O(1)
  - False Positive 허용: "있다"는 결과는 틀릴 수 있다.
  - False Negative 없음: "없다"는 결과는 무조건 정확하다.
  - 단, Bloom Filter는 삭제를 지원하지 않는다. 이를 위해 **Counting Bloom Filter**모듈로 대체 가능하다.

- 사용
  - Cache 앞단에서 DB 조회를 최고화하려 할 때
  - 중복 요청 차단
  - 대량 데이터 중 존재 여부 확인

- 동작방식
  - 해시함수, 비트배열로 구성하여 동작
  - 데이터 "data"를 k개의 해시함수에 넣고, 각각 k개의 해시 코드에 대한 index를 비트배열에 Marking한다.
  - 비트배열에 Marking 된 내용이 전부 "1"이면 "존재", 일부만 "1"이면 "존재할 수 있음", 전부 "0"이면 "존재하지않음"으로 판단한다.

- 확률
  - False Positive 확률을 다음과 같이 높일 수 있다.
  > P(false positive) ≈ (1 - e^(-k * n / m))^k
  >> k: 해시 함수 수
  >> n: 삽입된 요소 수
  >> m: 비트 배열 크기(총 비트 수)
  >> e: 자연상수(2.71828...)

# Design Pattern
- Cache-Aside: Cache를 분리. 읽기 요청이 많은 경우에 적합
- Read-Through: Cache를 통해서 읽기
- Write-Through: Cache를 통해서 쓰기
- Write-Around: DB에만 쓰기
- Write-Behind: Cache만 저장
- Refresh Ahead: CAche를 미리
