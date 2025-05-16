# Flux
  - Reactive Stream
  - WebFlux

---

# Reactive Streams
- Observe Pattern을 개선하여, 주체(Subject: 훗날 Publisher)/관찰자(Observer: 훗날 Subscriber)의 표준을 정의한 Interface
- Observable <-> Publisher
- Observer <-> Subscriber

## Interface
- Flow.Processor<T, R>
- Flow.Publisher<T>
  - void subscribe(Flow.Subscriber<? super T> subscriber)
- Flow.Subscriber<T>
  - void onSubscribe(Flow.Subscription subscription)
  - void onNext(T item)
  - void onComplete()
  - void onError(Throwable throwable)
- Flow.Subscription
  - void request(long n)
  - void cancel()

## Implements
- Reactive Stream의 구현체로 RxJava, Reactor, WebFlux 등이 있다.

## Source Code
```
...
import java.util.concurrent.Flow.*;

public class PubSub {
    public static void main(String[] args){
        // onSubscribe onNext* (onError | onComplete)?
        Flow.Publisher p = new Flow.Publisher() {
            @Override
            public void subscribe(Flow.Subscriber subscriber){
                Iterator<Integer> it = Arrays.asList(1,2,3,4,5);

                subscriber.onSubscribe(new Subscription(){
                    @Override
                    public void request(long n){
                        try{
                            while(n-- > 0){
                                if (it.hasNext())
                                    subscriber.onNext(it.next());
                                else
                                    subscriber.onComplete();
                                    break;
                            }
                        } catch (Exception exception) {
                            subscriber.onError(exception);
                        }
                    }
                    
                    @Override
                    public void cancel(){
                    }
                });
            }
        };

        Flow.Subscriber<Integer> s = new Subscriber<Integer>(){
            Subscription subscription;

            int bufferSize = 2;
            int buffer = bufferSize;

            @Override
            public void onSubscribe(Flow.Subscription subscription){
                this.subscription = subscription;
                this.subscription.request(bufferSize);
            }

            @Override
            public void onNext(Integer item){
                System.out.println("onNext : " + item);
                if (--buffer <= 0){
                    buffer = bufferSize;
                    this.subscription.onNext(bufferSize);
                }
            }

            @Override
            public void onError(Throwable throwable){
                System.out.println("onError");
            }

            @Override
            public void onComplete(){
                System.out.println("onComplete");
            }
        };

        p.subscribe(s);
    }
}
```

## Ref
- https://www.reactive-streams.org/
- https://docs.oracle.com/javase/9/docs/api/java/util/concurrent/Flow.html

- https://www.youtube.com/watch?v=8fenTR3KOJo&list=PLOLeoJ50I1kkqC4FuEztT__3xKSfR2fpw&index=2


---

# WebFlux
- Spring 진영에서 Web에서 사용하기 용이한 형태로, Reactive Streams를 구현한 구현체

## Flux
- Reactive Streams의 Publisher를 구현한 구현체
