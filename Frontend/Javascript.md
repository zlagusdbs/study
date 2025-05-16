# FrontEnd
- JavaScript
- Browser

---

# Javascript
## Execution Context(실행 컨텍스트)
- Javascript의 this, function, hoisting, closure, Scope 등의 동작원리를 담고 있는 핵심원리
- 실행 가능한 코드를 형상화하고 구분하는 추상적인 개념 -> 실행 가능한 코드가 실행되기 위해 필요한 환경(≒JRE)
  - 실행 가능한 코드란?
    - 전역코드: 전역제 존재하는 코드
    - Eval코드: eval 함수로 실행되는 코드
    - 함수코드: 함수 내에 존재하는 코드
      
  ![Execute Context](../Resource/Prog,%20JavaScript,%20SPA,%20execution%20context.pdf)
      
## prototype

## function
### literal(=코드상에 데이터를 표현하는 방식)
- 익명함수
~~~
// 함수를 정의하고 변수에 저장
var v = function(x,y) { return x+y; };

// 함수를 정의하고 바로 호출한다.
var added = (function(x,y) {return x+y;})(1,2);
~~~
  
- 함수선언식(Function Declaration)
~~~
say();  //hoisting 가능
function say(){
    console.log("hello world!");
}
~~~
  
- 함수표현식(Function Expression)
~~~
fncSay();   //hoisting 불가능
const fncSay = function(){
    console.log("hello world!");
}
~~~

### Lexical Scoping(렉시컬 스코프)
- 외부 -> 내부변수 접근 불가
- 내부 -> 외부변수 접근 가능
~~~
function outerFunction () {
  const outer = 'outer function!'
    
  function innerFunction() {
     const inner = 'inner function!'
     console.log(outer) // I’m the outer function!
  }
    
  console.log(inner) // Error, inner is not defined
}
~~~

## Regular Expression
- 정규표현식 
~~~
var regExNUM         = /[0-9]/;                                                 // 숫자
var regExNUM_8       = /^[0-9]{8}$/;                                            // 숫자8자
var regExNUM_13      = /^[0-9]{13}$/;                                           // 숫자13자
var regExNotNUM      = /[^0-9]/;                                                // !숫자
var regExKOR         = /[가-힣ㄱ-ㅎㅏ-ㅣ]/g;                                        // 한글 정규식
var regExENG         = /[a-zA-Z]/;                                              // 영문(대·소문자)
var regExSYM         = /([\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"])/;     // 특수문자
var regEx_whiteSpace = /\s/;                                                    // 공백
var regEx_password   = /^(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9])(?=.*[0-9]).{8,16}$/;  // 비밀번호 검사(영문,숫자,특수문자를 포함한 8~16자)

var regExCnsc_3rdKOR   = /([가-힣ㄱ-ㅎㅏ-ㅣ\x20])\1\1/;                                // 같은 한글 연속 3번 정규식
var regExCnsc_3rdENG   = /(\w)\1\1/;                                               // 같은 영문자&숫자 연속 3번 정규식
var regExCnsc_3rdSYM   = /([\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"])\1\1/;  // 같은 특수문자 연속 3번 정규식
var regExAdjcnt_3rdNum = /(012)|(123)|(234)|(345)|(456)|(567)|(678)|(789)/;        // 연속된 숫자 정규식

var regExHp         = /^\d{3,4}-\d{3,4}-\d{3,4}$/;                                 // 휴대전화번호 정규식(hypen)
var regNomalExHp    = /^\d{9,12}$/;                                                // 휴대전화번호 정규식
var regBirthDt      = /^\d{4}-\d{2}-\d{2}$/;                                       // 생년월일 정규식(hypen)
var regNomalBirthDt = /^\d{8}$/;                                                   // 생년월일 정규식
var regExEmail      = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z]?)*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z]?)*\.[a-zA-Z]{2,3}$/i;	//Email 정규식
~~~


---

# Browser
## Rendering
- phase1. HTML을 파싱하여 DOM요소와 스타일을 포함하여 RenderTree을 계산
- phase2. 계산된 RenderTree를 화면에 노출
    - phase2-1. Reflow: Render Tree에 대한 유효성 확인 작업과 Node의 크기/위치를 계산하는 작업
    - phase2-2. RePaint: Reflow가 발생하였을 때 화면에 다시 그리는 작업

### Reflow, Repaint 최소화
- 동일한 행태의 소스코드를 Group화하여 작업
- dispaly속성을 none으로 사용한 뒤, block으로 해제하고, 이 중간 코드에 style의 변경 코드를 넣어 대량으로 'reflow'가 발생하는 현상을 방지
- 가상노드 사용
    - SPA(React, VueJS등)의 가상DOM처럼, 가상 node를 만들어 교체하는 작업으로 최소화
    - parentNode.replaceChild(cloneNode, originNode);
