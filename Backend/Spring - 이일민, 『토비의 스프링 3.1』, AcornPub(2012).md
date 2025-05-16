# Spring
  - Spring MVC
  - Spring Boot
    - Core
    	- RequestParam, ModelAttribute, RequestBody, RequestPart
    - Security
    - Spring Boot 2.4.x ↑
    - JUnit 5
    - Validation
    - ExceptionHandler
  - Spring Cloud
    - resillience4j


---

# Spring MVC
  - 이일민, 『토비의 스프링 3.1』, AcornPub(2012)
  
  - 1장, 3장, 4장, 5장, 6장에서 각각 DataSource, JDBC, Exception, TransactionManager, Transcation경계설정에 관한 이야기를 다룬다.
    - 각각의 장에서 예제(DataSource, JDBC, Exception, Transaction 등)를 날코딩을 기점으로 framework답도록 Source Code를 직접 re-factoring해나가며,
      결과적으로는 spring의 구현방법을 설명하는 구조이다. 즉, spring framework의 내부구조의 history를 설명한다는 느낌이 들었음.
    - 설명하는 내용중 상당수의 Java Design pattern내용을 포함하기도 한다.
  - 2장 -> JUnit에 대한 이야기

## 1장 오브젝트와 의존관계 (DataSource에 대한 내용)
### 1.5 스프링의 IoC
  - 빈 팩토리(Bean Factory)
    - Spring에서 빈의 생성과 관계설정 같은 제어를 담당하는 IoC오브젝트
    - 빈을 생성하고 관계를 설정하는 IoC의 기본 기능에 초점을 둔 IoC 오브젝트
  - 어플리케이션 컨텍스트(Application Context)
    - 빈 팩토리(Bean Factory)를 확장한 IoC오브젝트
    - 어플리케이션 전반에 걸쳐 모든 구성요소의 제어 작업을 담당하는 IoC 엔진
  - 어플리케이션 컨텍스트는 IoC 방식을 따라 만들어진 일종의 빈 팩토리라고 생각하면 된다.

### Only Source
  - 1 Phase
  ```console
  # User.java
  @Getter
  @Setter
  public class User{
  	String id;
	String name;
	String password;
  }
  
  # UserDao.java
  public class UserDao{
  	public void add(User user) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");									# [Problem] 중복코드
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");	# [Problem] 중복코드
		
		PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?, ?, ?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public void get(String id) throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");									# [Problem] 중복코드
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");	# [Problem] 중복코드
		
		PreparedStatement ps = c.prepareStatement("select * from users where id = ?");
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		re.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword(rs.getString("password"));
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
  }
  ```
  
  - 2 Phase, 중복 코드의 메소드 추출
    - 중복코드를 제거한다.
  ```console
  # UserDao.java
  public class UserDao{
  	public void add(User user) throws ClassNotFoundException, SQLException{
		Connection c = getConnection();										# [Solution] 중복코드 제거
		
		PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?, ?, ?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	public void get(String id) throws ClassNotFoundException, SQLException{
		Connection c = getConnection();										# [Solution] 중복코드 제거
		
		PreparedStatement ps = c.prepareStatement("select * from users where id = ?");
		ps.setString(1, id);
		
		ResultSet rs = ps.executeQuery();
		re.next();
		User user = new User();
		user.setId(rs.getString("id"));
		user.setName(rs.getString("name"));
		user.setPassword(rs.getString("password"));
		
		rs.close();
		ps.close();
		c.close();
		
		return user;
	}
	
	private Connection getConnection() throws ClassNotFoundException, SQLException{					# [Solution] 중복코드 제거
		Class.forName("com.mysql.jdbc.Driver");									# [Problem] DataBase의 다형성 필요
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");
		return c;
	}
  }
  ```
  
  - 3 Phase, 상속을 통한 확장
    - 배포할 고객사(또는 서버)별 DataBase가 상이할 경우를 대비한다.
  ```console
  # UserDao.java
  public abstract class UserDao{
  	public void add(User user) throws ClassNotFoundException, SQLException{
		Connection c = getConnection();
		...
	}
	
  	public void get(String id) throws ClassNotFoundException, SQLException{
		Connection c = getConnection();
		...
	}
	
	public abstract Connection getConnection() throws ClassNotFoundException, SQLException;
  }
  
  # NUserDao.java
  public class NUserDao extends UserDao{
  	@Override
  	public Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");
		return c;
	}
  }
  
  # DUserDao.java
  public class DUserDao extends UserDao{
  	@Override
  	public Connection getConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.oracle.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");
		return c;
	}
  }
  ```
  
  - 4 Phase, 클래스 분리(=관심사 분리)
  ```console
  # UserDao.java
  public class UserDao{
  	public UserDao(){
		simpleConnectionMaker = new SimpleConnectionMaker();
	}
	
  	private SimpleConnectionMaker simpleConnectionMaker;
	
	public void add(User user) throws ClassNotFoundException, SQLException{
		Connection c = simpleConnectionMaker.makeNewConnection();
		...
	}
	
	public void get(String id) throws ClassNotFoundException, SQLException{
		Connection c = simpleConnectionMaker.makeNewConnection();
		...
	}
  }
  
  # SimpleConnectionMaker.java
  public class SimpleConnectionMaker{
  	public Connection makeNewConnection() throws ClassNotFoundException, SQLException{
		Class.forName("com.mysql.jdbc.Driver");
		Connection c = DriverManager.getConnection("jdbc:mysql://localhost/springbook", "spring", "book");
		
		return c;
	}
  }
  ```
  
  - 5 Phase, 인터페이스 도입(=관심사 분리)
  ```console
  # ConnectionMaker.java
  public interface ConnectionMaker{
  	public Connection makeConnection() throws ClassNotFoundException, SQLException;
  }
  
  public class DConnectionMaker implements ConnectionMaker{
  	...
  	public Connection makeConnection() throws ClassNotFoundException, SQLException{
		// to do
	}
  }
  
  # UserDao.java
  public class UserDao{
  	public userDao(){
		connectionMaker = new DConnectionMaker();				# [Problem] 구현체가 여기서 정의되면 안된다.
	}
	
  	private ConnectionMaker connectionMaker;					# 인터페이스를 통해 오브젝트에 접근하므로 구체적인 클래스 정보를 알 필요가 없다.
	
	public void add(User user) throws ClassNotFoundException, SQLException{
		Connection c = connectionMaker.makeConnection();			# 인터페이스에 정의된 메소드를 사용하므로, 클래스가 바뀌어도 수정할 내역이 없다.
		...
	}
	
	public User get(String id) throws ClassNotFoundException, SQLException{
		Connection c = connectionMaker.makeConnection();			# 인터페이스에 정의된 메소드를 사용하므로, 클래스가 바뀌어도 수정할 내역이 없다.
		...
	}
  }
  ```
  
  - 6 Phase, 관계설정 책임의 분리
  ```console
  # UserDao.java
  public UserDao(ConnectionMaker connectionMaker){
  	this.connectionMaker = connectionMaker;
  }
  
  # Client.java
  public class Client{
  	public static void client(...) throws ClassNotFoundException, SQLException{
		ConnectionMaker connectionMaker = new DConnectionMaker();
		UserDao userDao = new UserDao(connectionMaker);
		...
	}
  }
  ```
  
  - 7 Phase, IOC
  ```
  # DaoFactory.java
  public class DaoFactory{
  	public UserDao userDao(){
		ConnectionMaker connectionMaker = new DConnectionMaker();
		UserDao userDao = new UserDao(connectionMaker);
		return userDao;
	}
  }
  
  # Client.java
  public class Client{
  	public static void client(...) throws ClassNotFoundException, SQLException{
		UserDao userDao = DaoFactory().userDao();
		...
	}
  }
  ```
  
  ```
  ### Factory의 활용
  # DaoFactory.java
  public class DaoFactory{
  	public UserDao userDao(){
		return new UserDao(connectionMaker());
	}

	public AccountDao accountDao(){
		return new AccountDao(connectionMaker());
	}
	
	public ConnectionMaker connectionMaker(){
		return new DConnectionMaker();
	}
  }
  
  # Client.java
  public class Client{
  	public static void client(...) throws ClassNotFoundException, SQLException{
		UserDao userDao = DaoFactory().userDao();
		...
	}
  }
  ```
  
  - 8 Phase, 제어권의 이전을 통한 제어관계 역전(Spring의 활용)
    - 현 예제에서는 ApplicationContext 인터페이스를 사용하였지만, 서재에서는 Setter 또는 XML방식을 추가 설명하였다.
    - 다만, 본질은 스프링에서 Singleton Registry를 이용하여, Bean을 관리하고, 관리된 Bean을 DI한다는데 의의를 두면 된다.
  ```console
  # DaoFactory.java
  @Configuration
  public class DaoFactory{
  	@Bean
	public UserDao userDao(){
		return new UserDao(connectionMaker());
	}
	
  	@Bean
	public ConnectionMaker connectionMaker(){
		return new DConnectionMaker();
	}
  }
  
  # Client.java
  public class Client{
  	public static void client(...) throws ClassNotFoundException, SQLException{
		ApplicationContext context = new AnnotationConfigApplicationContext(DaoFactory.class);
		UserDao userDao = context.getBean("userDao", UserDao.class);
		...
	}
  }
  ```
  
  - 9 Phase, DataSource 인터페이스로 변환
    - ConnectionMaker는 DB컨넥션을 생성해주는 기능 하나만을 정의한 매우 단순한 인터페이스다.
    - Java진영에서는 DB컨넥션을 가져오는 오브젝트의 기능을 추상화하여, 다양하게 사용할 수 있게 만들어진 DataSource라는 클래스가 이미 존재한다.
  ```console
  # javax.sql.DataSource.java
  public interface DataSource extends CommonDataSource, Wrapper{
  	Connection getConnection() throws SQLException;
  }
  
  # UserDao.java
  UserDao{
  	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	public void add(User user) throws SQLException{
		Connection c = dataSource.getConnection();
		...
	}
  }
  ```
  
