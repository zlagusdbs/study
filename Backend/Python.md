# Python
  - Python
  - DJango
  - Flask

---

# Python[Python]([https://docs.python.org/ko/3/](https://docs.python.org/ko/3/)]

## Python 이란?

## Grammar
### 자료형
#### 기본자료형
    - 숫자
        - 정수[ int ]
        - 실수[ float ]
        - 지수, 8진수, 16진수 등
    - 문자열
    - boolean

#### 자료구조
    - 변수
    - 리스트
    - 튜플
    - 딕셔너리
    - 집합

---
# DJango

## DJango 란?

## Model Layer
### Model
#### Introduction to models
  - Relationships
    |  Seq  -|  Relation                                       |  Question  |  QuestionAndChoice  |  Choice  |  Describe                                          |
    |--------|-------------------------------------------------|------------|---------------------|----------|----------------------------------------------------|
    |  No.1  |  One To One                                     |      1     |          -          |     1    |  Question과 Choice가 반드시 하나씩 매핑 되어야 할 때  |
    |  No.2  |  One To Many(ForeignKey)                        |      1     |          -          |     N    |  Question하나에 Choice가 여러개 매핑 되어야 할 때     |
    |  No.3  |  Many To Many[중개모델(Intermediary Model)필요]  |      N     |        1 / 1        |     N    |  QuestionAndChoice를 하나 두고 QuestionAndChoice에서 Question과 Choice를 각각 Many To One으로 연결  |

    - JOIN 방법
      - Foreign Key가 Not Null인 경우에는 INNER JOIN으로, Null인 경우에는 LEFT OUTER JOIN으로 쿼리를 생성
      - No.1
        - 첫번째: Question을 기준으로 Choice
          > Question.objects.select_related('choice')
      - No.2(3가지 방법으로 조인 가능)
        - 첫번째: Choice를 기준으로 Question(Many To One)
          > Choice.objects.select_related('question')
        - 두번째: Question을 기준으로 Choice(One To One)
          > Question.objects.prefetch_related('choice')
          > Question.objects.annotate(choice_id=F('choice__id'), choice_text=F('choice__choice_text'), votes=F('choice__votes')).annotate(Count('id'))

#### Field Type
##### Field Type
  - AutoField
  - BigAutoField
  - ImageField
  - TieField

##### Field Option
  - null
  - blank
  - choices
  - db_column
  - db_index
  - db_tablespace
  - default

#### Indexes
#### Meta options
#### Model class

### QuerySets
#### Making queries
#### QuerySet method reference
  - QuerySet API
    - get()
    - all()
    - filter(**kwargs)
    - exclude(**kwargs)
    - annotate(*args, **kwargs)
      - Query Expression을 사용하여 각 객체에 조건을 추가.

    - 참고사이트: [https://docs.djangoproject.com/en/3.2/ref/models/querysets/#queryset-api](https://docs.djangoproject.com/en/3.2/ref/models/querysets/#queryset-api)
    - 참고사이트: [https://velog.io/@magnoliarfsit/ReDjango-8.-QuerySet-Method-2](https://velog.io/@magnoliarfsit/ReDjango-8.-QuerySet-Method-2)

  - Field lookups
    - 참고사이트: [https://docs.djangoproject.com/en/3.2/ref/models/querysets/#field-lookups](https://docs.djangoproject.com/en/3.2/ref/models/querysets/#field-lookups)

  - Q() objects

#### Lookup expressions
  - Query Expression API
    - 클래스가 SQL 식으로 변환하기 위해 쿼리식에서 사용할 수 있도록 정의하는 일반적인 메서드 집합
    - 종류
      - as_sql(compiler, connection)
      - as_vendorname(compiler, connection)
      - get_lookup(lookup_name)
      - get_transform(transform_name)
      - output_field

### Model Instance

### Migration

### Advanced
#### Query Expressions
  - F() expressions

### Other

