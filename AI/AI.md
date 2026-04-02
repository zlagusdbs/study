# Overview
인공지능(AI, Artificial Intelligence)은 인간의 학습, 추론, 지각 능력 등을 컴퓨터 프로그램으로 구현하여 기계가 사람처럼 생각하고 행동하게 만드는 기술
데이터를 기반으로 스스로 학습(머신러닝/딥러닝)하여 문제를 해결하고, 창의적인 콘텐츠 생성, 언어 이해, 영상 인식 등 다양한 분야에서 활용

# AI Hierarchy
```text
┌───────────────────────────────────────────────────┐
│            AI(Artificial Intelligence)            │
│                                                   │
│  ┌─────────────────────────────────────────────┐  │
│  │             ML(Machine Learning)            │  │
│  │                                             │  │
│  │  ┌───────────────────────────────────────┐  │  │
│  │  │            DL(Deep Learning)          │  │  │
│  │  │                                       │  │  │
│  │  │  ┌─────────────────────────────────┐  │  │  │
│  │  │  │      GEN AI(Generative AI)      │  │  │  │
│  │  │  │                                 │  │  │  │
│  │  │  │  ┌───────────────────────────┐  │  │  │  │
│  │  │  │  │ LLM(Large Language Model) │  │  │  │  │
│  │  │  │  │                           │  │  │  │  │
│  │  │  │  │                           │  │  │  │  │
│  │  │  │  └───────────────────────────┘  │  │  │  │
│  │  │  └─────────────────────────────────┘  │  │  │
│  │  └───────────────────────────────────────┘  │  │
│  └─────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────┘
```

## LLM
LLM은 언어의 입력과 출력이 가능한 딥러닝 모델
LLM은 'Transformer Architecture'로 구현하며, 'Transformer Architecture'는 Attention 메커니즘을 근간으로 한다.

> Google Brain (2017). Attention Is All You Need

### Transformer
Transformer는 Attention 메커니즘을 근간으로 하며, Encoder와 Decoder를 구성하고 있다.
  - Encoder: 입력을 이해하는 부분(대표: BERT)
  - Decoder: 언어를 생성하는 부분(대표: GPT)
```text
   ENCODER (×n)                             DECODER (×n)

    Sources                                  Targets
       │                                        │
       ▼                                        ▼
  ┌─────────┐                              ┌─────────┐
  │Embedding│                              │Embedding│
  └────┬────┘                              └────┬────┘
       │                                        │
       ⊕ ← Positional Encoding                  ⊕ ← Positional Encoding
       │                                        │
       ├───────────────────┐         ┌──────────┤──────────────────────────┐
       │                   │         │          │                          │
       ▼                   │         │          ▼                          │
  ┌───────────────────┐    │         │    ┌───────────────────────────┐    │
  │    Multi-head     │    │         │    │    Masked Multi-head      │    │
  │    Attention      │    │         │    │    Attention              │    │
  │    (Self-Attn)    │    │         │    │    (Self-Attn, Causal)    │    │
  └──┬──┬──┬──────────┘    │         │    └──┬──┬──┬──────────────────┘    │
     Q  K  V               │         │       Q  K  V                       │
     └──┴──┘               │         │       └──┴──┘                       │
        │                  │         │          │                          │
        ⊕ ◄────────────────┘         │          ⊕ ◄────────────────────────┘
        │   (Residual / Skip)        │          │     (Residual / Skip)
        ▼                            │          ▼
  ┌──────────┐                       │    ┌──────────┐
  │Add & Norm│                       │    │Add & Norm│
  └────┬─────┘                       │    └────┬─────┘
       │                             │         │
       ├────────────────────┐        │         ├─────────────────────────┐
       │                    │        └───────► │ K, V                    │
       ▼                    │                  ▼                         │
  ┌────────────────────┐    │             ┌─────────────────────────┐    │
  │    Positionwise    │    │             │    Multi-head           │    │
  │    FFN             │    │             │    Attention            │    │
  └──────┬─────────────┘    │             │    (Cross-Attention)    │    │
         │                  │             └────┬──┬──┬──────────────┘    │
         │                  │                  Q  K  V                   │
         │                  │                  │  └──┘                   │
         │                  │                  │  (K,V: Encoder 출력)     │
         ⊕  ◄───────────────┘                  ⊕ ◄───────────────────────┘
         │   (Residual / Skip)                 │     (Residual / Skip)
         ▼                                     ▼         
   ┌──────────┐                           ┌──────────┐
   │Add & Norm│                           │Add & Norm│
   └────┬─────┘                           └────┬─────┘
        │                                      │
   [Encoder 출력]                               ├────────────────────┐
        │                                      │                    │
        │                                      ▼                    │
        │                                 ┌────────────────────┐    │
        │                                 │    Positionwise    │    │
        │                                 │    FFN             │    │
        │                                 └────┬───────────────┘    │
        │                                      │                    │
        │                                      ⊕ ◄──────────────────┘
        │                                      │  (Residual / Skip)
        │                                      ▼
        │                                 ┌──────────┐
        │                                 │Add & Norm│
        │                                 └────┬─────┘
        │                                      │
        │                                      ▼
        │                                 ┌──────────────────────────┐
        │                                 │    FC                    │
        │                                 │    (Linear + Softmax)    │
        └────────────────────────────────►│    K, V 제공              │
                                          └──────────────────────────┘
                                               │
                                               ▼
                                             Output
```

