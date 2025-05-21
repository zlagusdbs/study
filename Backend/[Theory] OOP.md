# Theory
- SOLID

---

# SOLID 원칙
- SRP(Single Responsiblity Principle: 단일 책임 원칙) : 소프트웨어의 설계 부품(클래스, 메소드 등)은 하나의 책임(기능)만을 가져야 한다.
- OPC(Open-Closed Principle: 개방-폐쇄 원칙) : 수정에는 열려있되, 기존소스는 폐쇄적(수정을 하여도 기존소스를 수정하지 않아야 한다는 뜻)이어야 한다.
- LSP(Liskov Substitution Principle: 리스코프 치환 원칙) : 부모 클래스와 자식 클래스 사이에 일관성이 있어야 한다.(부모 클래스의 인스터스이던 자식 클래스의 인스턴스이던 아무거나 써도 문제가 없어야 함.)
    - 단, 정의하는 범위에 따라 원칙을 지킬 수도, 지키지 않을 수도 있다.
    - |           | 둘레 | 넓이 | 각 |
      |-----------|-----|------|---|
      | 삼각형    |  O   |  O   | O |
      | 사각형    |  O   |  O   | O |
      | 원        |  O   |  O   | X |
- ISP(Interface Segregation Principle: 인터페이스 분리 원칙) : 하나의 인터페이스 보다는 용도에 맞는 여러개의 인터페이스를 설계한다.
- DIP(Dependency Inversion Principle: 의존성 역전 원칙) : 의존성을 주입할 때는, 제어의 역전이 존재해야 한다.
    - Player class가 존재하며, file의 형태마다 play하는 용도가 다르다.
    ```
    public class Player{
        public Player(Resource resource){
            this.resource = resource;
        }

        private Resource resource;

        public play(){
            System.out.println(this.resource.toString()+"를 실행합니다.");
        }
    }

    public interface Resource{}
    public class MP3 implement Resource{}
    public class Movie implement Resource{}

    public class Main{
        public static void main(String[] args){
            Player player = null;
            player = new Player( new MP3() );	// Player의 생성자를 호출 할 때, Parameter로 MP3(Resource의 자식class인 MP3)의 인스턴스를 넣음
            player = new Player( new Movie() );	// Player의 생성자를 호출 할 때, Parameter로 Movie(Resource의 자식class인 Movie)의 인스턴스를 넣음
            player.play();
        }
    }
    ```
