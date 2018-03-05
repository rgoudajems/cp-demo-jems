# Objective 

Cdc, Avro, Json and Joins !

```sh

$ docker-compose exec connect curl -s -XPOST -H "Content-Type: application/json; charset=UTF-8" http://localhost:8083/connectors/ -d '
{
    "name": "debezium-connector-db",
    "config": {
        "connector.class": "io.debezium.connector.mysql.MySqlConnector",
        "tasks.max": "1",
        "database.hostname": "mysql",
        "database.port": "3306",
        "database.user": "debezium",
        "database.password": "dbz",
        "database.server.id": "1",
        "database.server.name": "dbserver1",
        "database.whitelist": "db",
        "database.history.kafka.bootstrap.servers": "kafka-1:9092,kafka-2:9092,kafka-3:9092",
        "database.history.kafka.topic": "schema-changes.db",
        "include.schema.changes": "false" ,
        "value.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter.schemas.enable": false,
        "key.converter": "org.apache.kafka.connect.json.JsonConverter",
        "key.converter.schemas.enable": false    
      }        
}'
```

Let's see the data

```
$ docker-compose exec kafka-1 kafka-topics --zookeeper zookeeper:2181 --list
connect-config
connect-offsets
connect-status
dbserver1.db.s_addr_per
dbserver1.db.s_contact
dbserver1.db.s_contact_x
dbserver1.db.s_resp
dbserver1.db.s_user
ksql__commands
schema-changes.db

$ docker-compose exec kafka-1 kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --topic dbserver1.db.s_contact

$ docker-compose exec kafka-1 kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --topic dbserver1.db.s_contact_x 

$ docker-compose exec kafka-1 kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --topic dbserver1.db.s_user

$ docker-compose exec kafka-1 kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --topic dbserver1.db.s_resp

$ docker-compose exec kafka-1 kafka-console-consumer \
    --bootstrap-server localhost:9092 \
    --from-beginning \
    --topic dbserver1.db.addr_per

```


Use ksql

