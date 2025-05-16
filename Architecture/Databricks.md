# Databricks
- Unity Catalog
- Delta Lake
  - Delta Sharing
  - 성능최적화
- Delta Live Tables
- Workflow

---

# Unity Catalog
Governance Solution: 시스템 전반적으로 access control(접근제어), auditing(감사), lineage(계보), and data discovery(데이터 조회)를 통괄

## Unity Catalog Object Model
```
                                                               **Metastore**
                                                                     |
       ┌──────────────────────┬─────────────────────┬────────────────┼─────────┬──────────┬───────────┬────────────┬──────────────┐
Service Credential    Storage Credential    External Location    **Catalog**    Share    Recipient    Provider    Connection    Clean Room
                                                                     |
                                                                     |
                                                                 **Schema**
                                                                     |
                                                       ┌────────┬────┴────┬──────────┐
                                                      Table    View    Volumne    Function
```

## Reference
Unity Catalog: [https://docs.databricks.com/en/data-governance/unity-catalog/index.html](https://docs.databricks.com/en/data-governance/unity-catalog/index.html)  
the announcement blog: [https://www.databricks.com/blog/open-sourcing-unity-catalog](https://www.databricks.com/blog/open-sourcing-unity-catalog)  
Unity Catalog GitHub repo: [https://github.com/unitycatalog/unitycatalog/blob/main/README.md](https://github.com/unitycatalog/unitycatalog/blob/main/README.md)  

# Delta Lake
Lakehouse(=Data Lake+Data Warehouse)의 Architecture를 구축할 수 있는 근간이 되는 **오픈소스 스토리지 프레임워크**
S3, ADLS Gen2, GCS 스토리지기반의 데이터를을 테이블 단위로 저장하며, ACID Transacction 통해 신뢰할 수 있는 쿼리를 수행한다.
Aparche Spark와 통합되어 SQL, Python, Scala API 등을 활용하여 DML 작업한다.

## Lakehouse
Data Lake와 Data Warehouse의 통합. 즉, 비정형 데이터와 정형 데이터를 단일 위치에서 저장, 관리 및 분석하는 데이터 아키텍처 플랫폼.
Medallion Architecture를 사용한다.
  - Medallion Architecture: 전통적인 Layer(Staging, Base DW(Data Warehouse), Data Mart)를 새로운 Layer(Bronze(비정형), Silver(반정형), Gold(정형))로 정의하며, Data가 각 Layer를 통과하는 동안 데이터의 구조와 품질을 증분적, 점진적으로 개선할 수 있도록 한다.

## Delta Sharing
실제 데이터를 전송하는것이 아닌, 조회 권한을 전송함으로 데이터 공유 후에도 데이터 통제권을 갖을 수 있고, 데이터를 주고받는 과정에 네트워크 cost를 줄일 수 있다.

## 성능최적화
### Z-Order Clustering
Hive Style의 Partitioning을 대체하여 성능을 향상시키는 최적화 기법.
단, 대량의 I/O를 발생시키며, 테이블을 재작성하여 추가적인 Computing 비용을 발생시킨다.

### Liquid Clustering
Data를 동적으로 Clustering함과 동시에 최적화 작업을 진행하고, 증분데이터에 대해서만 I/O를 발생시킨다.

# Delta Live Tables
Streaming Data 또는 ETL Data를 처리하기 위한 **데이터 처리 프레임워크**
데이터 변환로직에 대해 Python, SQL로 정의하기만 하면 DLT 파이프라인 클러스터 관리, 데이터 품질 및 오류처리를 자동으로 처리
AutoLoader 기술을 통해 데이터의 증분 적재지원

# Workflow
Delta Live Tables 보다 더 높은 수준의 Orchestration Tool