### Attention
Attention은 병렬적으로 문장 내 모든 단어 간의 관계를 연산한다.
이에 입력 길이가 늘어날 수록 제곱만큼 연상량이 늘어나고, 이 때문에 입력 가능한 토큰 수가 정해져있다.  
위와 같은 문제로 실시간 학습이 불가하거나 할루시네이션과 같은 문제로 확장될 수 있다.

### Issue / Resolved
환각현상
  - 딥러닝 모델은 학습된 데이터 이외의 정보에 취약
  > Resolved: Finetuning, RAG, GraphRAG, AI Agent  
  >   
  > Research: Confession(by OpenAI)

기억불가: 
  - LLM은 사전학습 시에 받아들인 정보 외에 것은 배우지 못한다.
  - 따라서 오늘 나와 대화하고 있는 LLM은 어제 나와 대화했던 내용을 기억하지 못한다.
  > Resolved: Short-term memory, Long-term memory
  > 
  > Research: Titans(by Google), Nested learning(by Google)

토큰제한
  - 입력값의 길이가 길어지면 계산량이 크게 늘어나, 대부분의 모델이 길이를 제한
  > Resolved: Context Engineering, Context summary, RAG

# AI Agent
## RAG
LLM이 답변을 생성하기 전, 외부 지식 기반(DB, 문서 등)에서 관련 정보를 먼저 검색하여 활용하는 기술  
사내 지식을 RAG 시스템과 결합하기 위해서는 LLM이 이해하기 쉬운 형태로 문서를 수치화하고, 이를 LLM에게 잘 전달하는 것이 중요  
이를 위해 Document Processing, Embedding, Retrieval, Reranking, LLMOps 등 여러 요소가 조화롭게 구성되어야 한다.  
```text
Source  ->  Parsing  ->  Transformation  ->  Indexing  ->  Vector DB
                                                              │
                                                              ▼
LLM API ->                                   Preparing ->  Retrieval  -> Ranking  ->  Serving  -> LLM API


                                             |-------- Query Retrieval --------|
|----------------------------------------------------- Use RAG Engine ----------------------------------|
```

### RAG History
Naive RAG
- 단순한 Retrieval + Generation 구조
- Query → Vector Search → Top-K 문서 → LLM 입력
- 별도의 최적화 없이 기본 검색 결과에 의존

Advanced RAG
- 검색 및 생성 품질 향상을 위한 다양한 기법 적용
- Query rewriting, Re-ranking, Filtering, Chunking 전략 포함
- Multi-step retrieval, Hybrid search (BM25 + Vector) 등 활용

Modular RAG
- RAG 파이프라인을 모듈 단위로 분리하여 구성
- Retrieval, Memory, Tool, Agent 등을 독립적으로 조합 가능
- 상황에 따라 동적으로 흐름을 변경하는 유연한 구조 

# Reference
[poloclub.github.io/transformer-explainer](poloclub.github.io/transformer-explainer)  
[Google Brain (2017). Attention Is All You Need](https://arxiv.org/abs/1706.03762)  
[OepnAPI API](https://platform.openai.com)