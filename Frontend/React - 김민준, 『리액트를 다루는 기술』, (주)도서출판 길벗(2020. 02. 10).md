# React
- React interlocking in Spring Boot
- UI
- Transfer
- Webpack

---

# According to
김민준, 『리액트를 다루는 기술』, (주)도서출판 길벗(2020. 02. 10)

# 3. 컴포넌트
## 3.3. props
### 3.3.1. JSX 내부에서 props 렌더링
- props는 properties를 줄인 표현으로 컴포넌트 속성을 설정할 때 사용하는 요소입니다.
- props값은 해당 컴포넌트를 불러와 사용하는 부모 컴포넌트(현 상황에서는 App 컴포넌트가 부모 컴포넌트입니다)에서 설정할 수 있습니다.
- 단, props는 컴포넌트가 사용되는 과정에서 부모 컴포넌트가 설정하는 값이며, 컴포넌트 자신은 해당 props를 읽기 전용으로만 사용할 수 있습니다.
```
# App.js
import React from 'react';
import MyComponent from './MyComponent';

const App = () => {
    return <MyComponent name="React">칠드런테스트</MyComponent>;
};

export default App;

# MyComponent.js
import React from 'react';

const MyComponent = props => {
    return <div>안녕하세요, 제 이름은 {props.name}입니다.</div>;
};

MyComponent.defaultProps = {
    name: '기본이름'
};

export default MyComponent;
```

- props.child: 컴포넌트 태그 사이의 내용을 보여주는 props(output> 칠드런테스트)
- PropTypes: 컴포넌트의 필수 props를 지정하거나 props의 타입을 지정할 때 사용

### 3.3.4. 
- 컴포넌트 내부에서 바뀔 수 있는 값을 의미합니다.
#### 3.3.4.1. 클래스형 컴포넌트의 state
- state declare
```
# Counter.js
import React, {Component} from 'react';

Class Counter extends Component {
    // (방법1) 생성자 내에서 state를 정의
    constructor(props) {
        super(props);
        this.state = {                             // state의 초기값 설정하기(반드시, 객체형태일 것)
            number: 0,
            fixedNumber: 0
        };
    }
    
    // (방법2) 생성자 없이 state를 정의
    state = {
        number: 0,
        fixedNumber: 0
    };
    
    render() {
        const {number, fixedNumber} = this.state;  // state를 조회할 때는 this.state로 조회합니다.
        return (
            <div>
                ...
                <button
                    onClick={ () => {this.setState({number: number+1})} }    // this.setState를 사용하여 state에 새로운 값을 넣을 수 있습니다.
                >
                    +1
                </button>
            </div>
        )
    }
}

export default Counter;
```

- state setter
```
render() {
    const {number} = this.state;
    return (
        <div>
            <button
                onClick={
                    () => {                                      // 객체로 변경
                        this.setState({number: number+1});
                    }
                    
                    () => {
                        this.setState((prevState, props)=>{      // 함수로 변경
                            return {
                                // 업데이트하고 싶은 내용
                            }
                        });
                    }
                    
                    () => {
                        this.setState(prevState => {            // 함수로 변경(props생략)
                            return {
                                // 업데이트하고 싶은 내용
                            }
                        });
                        
                        // 화살표 함수에서 바로 객체를 반환하도록 했기 때문에 prevState => ({}) 형태를 띄움 (kim: 이부분 이해 안가네..)
                        this.setState( prevState => ({          // 함수로 변경(props생략)
                            number: preState.number + 1
                        }) );
                    }
                    
                    () => {
                        this.setState(                          // 함수로 변경(두번째 인자가 함수일 경우, callback 함수로 등록된다.)
                            {number: number+1},
                            () => {
                                console.log("callback");
                            }
                        );
                    }
                }
            >
            </button>
        </div>
    );
}

```

#### 3.3.4.2. 함수형 컴포넌트에서 useState
- Hooks를 공부하면 더 자세하게 공부할 수 있다

# 16. 리덕스 라이브러리 이해하기
- ![Redux](../Resource/Prog,%20FrontEnd,%20React,%20Redux.png)

## 16.1 개념 미리 정리하기
- Action
- 객체의 형태로, type 필드를 반드시 가지고 있어야 합니다.
```
# example
{
    type: 'TOGGLE_VALUE'
}
```

- Action 생성함수
```
# example
function addTodo(date){
    return {
        type: 'ADD_TODO',
        date
    };
}

# example(화살표함수)
const addTodo => data => ({
    type: 'ADD_TODO',
    data
});
```

- Reducer
- 실제로 변화를 일으키는 함수.
- action을 만들고 발생시키면 reducer가 현재 상태와 전달받은 action객체를 파라미터로 받아옵니다.
- 그리고 두 값을 참고하여 새로운 상태를 만들어 반환해 줍니다.
```
const initialState = {
    counter: 1
};

function reducer(state = initialState, action) {
    switch(action.type){
        case INCREMENT:
            return {
                counter: state.counter + 1
            };
        default:
            return state;
    }
}
```

- Store
```
import {createStore} from 'redux';

...

const store = createStore(reducer);
```

- dispatch
- Store에서 Reducer함수를 실행시켜서 새로운 상태를 만들어 줍니다.

- subscribe
- action이 dispatch되어 상태가 업데이트 될 때마다 특정 함수를 호출시키는 용도.(=callback)

- render함수 만들기
```
...

const store = createStore(reducer);

const render = () => {
    const state = store.getState();
    
    if(state.toggle) {
    } else {
    }
    
    counter.innerText = state.counter;
};

render();
```

- action 발생시키기
```
요소.onClick = () => {
    store.dispatch( /* action 생성함수 호출*/ );
}
```