## 2장 테스트 (JUnit에 대한 내용)
### 2.3절 개발자를 위한 테스팅 프레임워크 JUnit
  - 픽스처(fixture)
    - 테스트를 수행하는데 필요한 정보나 오브젝트를 뜻함.
    - 일반적으로 픽스처는 여러 테스트에서 반복적으로 사용되기 때문에 @Before 메소드를 이용해 생성하여 사용.
    ```
    public class UserDaoTest{
        private UserDao dao;
	private User user1;		// fixture
	private User user2;		// fixture
	private User user3;		// fixture
	
	@Before
	public void setUp(){
	    ...
	    this.user1 = new User("gyumee", "박성철", "springno1");
    	    this.user2 = new User("leegw700", "이길원", "springno2");
    	    this.user3 = new User("bumjin", "박범진", "springno3");
	}
    }
    ```

#### 2.4절 스프링 테스트 적용
  - @RunWith
    - JUnit 프레임워크의 테스트 실행 방법을 확장할 때 사용
    - SpringJUnit4ClassRunner라는 JUnit용 테스트 컨텍스트 프레임워크 확장 클래스를 지정해주면, JUnit이 테스트를 진행하는 도중에 테스트가 사용할 어플리케이션 컨텍스트를 만들고 관리하는 작업을 진행해준다.
  - @ContextConfiguration( locations="" )
    - 어플리케이션 컨텍스트(application context)의 설정파일 위치를 지정
    - @ContextConfiguration 어노테이션으로 만들어진 어플리케이션 컨텍스트는 싱글턴으로 관리된다.
  ```
  # applicationContext.xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns=""
         xmlns:xsi=""
	 
	 <bean id="connectionMaker" class="springbook.user.dao.DConnectionMaker" />
	 
	 <bean id="userDao" class="springbook.user.dao.UserDao">
	 	<property name="connectionMaker" ref="connectionMaker" />
	 </bean>
  </beans>
  
  # AS-IS
  ...
  public class UserDaoTest{
  	private UserDao dao;
	
	@Before
	public void setUp(){
		ApplicationContext context = new GenericXmlApplicationContext("applicationContext.xml");
		
		this.dao = context.getBean("userDao", UserDao.class);
	}
  }
  
  
  # TO-BE
  @RunWith(SpringJUnit4ClassRunner.class)
  @ConextConfiguration(locations="/applicationContext.xml")	// 테스트 컨텍스트가 자동으로 만들어줄 어플리케이션 컨텍스트의 위치 지정
  public class UserDaoTest{
  	@Autowired
	private ApplicationContext context;			// 테스트 오브젝트가 만들어지고 나면 스프링 테스트 컨텍스으에 의해 자동으로 값이 주입된다
	
	@Before
	public void setUp(){
		this.dao = this.context.getBean("userDao", UserDao.class);
	}
  }
  ```

