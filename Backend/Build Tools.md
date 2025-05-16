# Build Tools
- Gradle

---

# Gradle
## 사전지식
- build: ex> jar(compile + test + deploy + etc)
  - source code file을 컴퓨터에서 실행할 수 있는 독립 소프트웨어 가공물로 변환하는 과정을 말하거나 그에 대한 결과물을 얻는 과정

## DSL(Domain Sepecific Language)
- [https://docs.gradle.org/current/dsl/](https://docs.gradle.org/current/dsl/)
- DSL 활용
  - 비공개(Internal): 
  - 실험상태(Incubating): Test중으로 아직 배포되지 않은 상태
  - 공개상태(Public): 배포된 상태
  - 폐지상태(Deprecated): 배포를 중지하기로한 상태

## Gradle Life Cycle
- gradle life cycle 3단계
  ```
  initialization -> Configuration -> Execution
  ```
- [https://docs.gradle.org/current/userguide/build_lifecycle.html](https://docs.gradle.org/current/userguide/build_lifecycle.html)

### initialization(ref file: settings.gradle)
- Script File 확인 및 읽기
- Multi/Single Module Project 판단.
  - Multi Module Project일 경우, 각 Module 별로 build.gradle{.kts}가 있는지 확인한다.
- 명령어 옵션 및 인수 설정

### congifuration(ref file: build.gradle{.kts})
- buildScript의 library를 가져오거나(plugin 메소드), Project를 configure하는 작업(congiruations 메소드), Project에서 사용할 library를 가져오는 작업(dependencies 메소드) 등 을 수행한다.
- 이후 Gradle Task를 순차적으로 수행한다. 단, Gradle Task의 기본 블록은 Configuration단계에서 수행되지만, doFirst{}, doLast{} method를 이용하여 Execution 단계에서 수행되도록 할 수도 있다.

### execution
- build를 진행한다.(code gen(=annotation processing), compile, test, packaging 등)

## 구성요소
- 초기화 설정 스크립트(Initialization Setting Script): settings.gradle
- 빌드 구성 스크립트(Build Congifuration Script): gradle.build{.kts})
- 속성 파일(gradle.properteis)
- 환경변수/명령어 옵션
  - example> gradle clean compile
- 프로젝트 디렉토리(Project Directory): buildSrc
  - 빌드 수행 시, 클래스 파일이나 플러그인을 저장하여 참조하는 디렉터리

## 구성요소와 객체
### settings object(초기화 설정 스크립트(Initialization Setting Script): settings.gradle)
- settings.gradle 파일은 파일 자체가 settings object이며, settings object를 이용하여 project object의 계층구조를 생성한다.

#### 속성
- gradle
- plugins
- rootDir
- rootProject
- settings
- settingsDir
- startParameter

#### 기타 
- Script: Gradle의 특정 method를 추가하기 위해 사용. Gradle의 스크립트에서 script object의 인터페이스를 구현하여 method와 속성을 사용
- SourceSet: Java Source 및 Resource에 대하여 그룹을 형성하여 사용
- ExtensionAware: Runtime에 다른 객체와 함께 확장하여 사용. extensions이라는 확장 속성을 저장하는 컨테이너 이용
- ExtraPropertiesExtension: ext로 정의된 확장 속성

#### API
- findProject()
- Project()
- Include()
- IncludeFlat()

### project object(빌드 구성 스크립트(Build Congifuration Script): gradle.build{.kts}))
- gradle.build 파일은 파일 자체가 project object로, Project 인터페이스를 구현한 구현체이며, Project 단위에서 필요한 작업을 수행하기 위해 모든 메서드와 프로퍼티를 모아놓은 'Super object'이다.
```
poublic interface Project extends Comparable<Project>, ExtensionAware, PluginAware{
    ...
}
```
- project object 구조
  - TaskContainer
  - DependencyHandler
  - ArtifactHandler
  - RepositoryHandler
  - Gradle
  - ConfigurationContrainer

#### 속성
- version
- description
- name
- state
- status
- path
- group
- buildDir
- plugins
- projectDir
- rootProject
- parent
- childParents
- allProjects
- subprojects

#### 기타 
- defaultTasks
- repositories
- tasks
- ant

#### API
- project(path): 지정된 경로의 Project에 대하여 설정(상대 경로로 지정가능)
- project(path, congifureClosure): 지정된 경로의 Project에 대하여 Closure를 사용하여 Project 구성(상대 경로로 지정가능)
- absoluteProjectPath(path): 절대 경로로 변환하여 Project확인
- apply(closure): Plugin이나 Script를 적용
- congifure(object, configureClosure): Closure를 통하여 설정된 상태를 이용하여 객체를 구성
- subproject(action): Sub Project를 구성
- task(name)
- beforeEvaluate(action): Project가 평가되기 직전 추가
- afterEvaluate(action): Project가 평가된 직후 추가

## How to use ?
### initialization(ref file: settings.gradle)
#### rootPoject object
- Project의 이름을 지정한다.
```
rootProject.name = "app"
```

#### include 메소드
- Multi Module Project를 구성할 때, 하위 모듈을 인식하도록 한다.
```
rootProject.name = "app"

include("sub app")
```

### congurations(ref file: build.gradle)
- build.gradle 파일은 파일 자체가 project object이며, 아래의 method들을 갖는다.
- project Object의 plugins method, ext method, plugins method, congifurations method, dependencies method, application method 등
```
# build.gradle
// build.gradle이 project object로 plugins method를 사용하는 방법은 다음과 같다.
project.plugins ({
    // TODO
})

// "project"를 생략하여 사용할 수 있다.
plugins ({
    // TODO
})

// 최상단 예제에서, {}로 감싸져 있는 부분은 메서드의 인자로 받아들여지는 Groovy의 Closure인데, Groovy의 클로저는 Java나 Kotlin의 Lambda와 같으며, 아래와 같이 변경하여 사용할 수 있다.
plugins {
    // TODO
}
```

#### repositories 메소드
- 저장소를 설정을 담당.
- RepositoryHandler를 통해 실행.

#### ext 메소드
- buildScript에서 전역변수로 사용하기 위해 사용.

#### plugins 메소드
- plugin을 등록하면, 해당 플러그인에 포함된 수많은 Task들이 Gradle파일로 들어온다.
```
# Intellij의 gradle 탭을 보면 spring관련된 task들이 보일것이다(bootRun 등)
plugins {
    id 'org.springframework.boot' version 'x.x.x'
}
```

#### configurations 메소드
- build.gradle 내부에서 사용되는 설정을 정의한다.

#### dependencies 메소드
- compileOnly
- runtimeOnly
- api(Deprecated compile)
  - Parent Hierarchy 구조 일 때, 모든 Parent의 의존성을 노출한다.
  - [https://developer.android.com/studio/build/dependencies?utm_source=android-studio#dependency_configurations](https://developer.android.com/studio/build/dependencies?utm_source=android-studio#dependency_configurations)
  ```
  Gradle은 컴파일 클래스 경로와 빌드 출력에 종속 항목을 추가합니다.
  모듈에 api 종속 항목이 포함되면 모듈이 다른 모듈로 종속 항목을 이전하여 다른 모듈에서 런타임과 컴파일 시간에 사용할 수 있도록 한다는 것을 Gradle에 알려주는 것입니다.
  이 구성은 compile(현재는 지원 중단됨)처럼 작동하지만 주의해서 다른 업스트림 소비자에게 이전해야 하는 종속 항목과만 사용해야 합니다.
  그 이유는 api 종속 항목이 외부 API를 변경하면 Gradle이 컴파일 시 종속 항목에 액세스 권한이 있는 모든 모듈을 다시 컴파일하기 때문입니다.
  따라서 api 종속 항목 수가 많으면 빌드 시간이 크게 증가할 수 있습니다.
  종속 항목의 API를 별도의 모듈에 노출하지 않으려면 라이브러리 모듈에서 implementation 종속 항목을 대신 사용해야 합니다.
  ```
- implementation
  - Parent Hierarchy 구조 일 때, 직계 Parent의 의존성을 노출한다.
  - [https://developer.android.com/studio/build/dependencies?utm_source=android-studio#dependency_configurations](https://developer.android.com/studio/build/dependencies?utm_source=android-studio#dependency_configurations)
  ```
  Gradle이 컴파일 클래스 경로에 종속 항목을 추가하고 빌드 출력에 종속 항목을 패키징합니다.
  그러나 모듈에서 implementation 종속 항목을 구성하면 모듈이 컴파일 시간에 종속 항목을 다른 모듈에 누출하기를 바라지 않는다는 것을 Gradle에 알려주는 것입니다.
  즉 종속 항목은 런타임에만 다른 모듈에서 이용할 수 있습니다.
  api 또는 compile(지원 중단됨) 대신 이 종속 항목 구성을 사용하면 빌드 시스템에서 다시 컴파일해야 하는 모듈 수가 줄어들기 때문에 빌드 시간이 크게 개선될 수 있습니다.
  예를 들어 implementation 종속 항목이 API를 변경하면 Gradle은 이 종속 항목과 이에 직접적으로 종속된 모듈만 다시 컴파일합니다.
  대부분의 앱과 테스트 모듈은 이 구성을 사용해야 합니다.
  ```
- testImplementation
  - Test 시에 의존성을 노출한다.
- annotationProcessor
  - annotation processor 명시
  ```
  dependencies {
      annotationProcessor 'org.projectlombok:lombok'
  }
  ```

#### Task 메소드
- Gardle의 실행 작업 단위
```
task 테스크이름1 {
    // TODO
}

task 테스크이름2(dependsOn:['테스크이름3', '테스트이름4' ... ]) {
}
```
  - dependsOn
    - Task들 사이의 의존성을 지정

---

# Multi Module Project(=cross project congiruation)
- [https://docs.gradle.org/current/userguide/multi_project_builds.html#sec:cross_project_configuration](https://docs.gradle.org/current/userguide/multi_project_builds.html#sec:cross_project_configuration)

# Reference
- [https://www.youtube.com/watch?v=hbZJPhceVg4&list=PL7mmuO705dG2pdxCYCCJeAgOeuQN1seZz&index=13](https://www.youtube.com/watch?v=hbZJPhceVg4&list=PL7mmuO705dG2pdxCYCCJeAgOeuQN1seZz&index=13)