---

# React interlocking in Spring Boot
- React 앱을 생성
   ~~~
   npm install -i react react-dom
   
   또는
   
   npm install -g create-react-app
   ~~~

- 의존성 추가(Webpack, Babel, Loader)
   ~~~
   npm i webpack webpack-cli @babel/core @babel/preset-env @babel/preset-react babel-loader css-loader style-loader -D
   ~~~
    - babel-loader : 자바스크립트 모듈 번들링을 위한 로더이며, 보통 ES6 코드를 ES5로 변환하기 위해 사용한다.
    - css-loader : 모듈 번들링은 자바스크립트 기반으로 이뤄지기 때문에 CSS 파일을 자바스크립트로 변환하기 위해 사용한다.
    - style-loader : css-loader에 의해 모듈화 되고, 모듈화 된 스타일 코드를 HTML 문서의 STYLE 태그 안에 넣어주기 위해 사용된다.
    - url-loader : 스타일에 설정된 이미지나 글꼴 파일을 문자열 형태의 데이터(Base64)로 변환하여 해당 CSS 파일 안에 포함시켜버리기 때문에 정적 파일을 관리하기 쉬워진다. 하지만 실제 파일들보다 용량이 커지고, CSS 파일이 무거워지므로 적당히 사용하는 것을 권장한다.
    - file-loader : 정적 파일을 로드하는데 사용되며, 보통 프로젝트 환경에 맞게 특정 디렉토리에 파일을 복사하는 역할을 수행한다.

- 의존성 추가(PropTypes, React Router)
   ~~~
   npm install --save prop-types react-router-dom
   ~~~
    - prop-types: React의 Prop를 validation할 때 사용.(React v15.5 부터 다른 패키지로 이동(즉, React.PropTypes사용 불가)하였으며, 현재는 prop-types lib를 사용하는 것을 권고.)
    - react-router-dom: react-router를 의존하고 있기 때문에, 해당 component만 설치한다.


---

# UI
Meterial-UI
~~~
npm install --save @material-ui/core
~~~


---

# Transfer
- Axios
- Install
~~~
npm install --save axios
~~~


---

# WebPack
- webpack setting
- web.config.js
  - root directory에 'webpack.config.js' file 생성
  - 주요 항목
    - context: root directory 를 지정한다.
      - entry는 해당 path를 시작으로 진행되나, output은 해당 path를 시작으로 빌드 되지 않는다.(path.resolve(__dirname, 'need path')를 이용) 왜지 ?!
      - ex>
        path.resolve(__dirname, 'src/main/frontend'),
    - resolve: contrext의 대상선정?!
      - ex>
        resolve: {
        extendsion: ['.js', '.jsx']
        }
    - entry: root file로써, entry를 시작으로 필요한 모듈들을 다 불러온 후, 한 파일로 합쳐 bundle.js에 저장.
      추가적으로는 모듈을 통하여 ES6 문법으로 작성된 코드를 ES5 형태로 변환.
      - ex>
        entry: {
        main: './src/App.js'
        }
    - output: 산출물
      - ex>
        const _publicPath = '/public/dist';
        ...
        output: {
        path: path.resolve(__dirname, 'src/main/resources/public/dist'),
        publicPath: _publicPath,
        filename: 'app.bundle.js'
        }
    - module
      - rules: JavaScript File들을 어떻게 처리할 것인지 정하는 config
    - plugins
    ```console
    Source 경로
      - module.exports = {context: path.resolve(__dirname, 'Source 경로') ... }
    Build SRC
      - module.exports = { ... entry: {Build SRC entry: '경로'} ... }
    Build DST
      - module.exports = { ... output: {path: __dirname, filename: '경로'} ... }
    ```

    ```console
    var path = require('path');
    
    module.exports = {
        context: path.resolve(__dirname, 'src/main/frontend'),
        entry: {
            main: './MainPage.jsx'
        },
        output: {
            path: __dirname,
            filename: './src/main/webapp/js/react/[name].bundle.js'
        },
        module: {
            rules: [ {
                test: /\.jsx?$/,
                exclude: /(node_modules)/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: [ '@babel/preset-env', '@babel/preset-react' ]
                    }
                }
            }, {
                test: /\.css$/,
                use: [ 'style-loader', 'css-loader' ]
            } ]
        },
        //plugins: [],
        mode: 'none',
        devtool: 'sourcemaps',
        cache: true,
    };
    ```

- webpack plug-in
  - clean-webpack-plugin: output으로 지정한 디렉토리를 build할 때마다 삭제하여 주는 plug-in
  ~~~
  npm install --save-dev clean-webpack-plugin
  ~~~
  - html-webpack-plugin: 번들링 시, 기본 HTML문서의 template을 생성해주는 plug-in
  ~~~
  npm install --save-dev html-webpack-plugin
  ~~~
  - html-webpack-root-plugin: html-webpack-plugin을 확장한 plugin으로써, html-webpack-plugin이 생성하는 HTML문서에 elements를 추가할 수 있다.
  ~~~
  npm install --save-dev html-webpack-root-plugin
  ~~~
  - uglifyjs-webpack-plugin: js파일을 난독화 및 압축하여 주는 plug-in
  ~~~
  npm install --save-dev uglifyjs-webpack-plugin
  ~~~
  - helmet: meta information 설정
  ~~~
  npm install --save react-helmet @types/react-helmet
  ~~~

# Reference
- React Webpack: [https://webpack.js.org/concepts/](https://webpack.js.org/concepts/)
- React Webpack: [https://github.com/webpack/docs/wiki/configuration](https://github.com/webpack/docs/wiki/configuration)