## 3장 템플릿 (JDBC에 대한 내용)
  - 1 Phase
  ```console
  # UserDao.java
  public class UserDao{
  	...
	
  	public void deleteAll() throws SQLException{
		Connection c = dataSource.getConnection();
		
		PreparedStatement ps = c.prepareStatement("delete from users");
		ps.executeUpdate();
		
		ps.close();
		c.close();
	}
	
	...
  }
  ```
  
  - 2 Phase, 예외처리
  ```console
  # UserDao.java
  public class UserDao{
  	...
	
  	public void deleteAll() throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			ps = c.prepareStatement("delete from users");
			ps.executeUpdate();
		}catch(SQLException se){
			throw e;
		}finally{
			if(ps!=null){
				try{ ps.close(); } catch(SQLException se){}
			}
			if(c!=null){
				try{ c.close(); } catch(SQLException se){}
			}
		}
	}
	
	...
  }
  ```
  
  - 3 Phase, 메소드 추출
  ```console
  # UserDao.java
  public class UserDao{
  	...
	
	public void deleteAll() throws SQLException{
		...
		
		try{
			c = dataSource.getConnection();
			ps = makeStatement(c);
			ps. executeUpdate();
		}catch(SQLException e){
		}
		
		...
	}
	
	private PreparedStatement makeStatement(Connection c) throws SQLException{
		PreparedStatement ps;
		ps = c.prepareStatement("delete from users");
		return ps;
	}
	
	...
  }
  ```
  
  - 4 Phase, 템플릿 메소드 패턴의 적용
  ```console
  # StatementStrategy.java
  public interface StatementStrategy{
  	PreparedStatement makePreparedStatement(Connection c) throws SQLException;
  }
  
  # DeleteAllStatement.java
  public class DeleteAllStatement implements StatementStrategy{
  	public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from users");
		return ps;
	}
  }
  
  # UserDao.java
  public class UserDao{
  	...
	
	public void deleteAll() throws SQLException{
		...
		
		try{
			c = dataSource.getConnection();

			StatementStrategy strategy = new DeleteAllStatement();
			ps = strategy.makePreparedStatement(c);

			ps.executeUpdate();
		}catch(SQLException e){
			...
		}
		
		...
	}
	
	...
  }
  ```
  
  - 5 Phase, 메소드 추출
  ```console
  # StatementStrategy.java
  public interface StatementStrategy{
  	PreparedStatement makePreparedStatement(Connection c) throws SQLException;
  }
  
  # DeleteAllStatement.java
  public class DeleteAllStatement implements StatementStrategy{
  	public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
		PreparedStatement ps = c.prepareStatement("delete from users");
		return ps;
	}
  }
  
  # AddStatement.java
  public class AddStatement implements StatementStrategy{
  	public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
		PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?, ?, ?)");
		ps.setString(1, user.getId());
		ps.setString(2, user.getName());
		ps.setString(3, user.getPassword());
		
		return ps;
	}
  }
  
  # UserDao.java
  public class UserDao{
  	...
	
	public void deleteAll() throws SQLException{
		StatementStrategy st = new DeleteAllStatement();
		jdbcContextWithStatementStrategy(st);
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt) throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps!=null){ try{ps.close();}catch(SQLException e){} }
			if( c!=null){ try{ c.close();}catch(SQLException e){} }
		}
	}
	
	...
  }
  ```
  
  - 6 Phase, 로컬 클래스
  ```console
  public class UserDao{
  	...
  
  	public void add(final User user) throws SQLException{			# User 파라미터를 final로 선언할 경우, 내부 클래스에서 외부의 변수를 사용할 수 있다.
		class AddStatement implements StatementStrategy{
			User user;
			
			public AddStatement(USer user){
				this.user = user;
			}
			
			public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
				PreparedStatement ps = c.preparedStatement("insert into users(id, name, password) values(?, ?, ?);
				ps.setString(1, user.getId());
				ps.setString(2, user.getName());
				ps.setString(3, user.getPassword());
				
				return ps;
			}
		}
		
		StatementStrategy st = new AddStatement();			# User 파라미터를 final로 선언하였기 때문에, AddStatement 생성자에 user를 파라미터로 전달하지 않아도된다.
		//StatementStrategy st = new AddStatement(user);		# USer 파라미터를 final로 선언하지 않았을 경우.
		jdbcContextWithStatementStrategy(st);
	}
	
	public void jdbcContextWithStatementStrategy(StatementStrategy stmt) throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c = dataSource.getConnection();
			
			ps = stmt.makePreparedStatement(c);
			
			ps.executeUpdate();
		}catch(SQLException e){
			throw e;
		}finally{
			if(ps!=null){ try{ps.close();}catch(SQLException e){} }
			if( c!=null){ try{ c.close();}catch(SQLException e){} }
		}
	}
	
	...
  }
  ```
  
  - 7 Phase, 익명 내부 클래스
  ```console
  public class UserDao{
  	...
  
  	public void add(final User user) throws SQLException{
		jdbcContextWithStatementStrategy(
			new StatementStrategy(){
				public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
					PreparedStatement ps = c.prepareStatement("insert into users(id, name, password) values(?, ?, ?)");
					ps.setString(1, user.getId());
					ps.setString(2, user.getName());
					ps.setString(3, user.getPassword());
					
					return ps;
				}
			}
		)
	}
	
  	public void deleteAll() throws SQLException{
		jdbcContextWithStatementStrategy(
			new StatementStrategy(){
				public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
					PreparedStatement ps = c.prepareStatement("delete from users");
				}
			}
		)
	}
	
	...
  }
  ```
  
  - 8 Phase, 클래스 분리
  ```console
  # JdbcContext.java
  public class JdbcContext{
  	private DataSource dataSource;
	
	public void setDataSource(DataSource dataSource){
		this.dataSource = dataSource;
	}
	
	public void workWithStatementStrategy(StatementStrategy stmt) throws SQLException{
		Connection c = null;
		PreparedStatement ps = null;
		
		try{
			c.this.dataSource.getConnection();
			ps = stmt.makePreparedStatement(c);
			ps.executeUpdate();
		}catch(SQLException se){
			throw se;
		}finally{
			if(ps!=null){ try{ps.close();}catch(SQLException e){} }
			if( c!=null){ try{ c.close();}catch(SQLException e){} }
		}
	}
  }
  
  # UserDao.java
  public class UserDao{
  	...
	
	private JdbcContext jdbcContext;
	
	public void setJdbcContext(JdbcContext jdbcContext){
		this.jdbcContext = jdbcContext;
	}
	
	public void add(final User user) throws SQLException{
		this.jdbcContext.workWithStatementStrategy(
			new StatementStrategy(){
				...
			}
		)
	}
	
	public void deleteAll() throws SQLException{
		this.jdbcContext.workWithStatementStrategy(
			new StatementStrategy(){
				...
			}
		)
	}
	
	...
  }
  ```
  
  - 9 Phase, 콜백의 분리와 재활용
  ```console
  # UserDao.java
  public class UserDao{
  	...
	
	public void deleteAll() throws SQLException{
		executeSql("delete from users");
	}
	
	private void executeSql(final String query) throws SQLException{
		this.jdbcContext.workWithStatementStrategy(
			new StatementStrategy(){
				public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
					return c.prepareStatement(query);
				}
			}
		)
	}
	
	...
  }
  ```
  
  - 10 Phase, 콜백과 템플릿의 결합
  ```console
  # UserDao.java
  public class UserDao{
  	...
	
	public void deleteAll() throws SQLException{
		this.jdbcContext.executeSql("delete from users");
	}
	
	...
  }
  
  # JdbcContext.java
  public class JdbcContext{
  	...
	
	public void executeSql(final String query) throws SQLException{
		workWithStatementStrategy(
			new StatementStrategy(){
				public PreparedStatement makePreparedStatement(Connection c) throws SQLException{
					return c.prepareStatement(query);
				}
			}
		)
	}
	
	...
  }
  ```
  
  - 11 Phase, 재사용 가능한 콜백의 분리(javax.sql.JdbcTemplate)
    - 위 예제에서 만든 jdbcContext는 더이상 사용하지 않는다. 다만, 이를 더 java진영에서 우아하게 구현해 놓은 JdbcTemplate클래스를 사용한다.
    - JdbcTemplate 클래스의 주요 메소드들
      - update()
      - query()
      - queryForInt()
      - queryForObject()
    - 단, JdbcTemplate의 몇 메소드는 제네릭 메소드로 타입은 파라미터로 넘기는 RowMapper<T>이기 때문에, RowMapper클래스의 구현을 인지하여야 한다.
  ```console
  # UserDao.java
  public class UserDao{
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<User> userMapper = new RowMapper<User>(){
		public User mapRow(ResultSet rs, int rowNum) throws SQLException{
			User user = new USer();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			return user;
		}
	}
	
	public List<User> add(final User user){
		return this.jdbcTemplate.update( "insert into users(id, name, password) values(?, ?, ?), user.getId(), user.getName(), user.getPassword() );
	}
	
	public List<User> get(String id){
		return this.jdbcTemplate.update( "select * from users where id = ?", new Object[] {id}, this.userMapper );
	}
	
	public List<User> deleteAll(){
		return this.jdbcTemplate.update( "delete from users" );
	}
	
	public List<User> getCount(){
		return this.jdbcTemplate.update( "select count(*) from users" );
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.update( "select * from users order by id", this.userMapper );
	}
  }
  ```

