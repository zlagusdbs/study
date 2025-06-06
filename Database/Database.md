# Database
- Oracle
- MySQL
- PostgreSQL
- Partitioning / Sharding

cf> [동시성](../Backend/%5BTheory%5D%20%EB%8F%99%EC%8B%9C%EC%84%B1.md#동기화동시성-제어-기법)관련 내용을 참고해도 좋다.

---

# Oracle


---

# MySQL

---

# PostgreSQL
## System
### INFORMATION_SCHEMA
- SQL 표준에 의해 정의.
- 꼭 postgreSQL이 아닌, 다른 DBMS에서도 사용가능할 확률이 높다.
- 단, postgreSQL에서 INFORMATION_SCHEMA의 영역을 벗어난 경우가 존재함으로 PG_CATALOG를 참조해야 하는 경우가 있다.

### PG_CATALOG
- postgreSQL 표준에 의해 정의.
- 완전히 postgreSQL에 고유하며, 모든 시스템 테이블과 뷰를 제공한다.

## Query
- example1: 계층쿼리
```
with  recursive  sm_upper_menu( lv, depth, menu_id, upper_menu_id, menu_dc, root_ordr, ordr )  as  (
    select  1::numeric  as  lv
           ,concat(menu_id, '-', '1')  as  depth
           ,menu_id
           ,upper_menu_id 
           ,menu_dc
           ,ordr  as  root_ordr
           ,ordr
      from  svcm.sm_menu  sm_upper_menu
     where  sm_upper_menu.upper_menu_id is null or sm_upper_menu.upper_menu_id = ''
     union  all
    select  (lv+1)::numeric  as  lv
           ,concat(sm_upper_menu.depth, '-', (lv+1)) as  depth
           ,sm_menu.menu_id
           ,sm_menu.upper_menu_id
           ,sm_menu.menu_dc
           ,sm_upper_menu.root_ordr
           ,sm_menu.ordr
      from  sm_upper_menu  sm_upper_menu
            inner join  svcm.sm_menu  as  sm_menu
                    on  sm_upper_menu.menu_id = sm_menu.upper_menu_id 
)
select  *
  from  sm_upper_menu
 order  by root_ordr asc, depth asc, ordr asc
;
```

- example2: 전체테이블 및 컬럼명 조회
```
select  swaf_columns.table_catalog
           ,swaf_columns.table_schema
           ,swaf_columns.table_name
           ,swaf_tables.table_desc
           ,swaf_columns.column_name
           ,swaf_tables.objsub_id
      from  -- Table 조회
            (
                select  psat.relid       as  relid
                       ,psat.schemaname  as  schema_name
                       ,psat.relname     as  table_name
                       ,pd.description   as  table_desc
                       ,pd.objsubid      as  objsub_id
                  from  pg_catalog.pg_statio_all_tables psat
                        inner join  pg_catalog.pg_description pd
                                on  psat.relid = pd.objoid
               where  schemaname = 'us_swafcom'
            )  swaf_tables
            inner join  (
                            select  *
                              from  information_schema.columns
                        )  swaf_columns
                    on  swaf_tables.schema_name = swaf_columns.table_schema
                   and  swaf_tables.table_name = swaf_columns.table_name
                   and  swaf_tables.objsub_id = swaf_columns.ordinal_position
 order  by table_catalog, table_schema, table_name, objsub_id asc
;
```

## PL/SQL
- example1
```
do $$
declare
    v_db_name             varchar(200) := 'svcm';
    v_table_name          varchar(200) := 'sm_ctmmny';

    v_dmn_conect_url_cnt  integer := 0;
    v_dmn_conect_url      varchar(200) := 'https://svcm-fo.spharos-dev.mycloudmembership.com/';
begin
    raise notice '========== plsql 실행합니다.[%] ==========', v_dmn_conect_url;

    select count(*)
      into v_dmn_conect_url_cnt
      from information_schema.columns
     where table_catalog = v_db_name
       and table_name    = v_table_name
    ;

    if v_dmn_conect_url_cnt < 0 then
        raise notice '= add column dmn_conect_url';
        alter table svcm.sm_ctmmny add column dmn_conect_url varchar(200);
    end if;


    raise notice '= set column value';
    update
        svcm.sm_ctmmny
    set
        dmn_conect_url = v_dmn_conect_url;


    raise notice '= set column dmn_conect_url set not null';
    alter table svcm.sm_ctmmny alter column dmn_conect_url set not null;
end $$;
```

- example2: record 사용
```
do $$
declare
    mber_info    record;
begin
    for mber_info in (
                           select  paum.mber_no
                             from  (
                                       select  pud.mber_no
                                         from  point.point_use_dtls pud
                                        group  by pud.mber_no
                                   ) paum
                            where  paum.mber_no is not null
                      )

    loop
        raise notice 'mber_no: %s', mber_info.mber_no::text;


    end loop;
end $$;
```

- example3: cursor 사용
```
do $$
declare
    cur_mber        cursor for select  pud.mber_no
                                 from  (
                                           select  pud.mber_no
                                             from  point.point_use_dtls pud
                                            group  by pud.mber_no
                                       ) pud
                                where  pud.mber_no is not null;
    r_mber          record;
begin
    for r_mber in cur_mber
    loop
        raise notice 'mber_no: %s', r_mber.mber_no::text;
    end loop;
end $$;
```

## Reference
- PostgreSQL: [https://www.postgresql.org/docs/](https://www.postgresql.org/docs/)
- PostgreSQL plpgsql: [https://postgresql.kr/docs/9.3/plpgsql.html](https://postgresql.kr/docs/9.3/plpgsql.html)

# Partitioning / Sharding
## Partitioning
수평분할(스키마가 같은 데이터를 물리적으로 여러 테이블로 분산하여 저장하는 방식)방식이다.

- List Partitioning
  - 데이터 값이 특정 목록에 포함된 경우 데이터를 분리
  - ex> 1..9 데이터가 있을 때, 짝수 또는 홀수로 분리

- Range Partitioning
  - 데이터를 특정 범위 기준으로 분할할 때 사용한다.
  - ex> 1..9 데이터가 있을 때, 중간값 미만 또는 중간값 이상으로 분리

- Hash Partitioning
  - 해시 함수를 사용해서 데이터를 분할한다.
  - 특정 컬럼의 값을 해싱하여 저장할 파티션을 선택한다
  - 단, 여러 컬럼으로 해싱하는 것은 권장하지 않는다.
    - ref. https://dev.mysql.com/doc/mysql-partitioning-excerpt/8.0/en/partitioning-hash.html

## Sharding
동일한 스키마를 가지고 있는 **여러대의 데이터베이스 서버들**에 데이터를 작은 단위로 나누어 분산 저장하는 방식이다.
이때 작은 단위를 샤드(shard)라고 부른다.

ref. https://d2.naver.com/helloworld/14822

- 애플리케이션 서버에서 이용하는 전략
  - Proxysql(in spring boot)
    - JpaTransactionManager와의 호환 불량

- 미들티어(샤딩 플랫폼)를 이용한 전략
  - Spck Proxy(in MySQL Proxy)
  - CUBRID Shard(in NHN Platform)
  - Gizzard(in Twitter)

- 데이터베이스 자체 전략
  - List Sharding
    - 명시적으로 값을 정의
    - 김xx -> 샤드1, 정xx -> 샤드2

  - Range Sharding
    - PK 값을 범위로 지정하여 샤드를 결정하는 방식
    - 데이터베이스 증설 작업에 큰 리소스가 소요되지 않기 때문에 급격히 증가할 수 있는 성격의 데이터에 알맞은 방식이다.

  - Hash Sharding
    - Modular Sharding(=Key-Based Sharding)
      - PK 값의 모듈러 연산 결과를 통해 샤드를 결정하는 방식이다.
      - 총 데이터베이스 수가 정해져있을 때 유용하다.
      - 단, 데이터베이스 개수가 줄어들거나 늘어나면 해시 함수도 변경해야 하고, 이에 따른 데이터의 재정렬도 필요하다.

  - Directory Sharding
    - 샤딩 정보를 별도 디렉토리 테이블에서 관리