```
---------------------------------------------------------------------------------S_CONTACT-----------------------------------------------------------


----------------ksql \
SET 'auto.offset.reset' = 'earliest';  \
----------------------------------Table s_contact \
PRINT 'dbserver1.db.s_contact' FROM BEGINNING; \
----------------------------------Stream s_contact_sdc
CREATE STREAM s_contact_cdc (schema varchar, payload varchar) \
WITH ( kafka_topic='dbserver1.db.s_contact',value_format='JSON');
----------------------------------Afficher la data
SELECT * FROM s_contact_cdc;
-----------------------------------Stream s_contact
drop STREAM s_contact__stream ;
-----------------------------
CREATE STREAM s_contact__stream AS SELECT \
        EXTRACTJSONFIELD(payload, '$.op') as cdc_operation, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ROW_ID') AS VARCHAR) as ROW_ID, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.SEND_NEWS_FLG') AS VARCHAR) as SEND_NEWS_FLG, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.HARD_TO_REACH') AS VARCHAR) as HARD_TO_REACH, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.SEX_MF') AS VARCHAR) as SEX_MF, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.X_DATE_ACCES_WEB') AS VARCHAR) as X_DATE_ACCES_WEB, \
        EXTRACTJSONFIELD(payload, '$.after.EMAIL_ADDR') as EMAIL_ADDR, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.FAX_PH_NUM') AS VARCHAR) as FAX_PH_NUM, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PRACTICE_TYPE') AS VARCHAR) as PRACTICE_TYPE, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.LAST_NAME') AS VARCHAR) as LAST_NAME, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.X_ACC_CONT_MAIL_FAX_FLG') AS VARCHAR) as X_ACC_CONT_MAIL_FAX_FLG, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PREF_COMM_METH_CD') AS VARCHAR) as PREF_COMM_METH_CD, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.FST_NAME') AS VARCHAR) as FST_NAME, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.SUPPRESS_MAIL_FLG') AS VARCHAR) as SUPPRESS_MAIL_FLG, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.SUPPRESS_CALL_FLG') AS VARCHAR) as SUPPRESS_CALL_FLG, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.WORK_PH_NUM') AS VARCHAR) as WORK_PH_NUM, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.CELL_PH_NUM') AS VARCHAR) as CELL_PH_NUM, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ASST_PH_NUM') AS VARCHAR) as ASST_PH_NUM, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PR_RESP_ID') AS VARCHAR) as S_RESP_ID , \
        CAST(EXTRACTJSONFIELD(payload, '$.after.COMMENTS') AS VARCHAR) as COMMENTS , \
        CAST(EXTRACTJSONFIELD(payload, '$.after.X_SUPPRIME_FLG') AS VARCHAR) as X_SUPPRIME_FLG , \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PR_ADDR_ID') AS VARCHAR) as PR_ADDR_ID ,\
        CAST(EXTRACTJSONFIELD(payload, '$.after.EMP_FLG') AS VARCHAR) as EMP_FLG , \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PRIV_FLG') AS VARCHAR) as PRIV_FLG \
    FROM s_contact_cdc \
    PARTITION BY  ROW_ID;
-------------------
DESCRIBE s_contact__stream;
---------------
SELECT * FROM s_contact__stream;
---------------
drop TABLE s_contact_table ;
------------------
CREATE TABLE s_contact_table ( \
        ROW_ID VARCHAR , \
        SEND_NEWS_FLG VARCHAR , \
        HARD_TO_REACH VARCHAR , \
        SEX_MF VARCHAR, \
        X_DATE_ACCES_WEB VARCHAR, \
        EMAIL_ADDR VARCHAR, \
        FAX_PH_NUM  VARCHAR , \
        PRACTICE_TYPE  VARCHAR, \
        LAST_NAME  VARCHAR, \
        X_ACC_CONT_MAIL_FAX_FLG  VARCHAR, \
        PREF_COMM_METH_CD VARCHAR, \
        FST_NAME VARCHAR, \
        SUPPRESS_MAIL_FLG VARCHAR, \
        SUPPRESS_CALL_FLG VARCHAR, \
        WORK_PH_NUM VARCHAR, \
        CELL_PH_NUM VARCHAR, \
        ASST_PH_NUM VARCHAR, \
        S_RESP_ID VARCHAR,\
        COMMENTS VARCHAR ,\
        X_SUPPRIME_FLG  VARCHAR ,\
        PR_ADDR_ID VARCHAR,\
        EMP_FLG VARCHAR , \
        PRIV_FLG VARCHAR  \
        ) \
        WITH (VALUE_FORMAT = 'JSON', \
            KAFKA_TOPIC = 'S_CONTACT__STREAM', \
            KEY = 'ROW_ID');

--------------------Jointure 1
CREATE STREAM  s_contact_s_user_stream AS SELECT sc.EMAIL_ADDR as  EMAIL_ADDR,\
su.LOGIN as LOGIN, sc.ROW_ID as s_contact_ROW_ID,\
su.ROW_ID as s_user_ROW_ID FROM S_CONTACT_STREAM sc LEFT JOIN s_user_table su ON sc.ROW_ID = su.ROW_ID PARTITION BY s_contact_ROW_ID; 




---------------------------------------------------------------------------------S_CONTACT_X-----------------------------------------------------------
--------------------------------------Stream s_contact_x_cdc
drop STREAM s_contact_x_cdc ;
--------------
 CREATE STREAM s_contact_x_cdc (schema varchar, payload varchar) \
    WITH ( kafka_topic='dbserver1.db.s_contact_x',value_format='JSON');
-----------------------Stream  s_contact_x_cdc
SELECT * FROM s_contact_x_cdc;
------------------------Stream s_contact_x_stream
drop STREAM s_contact_x_stream ;

-------------------------------------
CREATE STREAM s_contact_x_stream \
    AS SELECT \
        EXTRACTJSONFIELD(payload, '$.op') as cdc_operation, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ROW_ID') AS VARCHAR) as ROW_ID, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.PAR_ROW_ID') AS VARCHAR) as PAR_ROW_ID, \
        EXTRACTJSONFIELD(payload, '$.after.ATTRIB_37') as ATTRIB_37 \
    FROM s_contact_x_cdc \
    PARTITION BY ROW_ID;
------------------------Stream s_contact_x_stream
DESCRIBE s_contact_x_stream;

-----------------------------
SELECT * FROM s_contact_x_stream;

----------------------TABLE s_contact_x_table
drop TABLE s_contact_x_table;
---------------
CREATE TABLE s_contact_x_table (  ROW_ID VARCHAR, PAR_ROW_ID VARCHAR, ATTRIB_37 VARCHAR) \
        WITH (VALUE_FORMAT = 'JSON', \
            KAFKA_TOPIC = 'S_CONTACT_X_STREAM', \
            KEY = 'ROW_ID');

---------------------------------------------------------------------------------S_USER-----------------------------------------------------------
--------------------------------------Stream s_user_cdc
drop STREAM s__user_cdc ;
--------------
 CREATE STREAM s__user_cdc (schema varchar, payload varchar) \
    WITH ( kafka_topic='dbserver1.db.s_user',value_format='JSON');

-----------------------Stream  s_user_cdc
SELECT * FROM s__user_cdc;
------------------------Stream s_user_stream
drop STREAM s__user_stream ;

-------------------------------------
CREATE STREAM s__user_stream \
    AS SELECT \
        EXTRACTJSONFIELD(payload, '$.op') as cdc_operation, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ROW_ID') AS VARCHAR) as ROW_ID, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.LOGIN') AS VARCHAR) as LOGIN \
    FROM s__user_cdc \
    PARTITION BY ROW_ID;
------------------------Stream s_user_stream
DESCRIBE s_user_stream;

-----------------------------
SELECT * FROM s_user_stream;

----------------------TABLE s_contact_x_table
drop TABLE s_user_table;
---------------
CREATE TABLE s__user_table (  ROW_ID VARCHAR, LOGIN VARCHAR) \
        WITH (VALUE_FORMAT = 'JSON', \
            KAFKA_TOPIC = 'S__USER_STREAM', \
            KEY = 'ROW_ID');


---------------------------------------------------------------------------------S_ADDR_PER-----------------------------------------------------------
         drop  stream s_addr_per_cdc;
------------------------------------s_addr_per_cdc
CREATE STREAM s_addr_per_cdc (schema varchar, payload varchar) \
WITH ( kafka_topic='dbserver1.db.s_addr_per',value_format='JSON');

----------------------------------Afficher la data
SELECT * FROM s_addr_per_cdc;
-----------------------------------Stream s_user
drop STREAM s_addr_per_stream ;
------------------------Stream s_addr_per_stream
CREATE STREAM s_addr_per_stream \
    AS SELECT \
        EXTRACTJSONFIELD(payload, '$.op') as cdc_operation, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ROW_ID') AS VARCHAR) as ROW_ID, \
        EXTRACTJSONFIELD(payload, '$.after.ZIPCODE') as ZIPCODE, \
        EXTRACTJSONFIELD(payload, '$.after.CITY') as CITY, \
        EXTRACTJSONFIELD(payload, '$.after.LANDLORD_NAME') as LANDLORD_NAME, \
        EXTRACTJSONFIELD(payload, '$.after.PR_PER_ADDR_ID') as PR_PER_ADDR_ID, \
        EXTRACTJSONFIELD(payload, '$.after.ADDR_LINE_2') as ADDR_LINE_2, \
        EXTRACTJSONFIELD(payload, '$.after.COUNTRY') as COUNTRY, \
        EXTRACTJSONFIELD(payload, '$.after.ADDR') as  ADDR \
    FROM s_addr_per_cdc \
    PARTITION BY ROW_ID;

----------------------------
SELECT * FROM  s_addr_per_stream;

---------------TABLE S_ADDR_PER
drop TABLE s_addr_per_table ;

---------------
CREATE TABLE s_addr_per_table ( \
        ROW_ID VARCHAR , \
        ZIPCODE VARCHAR , \
        CITY VARCHAR , \
        LANDLORD_NAME VARCHAR , \
        PR_PER_ADDR_ID VARCHAR , \
        ADDR_LINE_2 VARCHAR , \
        COUNTRY VARCHAR , \
        ADDR VARCHAR) \
        WITH (VALUE_FORMAT = 'JSON', \
        KAFKA_TOPIC = 'S_ADDR_PER_STREAM', \
        KEY = 'ROW_ID');

----------------
SELECT * FROM  s_addr_per_table;




---------------------------------------------------------------------------------S_RESP-----------------------------------------------------------
         
------------------------------------s_resp
CREATE STREAM s__resp_cdc (schema varchar, payload varchar) \
WITH ( kafka_topic='dbserver1.db.s_resp',value_format='JSON');

----------------------------------Afficher la data
SELECT * FROM s_resp_cdc;
-----------------------------------Stream s_resp
drop STREAM s__resp_stream ;
------------------------Stream s_user_stream
CREATE STREAM s__resp_stream \
    AS SELECT \
        EXTRACTJSONFIELD(payload, '$.op') as cdc_operation, \
        CAST(EXTRACTJSONFIELD(payload, '$.after.ROW_ID') AS VARCHAR) as ROW_ID, \
        EXTRACTJSONFIELD(payload, '$.after.NAME') as NAME \
    FROM s_resp_cdc \
    PARTITION BY ROW_ID;

----------------------------
SELECT * FROM  s_resp_stream;

---------------TABLE S_RESP
drop TABLE s_resp_table ;

---------------
CREATE TABLE s__resp_table ( \
        ROW_ID VARCHAR , \
        NAME VARCHAR) \
        WITH (VALUE_FORMAT = 'JSON', \
        KAFKA_TOPIC = 'S_RESP_STREAM', \
        KEY = 'ROW_ID');

----------------
SELECT * FROM  s__resp_table;





-------------------------------------------------------------STREAM S_CONTACT ET S_CONTACT_X s_contact_s_contact_x------------------------------------------------------
CREATE STREAM s__contact_s_contact_x_stream \
    AS SELECT \
        sc.ROW_ID as ROW_ID, \
        sc.SEND_NEWS_FLG as SEND_NEWS_FLG, \
        sc.HARD_TO_REACH  as HARD_TO_REACH, \
        sc.SEX_MF as SEX_MF, \
        sc.X_DATE_ACCES_WEB as X_DATE_ACCES_WEB, \
        sc.EMAIL_ADDR as EMAIL_ADDR, \
        sc.FAX_PH_NUM  as FAX_PH_NUM, \
        sc.PRACTICE_TYPE  as PRACTICE_TYPE, \
        sc.LAST_NAME  as LAST_NAME, \
        sc.X_ACC_CONT_MAIL_FAX_FLG  as X_ACC_CONT_MAIL_FAX_FLG, \
        sc.PREF_COMM_METH_CD as PREF_COMM_METH_CD, \
        sc.FST_NAME as FST_NAME, \
        sc.SUPPRESS_MAIL_FLG as SUPPRESS_MAIL_FLG, \
        sc.SUPPRESS_CALL_FLG as SUPPRESS_CALL_FLG, \
        sc.WORK_PH_NUM as WORK_PH_NUM, \
        sc.CELL_PH_NUM as CELL_PH_NUM , \
        sc.ASST_PH_NUM as ASST_PH_NUM, \
        sc.S_RESP_ID as S_RESP_ID,\
        sc.COMMENTS as COMMENTS,\
        sc.X_SUPPRIME_FLG as X_SUPPRIME_FLG,\
        sc.PR_ADDR_ID as  PR_ADDR_ID,\
        sc.EMP_FLG  as EMP_FLG, \
        sc.PRIV_FLG as PRIV_FLG , \
        scxt.ROW_ID as S_CONTACT_X_ROW_ID, \
        scxt.PAR_ROW_ID as PAR_ROW_ID , \
        scxt.ATTRIB_37 as ATTRIB_37 \
FROM s_contact__stream sc LEFT JOIN s_contact_x_table scxt ON sc.ROW_ID = scxt.ROW_ID \
        WHERE scxt.ROW_ID IS NOT NULL  \
        PARTITION BY ROW_ID ;


-------------------------------------------------------------STREAM S_CONTACT ,S_CONTACT_X, S_USER--------------------------------------------------------------------
CREATE STREAM s__contact_s__contact_x_s_user_stream \
    AS SELECT \
        scscx.ROW_ID as ROW_ID, \
        scscx.SEND_NEWS_FLG as SEND_NEWS_FLG, \
        scscx.HARD_TO_REACH  as HARD_TO_REACH, \
        scscx.SEX_MF as SEX_MF, \
        scscx.X_DATE_ACCES_WEB as X_DATE_ACCES_WEB, \
        scscx.EMAIL_ADDR as EMAIL_ADDR, \
        scscx.FAX_PH_NUM  as FAX_PH_NUM, \
        scscx.PRACTICE_TYPE  as PRACTICE_TYPE, \
        scscx.LAST_NAME  as LAST_NAME, \
        scscx.X_ACC_CONT_MAIL_FAX_FLG  as X_ACC_CONT_MAIL_FAX_FLG, \
        scscx.PREF_COMM_METH_CD as PREF_COMM_METH_CD, \
        scscx.FST_NAME as FST_NAME, \
        scscx.SUPPRESS_MAIL_FLG as SUPPRESS_MAIL_FLG, \
        scscx.SUPPRESS_CALL_FLG as SUPPRESS_CALL_FLG, \
        scscx.WORK_PH_NUM as WORK_PH_NUM, \
        scscx.CELL_PH_NUM as CELL_PH_NUM , \
        scscx.ASST_PH_NUM as ASST_PH_NUM, \
        scscx.S_RESP_ID as S_RESP_ID,\
        scscx.COMMENTS as COMMENTS,\
        scscx.X_SUPPRIME_FLG as X_SUPPRIME_FLG,\
        scscx.PR_ADDR_ID as  PR_ADDR_ID,\
        scscx.EMP_FLG  as EMP_FLG, \
        scscx.PRIV_FLG as PRIV_FLG , \
        scscx.S_CONTACT_X_ROW_ID as S_CONTACT_X_ROW_ID, \
        scscx.PAR_ROW_ID as PAR_ROW_ID , \
        scscx.ATTRIB_37 as ATTRIB_37 ,\
        sut.ROW_ID as S_USER_ROW_ID,\
        sut.LOGIN as LOGIN \
FROM s__contact_s_contact_x_stream scscx LEFT JOIN s__user_table  sut ON scscx.ROW_ID = sut.ROW_ID \
        WHERE sut.ROW_ID IS NOT NULL  \
        PARTITION BY ROW_ID ;


-------------------------------------------------------------STREAM S_CONTACT ,S_CONTACT_X, S_USER , S_ADDR_PER---------------------------------------------------------
CREATE STREAM s__contact_s_contact_x_s_user_s_addr_per_stream \
    AS SELECT \
        scscxsu.ROW_ID as ROW_ID, \
        scscxsu.SEND_NEWS_FLG as SEND_NEWS_FLG, \
        scscxsu.HARD_TO_REACH  as HARD_TO_REACH, \
        scscxsu.SEX_MF as SEX_MF, \
        scscxsu.X_DATE_ACCES_WEB as X_DATE_ACCES_WEB, \
        scscxsu.EMAIL_ADDR as EMAIL_ADDR, \
        scscxsu.FAX_PH_NUM  as FAX_PH_NUM, \
        scscxsu.PRACTICE_TYPE  as PRACTICE_TYPE, \
        scscxsu.LAST_NAME  as LAST_NAME, \
        scscxsu.X_ACC_CONT_MAIL_FAX_FLG  as X_ACC_CONT_MAIL_FAX_FLG, \
        scscxsu.PREF_COMM_METH_CD as PREF_COMM_METH_CD, \
        scscxsu.FST_NAME as FST_NAME, \
        scscxsu.SUPPRESS_MAIL_FLG as SUPPRESS_MAIL_FLG, \
        scscxsu.SUPPRESS_CALL_FLG as SUPPRESS_CALL_FLG, \
        scscxsu.WORK_PH_NUM as WORK_PH_NUM, \
        scscxsu.CELL_PH_NUM as CELL_PH_NUM , \
        scscxsu.ASST_PH_NUM as ASST_PH_NUM, \
        scscxsu.S_RESP_ID as S_RESP_ID,\
        scscxsu.COMMENTS as COMMENTS,\
        scscxsu.X_SUPPRIME_FLG as X_SUPPRIME_FLG,\
        scscxsu.PR_ADDR_ID as PR_ADDR_ID,\
        scscxsu.EMP_FLG  as EMP_FLG, \
        scscxsu.PRIV_FLG as PRIV_FLG , \
        scscxsu.S_CONTACT_X_ROW_ID as S_CONTACT_X_ROW_ID, \
        scscxsu.PAR_ROW_ID as PAR_ROW_ID , \
        scscxsu.ATTRIB_37 as ATTRIB_37 ,\
        scscxsu.S_USER_ROW_ID as S_USER_ROW_ID,\
        scscxsu.LOGIN as LOGIN ,\
        sapt.ROW_ID as S_ADDR_PER_ROW_ID,\
        sapt.ZIPCODE as ZIPCODE ,\
        sapt.CITY as CITY ,\
        sapt.LANDLORD_NAME as LANDLORD_NAME ,\
        sapt.PR_PER_ADDR_ID as PR_PER_ADDR_ID ,\
        sapt.ADDR_LINE_2 as ADDR_LINE_2 ,\
        sapt.COUNTRY as COUNTRY ,\
        sapt.ADDR as ADDR \
FROM s__contact_s__contact_x_s_user_stream scscxsu LEFT JOIN s_addr_per_table sapt ON scscxsu.PR_ADDR_ID= sapt.ROW_ID \
        WHERE sapt.ROW_ID IS NOT NULL ;


-------------------------------------------------------------STREAM S_CONTACT ,S_CONTACT_X, S_USER , S_ADDR_PER , S_resp------------------------------------------------
CREATE STREAM JOINTURE_FINAL \
    AS SELECT \
        scscxsusap.ROW_ID as ROW_ID, \
        scscxsusap.SEND_NEWS_FLG as SEND_NEWS_FLG, \
        scscxsusap.HARD_TO_REACH  as HARD_TO_REACH, \
        scscxsusap.SEX_MF as SEX_MF, \
        scscxsusap.X_DATE_ACCES_WEB as X_DATE_ACCES_WEB, \
        scscxsusap.EMAIL_ADDR as EMAIL_ADDR, \
        scscxsusap.FAX_PH_NUM  as FAX_PH_NUM, \
        scscxsusap.PRACTICE_TYPE  as PRACTICE_TYPE, \
        scscxsusap.LAST_NAME  as LAST_NAME, \
        scscxsusap.X_ACC_CONT_MAIL_FAX_FLG  as X_ACC_CONT_MAIL_FAX_FLG, \
        scscxsusap.PREF_COMM_METH_CD as PREF_COMM_METH_CD, \
        scscxsusap.FST_NAME as FST_NAME, \
        scscxsusap.SUPPRESS_MAIL_FLG as SUPPRESS_MAIL_FLG, \
        scscxsusap.SUPPRESS_CALL_FLG as SUPPRESS_CALL_FLG, \
        scscxsusap.WORK_PH_NUM as WORK_PH_NUM, \
        scscxsusap.CELL_PH_NUM as CELL_PH_NUM , \
        scscxsusap.ASST_PH_NUM as ASST_PH_NUM, \
        scscxsusap.S_RESP_ID as S_RESP_ID,\
        scscxsusap.COMMENTS as COMMENTS,\
        scscxsusap.X_SUPPRIME_FLG as X_SUPPRIME_FLG,\
        scscxsusap.PR_ADDR_ID as PR_ADDR_ID,\
        scscxsusap.EMP_FLG  as EMP_FLG, \
        scscxsusap.PRIV_FLG as PRIV_FLG , \
        scscxsusap.S_CONTACT_X_ROW_ID as S_CONTACT_X_ROW_ID, \
        scscxsusap.PAR_ROW_ID as PAR_ROW_ID , \
        scscxsusap.ATTRIB_37 as ATTRIB_37 ,\
        scscxsusap.S_USER_ROW_ID as S_USER_ROW_ID,\
        scscxsusap.LOGIN as LOGIN ,\
        scscxsusap.ROW_ID as S_ADDR_PER_ROW_ID,\
        scscxsusap.ZIPCODE as ZIPCODE ,\
        scscxsusap.CITY as CITY ,\
        scscxsusap.LANDLORD_NAME as LANDLORD_NAME ,\
        scscxsusap.PR_PER_ADDR_ID as PR_PER_ADDR_ID ,\
        scscxsusap.ADDR_LINE_2 as ADDR_LINE_2 ,\
        scscxsusap.COUNTRY as COUNTRY ,\
        scscxsusap.ADDR as ADDR ,\
        srt.ROW_ID as S_RESP_ROW_ID ,\
        srt.NAME as NAME \
FROM s__contact_s_contact_x_s_user_s_addr_per_stream scscxsusap LEFT JOIN s__resp_table srt ON scscxsusap.S_RESP_ID= srt.ROW_ID \
        WHERE srt.ROW_ID IS NOT NULL \
        PARTITION BY ROW_ID ;
 
```