## 4장 예외
  - 예외의 종류
    - java.lang.Error
      - 시스템에 뭔가 비정상적인 상황이 발생하였을 경우 사용.
      - 주로 VM에서 발생시키는 것이고 애플리케이션 코드에서 잡으려고 하면 안된다.
	- 예> OutOfMemoryError, ThreadDeath 등
    - Exception
      - 컴파일 단계에서 추론 가능한 예외
    - RuntimeException
      - 실행시점에 추론 가능한 예외
      - 프로그램의 오류가 있을 때 발생하도록 의도된 것들
  - 예외처리방법
      - 예외 복구: catch문 내, while등을 이용하여 예외 발생 시 N차례 재시도하도록 구현
      - 예외 회피: catch문 내, 로그 등을 출력하도록 한 뒤, 다시 throws하여 예외를 직접 처리치 않고, 호출한 곳에서 처리 할 수 있도록 한다.
      - 예외 전환: catch문 내, 예외를 catch하였을 때, 해당 예외를 잡아 조금 더 구체적인 예외로 변경(Checked Exception)하거나, 무의미한 Exception에서 해방될 수 있도록 새로운 예외(Unchecked Exception)를 throws한다.
	
### 4.2 예외 전환
  - JdbcTemplate으로 구현한 부분을 보면 throws SQLException구문이 모두 빠져있는걸 확인할 수 있다.
  - JdbcTemplate이 SQLException을 DataAccessException(RuntimeException)으로 예외 전환을 하였기 때문이다.
  - 뿐만 아니라, DB메타정보를 참고해서 DB종류를 확인하고 DB별로 미리 준비된 매핑정보를 참고해서 적절한 예외 클래스를 선택(DataAccessException의 child class)하여 예외를 발생한다.
	
#### 4.2.3 DAO인터페이스와 DataAccessException 계층구조

#### 4.2.4 기술에 독립적인 UserDao 만들기
  - 인터페이스 적용

