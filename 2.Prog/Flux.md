# Flux
  - Reactive Stream
  - WebFlux

---


# Reactive Streams
- Observe Pattern을 개선하여, 주체(Subject: 훗날 Publisher)/관찰자(Observer: 훗날 Subscriber)의 표준을 정의한 Interface

## Interface
- Flow.Processor<T, R>
- FLow.Publisher<T>
  - void subscribe(Flow.Subscriber<? super T> subscriber)
- Flow.Subscriber<T>
  - void onComplete()
  - void onError(Throwable throwable)
  - void onNext(T item)
  - void onSubscribe(Flow.Subscription subscription)
- Flow.Subscription
  - void cancel()
  - void request(long n)

## Implements
- Reactive Stream의 구현체로 RxJava, Reactor, WebFlux 등이 있다.

## Ref
- https://www.reactive-streams.org/
- https://docs.oracle.com/javase/9/docs/api/java/util/concurrent/Flow.html

- https://www.youtube.com/watch?v=8fenTR3KOJo&list=PLOLeoJ50I1kkqC4FuEztT__3xKSfR2fpw&index=2

---


# WebFlux
- Spring 진영에서 Web에서 사용하기 용이한 형태로 Reactive Stream을 구현한 구현체
