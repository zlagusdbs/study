# Spring
  - Spring MVC

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