## 5장 서비스 추상화 (TransactionManager에 대한 내용)
  - 1 Phase
    - upgradeLevels() re-factoring, because it's too complicated
  ```console
  # Level.java
  class enum Level{
	BASIC(1), SILVER(2), GOLD(3);
	
	private final int value;
	
	Level(int Value){
		return value;
	}
	
	public static Level valueOf(int value){
		switch(value) {
			case 1: return BASIC;
			case 2: return SILVER;
			case 3: return GOLD;
			default: throw new AssertionError("Unknown value: "+value);
		}
	}
  }
	
  # User.java
  @Getter
  @Setter
  public class User{
  	String id;
	String name;
	String password;
	
	Level level;
	
	int login;
	int recommend;
  }
	
  # UserDao.java
  public interface UserDao{
	...
	
	public void update(User user1);
  }
	
  # UserDaoJdbc.java
  public class UserDaoJdbc implements USerDao{
	...
	
	private RowMapper<User> userMapper = new RowMapper<User>(){
		public User mapRow(ResultSet rs, int rowNum) throws SQLException{
			User user = new USer();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	}
	
	public void add(User user){
		this.jdbcTemplate.update(
			"insert into users(id, name, password, level, login, recommend)" + "values(?, ?, ?, ?, ?, ?)", +
			user.getId(), user.getPassword(), user.getLevel().intValue(), user.getLogin(), user.getRecommend()
		);
	}
	
	public void update(User user){
		this.jdbcTemplate.update(
			"update users set name = ?, password = ?, level = ?, login = ?, recommend = ?, where id = ? ",
			user.getName(), user.getPassword(), user.getLevel().intValue(), user.getLogin(), user.getRecommend(), user.getId()
		);
	}
  }
	
  # UserService.java
  public class UserService{
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user: users){
			Boolean changed = null;
			if(user.getLevel()==Level.BASIC && user.getLogin() >= 50){			# [Problem] 가독성이 떨어진다.
				user.setLevel(Level.SILVER);
				changed = true;
			}else if(user.getLevel()==Level.SILVER && user.getRecommend() >= 50){		# [Problem] 가독성이 떨어진다.
				user.setLevel(Level.GOLD);
				changed = true;
			}else if(user.getLevel()==Level.GOLD){						# [Problem] 가독성이 떨어진다.
				changed = false;
			}else {										# [Problem] 가독성이 떨어진다.
				changed = false;
			}
	
			if(changed)
				userDao.update(user);
		}
	}
	
	...
  }
  ```
	
  - 2 Phase
  ```console
  # UserService.java
  public class UserService{
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){							# [Solution] 
				upgradeLevel(user);							# [Solution] 
			}
		}
	}
	
	private boolean canUpgradeLevel(User user){
		Level currentLevel = user.getLevel();
		switch(currentLevel){
			case BASIC: return (user.getLogin() >= 50);
			case SILVER: return (user.getRecommend() >= 30);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknown Level: " + currentLevel);
		}
	}
	
	private void upgradeLevel(User user){
		if( user.getLevel() == Level.BASIC ) user.setLevel(Level.SILVER);
		else if( user.getLevel() == Level.SILVER ) user.setLevel(Level.GOLD);
		userDao.update(user);
	}
	
	...
  }
  ```

  [★★★★★ full source ★★★★★]
  - 3 Phase, Level enum에 순서를 담도록 수정하여, '2 Phase'의 'upgradeLevel()'기능을 User에서 처리토록 수정
  ```console
  # UserDao.java
  public interface UserDao{
	void add(User user);
	User get(String id);
	List<User> getAll();
	void deleteAll();
	void getCount();
	void update(User user);
  }
	
  # UserDaoJdbc.java
  public class UserDaoJdbc implements USerDao{
	private JdbcTemplate jdbcTemplate;
	
	public void setDataSource(DataSource dataSource){
		this.jdbcTemplate = new JdbcTemplate(dataSource);
	}
	
	private RowMapper<User> userMapper = new RowMapper<User>(){
		public User mapRow(ResultSet rs, int rowNum) throws SQLException{
			User user = new USer();
			user.setId(rs.getString("id"));
			user.setName(rs.getString("name"));
			user.setPassword(rs.getString("password"));
			user.setLevel(Level.valueOf(rs.getInt("level")));
			user.setLogin(rs.getInt("login"));
			user.setRecommend(rs.getInt("recommend"));
			return user;
		}
	}
	
	public void add(User user){
		this.jdbcTemplate.update(
			"insert into users(id, name, password, level, login, recommend)" + "values(?, ?, ?, ?, ?, ?)", +
			user.getId(), user.getPassword(), user.getLevel().intValue(), user.getLogin(), user.getRecommend()
		);
	}
	
	public User get(String id){
		return this.jdbcTemplate.queryForObject("select * from users where id = ?", new Object[]{id}, this.userMapper);
	}
	
	public void deleteAll(){
		this.jdbcTemplate.update("delete from users");
	}
	
	public int getCount(){
		return this.jdbcTemplate.queryForInt("select count(*) from users");
	}
	
	public List<User> getAll(){
		return this.jdbcTemplate.query("select * from users order by id", this.userMapper);
	}
	
	public void update(User user){
		this.jdbcTemplate.update(
			"update users set name = ?, password = ?, level = ?, login = ?, recommend = ?, where id = ? ",
			user.getName(), user.getPassword(), user.getLevel().intValue(), user.getLogin(), user.getRecommend(), user.getId()
		);
	}
  }
	
  # Level.java
  public enum Level{
	GOLD(3, null), SILVER(2, GOLD), BASIC(1, SILVER);
	
	private final int value;
	private final Level next;
	
	Level(int value, Level next){
		this.value = value;
		this.next = next;
	}
	
	public int intValue(){
		return value;
	}
	
	public Level nextLevel(){
		return this.next;
	}
	
	public static Level valueOf(int value){
		switch(value){
			case 1: return BASIC;
			case 2: return SILVER;
			case 3: return GOLD;
			default: throw new AssertionError("Unknown value: " + value);
		}
	}
  }
	
  # User.java
  @Getter
  @Setter
  public class User{
	String id;
	String name;
	String password;
	Level level;
	int login;
	int recommend;
	
	public User(){}
	
	public User(String id, String name, String password, Level level, int login, int recommend){
		this.id = id;
		this.name = name;
		this.password = password;
		this.level = level;
		this.login = login;
		this.recommend = recommend;
	}
	
	public void upgradeLevel(){
		Level nextLevel = this.level.nextLevel();
	
		if( nextLevel == null ){
			throw new Illega15tateException(this.level + "은 업그레이드가 불가능합니다");
		} else {
			this.level = nextLevel;
		}
	}
  }
	
  # UserService.java
  public class UserService{
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	public void upgradeLevels(){
		List<User> users = userDao.getAll();
		for(User user: users){
			if(canUpgradeLevel(user)){							# [Solution] 
				upgradeLevel(user);							# [Solution] 
			}
		}
	}
	
	private boolean canUpgradeLevel(User user){
		Level currentLevel = user.getLevel();
		switch(currentLevel){
			case BASIC: return (user.getLogin() >= 50);
			case SILVER: return (user.getRecommend() >= 30);
			case GOLD: return false;
			default: throw new IllegalArgumentException("Unknown Level: " + currentLevel);
		}
	}
	
	private void upgradeLevel(User user){
		user.upgradeLevel();
		userDao.update(user);
	}
	
	public void add(User user){
		if( user.getLevel() == null)
			user.setLevel(Level.BASIC);
		userDao.add(user)
	}
  }
  ```

  - 4 Phase
    - TransactionManager에 대해 설명하고, JDBC, Hibernate, JTA등을 고려하여 Spring에선 PlatformTransactionManager라는 인터페이스로 서비스 추상화를 진행한 내용을 포함한다.
  ```console
  # UserService.java
  public class UserService{
	UserDao userDao;
	
	public void setUserDao(UserDao userDao){
		this.userDao = userDao;
	}
	
	public void upgradeLevels(){
		TransactionSynchronizationManager.initSynchronization();		# 아래, Connection 오브젝트를 멀티 쓰레드 환경에서 thread-safety하도록 사용할 수 있게 해준다.
		Connection c = DataSourceUtils.getConnection(dataSource);		# upgradeLevels() 메소드에 transaction의 경계를 설정하기위해,
											# Connection 오브젝트를 사용하는 모든 곳에 동일한 Connection 오브젝트를 사용해야 한다.
											# 이는, upgradeLevels() 메소드 뿐만 아니라, upgradeLevels() 메소드에서 호출하는 하위 메소드, UserDao 등 모든곳에 파라미터로 받도록 중복하여 코드를 작성해야 하고, 호출하는 쪽에서 파라미터로 전달까지 해야한다는 것.
											# 이를 배제하기 위해 Connection을 싱글톤으로 관리한다.
											# 다만, 멀티 쓰레드 환경에서 안전하게 사용할 수 있도록, TransactionSynchronizationManager도 같이 설정해주어야 한다.
		c.setAutoCommit(false);
	
		try{
			List<User> users = userDao.getAll();
			for(User user: users){
				if(canUpgradeLevel(user)){
					upgradeLevel(user);
				}
			}
	
			c.commit();
		}catch(Exception e){
			c.rollback();
			throw e;
		}finally{
			DataSourceUtils.releaseConnection(c, dataSource);
			TransactionSynchronizationManager.unbindResource(this.dataSource);
			TransactionSynchronizationManager.clearSynchronization();
		}
	}
	
	...
  }
  ```
	
  - 5 Phase, TransactionManager를 추상화한다.
  ```console
  # UserService.java
  public class UserService{
	UserDao userDao;
	private PlatformTransactionManager transactionManager;
	
	public void upgradeLevels(){
		TransactionStatus status = this.transactionManager.getTransaction(new DefaultTransactionDefinition());
		try{
			List<User> users = userDao.getAll();
			for(User user: users){
				if(canUpgradeLevel(user)){
					upgradeLevel(user);
				}
			}
	
			this.transactionManager.commit(status);
		}catch(Exception e){
			this.transactionManager.rollback(status);
			throw e;
		}
	}
	
	...
  }
  ```
	
### 5.4 메일 서비스 추상화
  - 5.1~5.3까지 TransactionManager를 통하여 서비스 추상화를 진행했다고 한다면, 서비스 추상화에 대해 Service interface를 가지고 메일 서비스를 추상화한 내용을 포함한다.
	
## 6장 AOP
  - 모든 Service 클래스 내에, PlatformTransactionManager를 멤버변수로 정의하고, 모든 메소드에 적용하기란 유지보수측면에서 비효율적이다.
  - 이를 AOP를 통해서 Service전역에 설정해주겠다는 얘기다.
  - 크게 설명을 적지는 않는다.
	
## 7장 스프링 핵심 기술의 응용
  - 공식문서 보면서 그때그때 필요한 내용을 참고하면 될것 같다.
	
### 7.1 SQL과 DAO의 분리
  - 뭐.. 쿼리를 분리한다는 내용인데, myBatis, iBatis등을 사용할 때 다시 보면 내부구현로직을 알 수 있을거 같으나.. 지금 내 시점으로는 영양가가 없음으로 패스

### 7.2 인터페이스의 분리와 자기참조 빈
  - 뭐..JAXB를 이용하여, 마샬링, 언마샬링을 설명한다.

### 7.3 서비스 추상화 적용
  - OXM 서비스 추상화를 예제로 한다.
	
### 7.4 인터페이스 상속을 통한 안전한 기능확장
  - DI를 많이 쓰라는 내용
	
### 7.5 DI를 이용해 다양한 구현 방법 적용하기
	
## 8장 스프링이란 무엇인가
### 8.3 POJO 프로그래밍
  - POJO의 개념을 설명하는데 한번 읽으면 괜찮을 뜻.
	
## 9장 스프링 프로젝트 시작하기
  - 그냥 IDE가 다 해준다.
	
	
---

# Spring Boot

## core
  - 참고사이트: [https://blog.woniper.net/336](https://blog.woniper.net/336)
  
  
### Spring Project creating
  - Spring Initializr 사용방법(2가지)
    ~~~
    1. Spring 공식 홈페이지(spring.io)에서 제공하는 기능을 사용합니다.
      1-1. spring.io 접속
      1-2. projects(상단메뉴) > spring boot(조회된 메뉴) > Quick start(상세 탭) > Spring Initializr 이용
       
      2. IDE(Intelli-J, STS 등)에서 제공하는 기능을 사용합니다.
        2-1. 각 tools마다 사용법 상이.
    ~~~
      
  - Spring Initializr Description
    ~~~
    - Project: Maven Project 또는 Gradle Project
      - 빌드, 베포 툴인 Maven과 Gradle 중 택
    - Language: Java, Kotlin, Groovy
    - Spring Boot: Spring Boot의 version
    - Project Metadata: group, artifact 등을 지정합니다.
      - 일반적으로 group은 project의 도메인 및 Default package 경로를 뜻하며, artifact는 프로젝트 명을 암시합니다.
    - Dependencies
      - 프로젝트의 의존성을 추가합니다. (간단히 소프트웨어의 플러그인 정도로 생각하면 됩니다.)

### Spring Boot Config
- 종류
  - spring.config.location
    Spring Boot 애플리케이션이 시작될 때 기본적으로 사용할 구성 파일의 위치를 지정합니다.
    이 속성을 설정하면, 지정한 경로에서 구성 파일을 로드하고 다른 경로에서 설정한 파일은 무시됩니다.
    예를 들어, spring.config.location=classpath:/custom-config/로 설정하면, 해당 경로에서만 설정 파일을 찾습니다.

  - spring.config.additional-location
    추가적인 설정 파일의 위치를 지정합니다.
    spring.config.location과 함께 사용되며, 기존의 기본 위치를 유지하면서 추가적으로 다른 파일을 로드합니다.
    예를 들어, spring.config.additional-location=classpath:/extra-config/로 설정하면, 기본 경로의 설정 파일을 로드한 뒤 추가 경로의 설정 파일도 함께 로드합니다.

  - spring.config.import
    다른 설정 파일을 가져오는 데 사용됩니다.
    주로 YAML 또는 프로퍼티 파일을 가져올 때 사용되며, 지정된 파일을 포함합니다.
    예를 들어, spring.config.import=optional:classpath:/external-config.yml와 같이 설정하면, 해당 파일을 조건부로 가져옵니다. 파일이 없으면 오류가 발생하지 않습니다.

- 개념
  - .properties
  - yaml
    - 파일명 또는 경로변경/추가
    ```console
    [user@localhost ~]# java -jar myproject.jar --spring.config.name=myproject.yaml
    --------------------------------------
      - Describe
        - 파일명 변경
        
        
    [user@localhost ~]# java -jar myproject.jar --spring.config.location=classpath:/myproject/{또는 파일명 변경 시, classpath:/myproject/myproject.yaml}
    --------------------------------------
      - Describe
        - 파일경로 변경
      - Result: 기존 4개 경로에서, Customizing된 경로 1개로 변경된다.
        - 기존 경로(4개)
          file:./config/
          file:./
          classpath:/config/
          classpath:/
        - Customizing되어 변경된 경로(1개)
          classpath:/myproject/
        
        
    [user@localhost ~]# java -jar myproject.jar --spring.config.additional-location=classpath:/custom-config/,file:./custom-config/
    --------------------------------------
      - Describe
        - 파일경로 추가
      - Result
        - file:./custom-config/
          classpath:custom-config/
          file:./config/
          file:./
          classpath:/config/
          classpath:/
    ```
  - 환경변수
  - command line args
      
  - 사용방법
  ```console
  [user@localhost ~]# java -jar -Dspring.profiles.active=dev board-0.0.1-SNAPSHOT.jar
    
  또는
    
  [user@localhost ~]# java -jar -Dspring-boot.run.profiles=dev board-0.0.1-SNAPSHOT.jar
  ```
      
- 참고사이트: [https://www.latera.kr/reference/java/2019-09-29-spring-boot-config-externalize/](https://www.latera.kr/reference/java/2019-09-29-spring-boot-config-externalize/)
  
### profiles with maven3
  - You can provide commandline argument like this:
  ```console
  mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
  ```
  - You can provide JVM argument like this:
  ```console
  mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=dev"
  ```
  - java -jar
  ```console
  java -Dspring.profiles.active=dev -jar app.jar (Note order)
  
  or
  
  java -jar app.jar --spring.profiles.active=dev (Note order)
  ```

### RequestParam, ModelAttribute, RequestBody, RequestPart
|               |Content-Type                                            |Binding                  |
|---------------|--------------------------------------------------------|-------------------------|
|@RequestParam  |QueryString                                             |Converter, PropertyEditor|
|@ModelAttribute|QueryString <br>application/json <br>multipart/form-data|Constructor/Setter       |
|@RequestBody   |application/json                                        |HttpMessageConverter     |
|@RequestPart   |application/json+@RequestBody                           |HttpMessageConverter     |

- Jackson Lib는 HttpMessageConverter를 확장한 lib이기 때문에, @ReqeustParam, @ModelAttribute는 @JsonProperty등이 적용되지 않는다.
- ExtendedServletRequestDataBinder

### Bean
#### Bean Hocker
##### BeanDefinitionRegistryPostProcessor
  - Bean 등록 목적
##### BeanFactoryPostProcessor
  - Bean 정의를 재정의 또는 속성추가 목적
##### BeanPostProcessor
  - Bean 인스턴스를 재정의 목적
  
  - 참고사이트: [https://thecodinglog.github.io/spring/2019/01/29/dynamic-spring-bean-registration.html](https://thecodinglog.github.io/spring/2019/01/29/dynamic-spring-bean-registration.html)

#### Conditional Bean Registration(조건부 빈 등록)
##### Java
  - 참고사이트: [https://sodocumentation.net/ko/spring/topic/4732/spring%EC%9D%98-%EC%A1%B0%EA%B1%B4%EB%B6%80-%EB%B9%88-%EB%93%B1%EB%A1%9D](https://sodocumentation.net/ko/spring/topic/4732/spring%EC%9D%98-%EC%A1%B0%EA%B1%B4%EB%B6%80-%EB%B9%88-%EB%93%B1%EB%A1%9D)
  ```console
  public class PropertyCondition implements Condition {
      @Override
      public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
          return context.getEnvironment().getProperty("propertyName") != null;
          // optionally check the property value
      }
  }

  @Configuration
  public class MyAppConfig {
      @Bean
      @Conditional(PropertyCondition.class)
      public MyBean myBean() {
        return new MyBean();
      }
  }

  @Configuration
  public class MyAppConfig {
      @Bean
      @Conditional({PropertyCondition.class, SomeOtherCondition.class})
      public MyBean myBean() {
        return new MyBean();
      }
  }
  ```

##### Annotation
###### Class Conditional
  - @ConditionalOnClass
  - @ConditionalOnMissingClass
  ```console
  @Bean
  @ConditionalOnWebApplication
  @ConditionalOnClass(OObjectDatabaseTx.class)
  @ConditionalOnMissingBean(OrientWebConfigurer.class)
  public OrientWebConfigurer orientWebConfigurer() {
      return new OrientWebConfigurer();
  }
  ```
  
###### Bean Conditional
  - @ConditionalOnBean
  - @ConditionalOnMissingBean
  
###### Property Conditional
  - @ConditionalOnProperty
  ```console
  @ConditionalOnProperty(value='somebean.enabled', matchIfMissing = true, havingValue="yes")
  @Bean 
  public SomeBean someBean(){
  }
  ```
  
###### Resource Conditional
  - @ConditionalOnResource
  ```console
  @ConditionalOnResource(resources = "classpath:init-db.sql") 
  ```
  
###### WebApplication Conditional
  - @@ConditionalOnWebApplication
  - @ConditionalOnNotWebApplication
  ```console
  @Configuration
  @ConditionalOnWebApplication
  public class MyWebMvcAutoConfiguration {...}
  ```
  
###### Expression Conditional
  - @ConditionalOnExpression
  ```console
  @ConditionalOnExpression("${rest.security.enabled}==false")
  ```

### Transactional
#### Prior knowledge
  - ACID(원자성, 일관성, 고립성, 지속성): transaction이 안전하게 수행된다는 것을 보장하기 위한 성질
    - Atomicity(원자성): 트랜잭션은 하나의 원자처럼 취급되어야 한다.
	                       즉 부분적으로 실행되어, 특정 부분만 반영되고 나머지는 반영되지 않으면 안된다는 뜻.
	                       예> 돈을 송금할 때, 송금하는 쪽은 성공하고 받는 쪽이 실패했다고 끝내면 안된다.
    - Consistency(일관성) : 트랜잭션이 실행을 성공적으로 완료하면 언제나 일관성 있는 Scheme 상태로 유지하는 것을 의미한다.
	                       예> 돈 100원을 송금할 때, 돈은 int형이여야 하지만 프로그램상 실수로 문자열 자료형으로 보냈을 경우, DB에 문자열 100이 저장되기 때문에 data의 일관성이 깨지기 때문에 트랜잭션이 취소되어야 한다.
    - Isolation(독립성)   : 트랜잭션을 수행 시 다른 트랜잭션의 연산 작업이 끼어들지 못하도록 독립되어 있다는 것을 보장한다.
	                         이것은 트랜잭션 밖에 있는 어떤 연산도 중간 단계의 데이터를 볼 수 없음을 의미한다.
	                         예> 법인카드의 잔여금액인 100원을 Read하여 총 3번 연산을 한다. 각 연산은 100원씩 증가를 시킨다.
	                             100 -> 200 -> 300 -> 400
	                             만약 300원째 계산을 하고 있을 때, 다른 사람이 잔여금액을 확인한다고 해도, 트랜잭션은 독립적으로 움직이기 때문에 100원으로 보인다.

    - Durability(지속성)  : 성공적으로 수행된 트랜잭션은 영원히 반영되어야 함을 의미하며, 시스템 문제, DB 일관성 체크 등을 하더라도 유지되어야 함을 의미한다.
	  			                  전형적으로 모든 트랜잭션은 로그로 남고 시스템 장애 발생 전 상태로 되돌릴 수 있다.
		  		                  트랜잭션은 로그에 모든 것이 저장된 후에만 commit 상태로 간주될 수 있다.
  
#### Transactional Annotation
##### Level
  - 0Lv, DEFAULT
  - 1Lv, READ_UNCOMMITED
  - 2Lv, READ_COMMITED
  - 3Lv, REPEATABLE_READ
  - 4Lv, SERIALIZABLE

  - 참고사이트: [https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation](https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation)

##### propagation
  - Spring의 @Transactional의 propagation 속성으로 다음과 같은 설정
  - Propagation
    - REQUIRED : 부모 트랜잭션 내에서 실행하며 부모 트랜잭션이 없을 경우 새로운 트랜잭션을 생성
    - REQUIRES_NEW : 부모 트랜잭션을 무시하고 무조건 새로운 트랜잭션이 생성
    - SUPPORT : 부모 트랜잭션 내에서 실행하며 부모 트랜잭션이 없을 경우 nontransactionally로 실행
    - MANDATORY : 부모 트랜잭션 내에서 실행되며 부모 트랜잭션이 없을 경우 예외가 발생
    - NOT_SUPPORT : nontransactionally로 실행하며 부모 트랜잭션 내에서 실행될 경우 일시 정지
    - NEVER : nontransactionally로 실행되며 부모 트랜잭션이 존재한다면 예외가 발생
    - NESTED : 해당 메서드가 부모 트랜잭션에서 진행될 경우 별개로 커밋되거나 롤백될 수 있음. 둘러싼 트랜잭션이 없을 경우 REQUIRED와 동일하게 작동

    - 참고사이트: [https://supawer0728.github.io/2018/03/22/spring-multi-transaction/](https://supawer0728.github.io/2018/03/22/spring-multi-transaction/)

## Spring Security

## Spring Validator
  - 참고싸이트: [https://kapentaz.github.io/spring/Spring-Boo-Bean-
	-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#](https://kapentaz.github.io/spring/Spring-Boo-Bean-Validation-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#)
  - 참고싸이트: [https://meetup.toast.com/posts/223](https://meetup.toast.com/posts/223)

## Spring Boot 2.4.x
  - 참고싸이트: [https://spring.io/blog/2020/11/12/spring-boot-2-4-0-available-now](https://spring.io/blog/2020/11/12/spring-boot-2-4-0-available-now)

### Properties
  - Kubernetes의 volume mounts를 지원하기 워해, Properties 설정하는 법이 변경되었다.(사실 무슨 뜻인지 모르겠다..)
  - 많은 특징들이 있는데, 실수할 수 있을만한 내용만 기재하며, 이하 공식문서를 참고하자.
  - yml문서 내에서 "---"으로 profile을 나눌 수 있었는데, properties문서 내에서도 "#---"으로 profile을 나누는게 가능해졌다.
  - The Problem with ConfigFileApplicationListener
    - include는 특정 profile이 적용된 곳에서 사용할 수 없다. 즉, on-profile 과 include 가 공존할 수 없다는 뜻.
    - 이유는.. 아래 싸이트의 링크를 접속 후, "The Problem with ConfigFileApplicationListener" 으로 검색하면 알 수 있다.
    - 참고싸이트: [https://spring.io/blog/2020/08/14/config-file-processing-in-spring-boot-2-4](https://spring.io/blog/2020/08/14/config-file-processing-in-spring-boot-2-4)
  - How to use ?
  ```
  mvn clean compile spring-boot:run -Dspring-boot.run.profile={spring.profiles.group의 key값}
  
  # application.yml
  spring:
    config:
      import: classpath:/example-config.yml
    profiles:
      group:
        default: local, logback, example		# 여기서 "example"은 example-config.yml의 'spring.config.activate.on-profile' 값
        local: local, logback
        dev: dev, logback
        prd: prd
      # include: example				# 여기서 "example"은 example-config.yml의 'spring.config.activate.on-profile' 값
      						# include는 사용하는 문서(여기서는 'application.yml')내에 바로 포함할 때 사용한다.
							# 즉, 해당 문서에서 사용할 경우 default, local, dev, prd모든 proilfe에 example이 포함된다.
	
	
  # application-local.yml
  
  
  # application-dev.yml
  
  
  # application-prd.yml
  
  
  # application-logback.yml
  spring:
    output:
      ansi:
        enabled: always

  logging:
    pattern:
      console: "%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-36logger{36} %clr([%-5level]) : %msg%n"
    level:
      root: info
      org.springframework: info
      com.example.demo: debug
      
      
  # example-config.yml
  # 더이상 반드시, application-{profile}.yml의 형태로 기입하지 않아도 된다.
  # 단, 'spring.config.activate.on-profile'으로 profile명을 기재해야 한다.
  spring:
    config:
      activate:
        on-profile: example
  ```


---

# JUnit 5
  - JUnit Platform: Test를 실행해주는 런처, TestEngine API를 제공한다.
  - Jupiter: JUnit 5를 지원하는 TestEngine API의 구현체
  - Vintage: JUnit 4, 3을 지원하는 TestEngine API의 구현체
	
## Annotation
  ```console
  @Disabled
      -> 테스트를 하고 싶지 않은 클래스나 메서드에 붙이는 어노테이션

  @DisplayName("IDE나 빌드툴에서 알아 볼 수 있도록")
      -> 어떤 테스트인지 쉽게 표현할 수 있도록 해주는 어노테이션

  @RepeatedTest( value = 10, name = " {displayName} 중 {currentRepetition} of {totalRepetitions}")
      -> 반복적으로 사용할 때 사용

  @ParameterizedTest
  @CsvSource(value = {"ACE,ACE:12", "ACE,ACE,ACE:13"}, delimiter = ':' )
      -> 테스트에 여러 다른 매개변수를 대입해가며 반복실행할 때 사용하는 어노테이션
  void calculateCardSumWhenAceIsTwo( final String input, final int expected ){
    final String[] inputs = input.split(",");
    for( final String number : inputs ) {
        final CardNumber cardNumber = CardNumber.valueOf(number);
	dealer.receiveOneCard( new Card(cardNumber, CardType.CLOVER) );
    }

    assertThat( dealer.calculateScore()).isEqualTo( expected );
  }

  @Nested
      -> 테스트 클래스 안에서 내부 클래스를 정의해 테스트를 계층화 할 때 사용

  * Assertions
    * example
      @Test
      void exceptionThrow(){
          Exception e = assertThrows(Exception.class, ()-> new Test(-10));
          assertDoesNotThrow( ()-> System.out.println("Do Something"));
      }

  * assertTimeout
    * Assumption
      * example
        void some_test(){
            assumingThat("DEV".equals(System.getenv("ENV")), () -> {
                assertEquals("A", "B");		// 단정문이 실행되지 않음
            });
            assertEquals("A", "A");			// 단정문이 실행됨
        }
  ```


---

# Validation
  - 참고싸이트: [https://kapentaz.github.io/spring/Spring-Boo-Bean-Validation-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#](https://kapentaz.github.io/spring/Spring-Boo-Bean-Validation-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#)
	

---
	
# Spring Cloud
## Resilience4j
### Refference Document
#### Documentation
[https://spring.io/projects/spring-cloud-circuitbreaker#learn](https://spring.io/projects/spring-cloud-circuitbreaker#learn)

#### Supported Implementations
[https://docs.spring.io/spring-cloud-commons/docs/current/reference/html/#introduction](https://docs.spring.io/spring-cloud-commons/docs/current/reference/html/#introduction)

### Documentation
[https://resilience4j.readme.io/docs/circuitbreaker](https://resilience4j.readme.io/docs/circuitbreaker)

### Properties Documentation
[https://resilience4j.readme.io/docs/circuitbreaker#create-and-configure-a-circuitbreaker](https://resilience4j.readme.io/docs/circuitbreaker#create-and-configure-a-circuitbreaker)
[https://resilience4j.readme.io/docs/getting-started](https://resilience4j.readme.io/docs/getting-started)
[https://godekdls.github.io/Resilience4j/contents/](https://godekdls.github.io/Resilience4j/contents/)

- ![circutibreaker](../Resource/Prog,%20Spring,%20Cloud,%20Resilience4j-circutibreaker.png)
