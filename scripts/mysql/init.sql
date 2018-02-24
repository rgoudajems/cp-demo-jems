CREATE DATABASE IF NOT EXISTS db;

USE db;
/*---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Creation de la table S_CONTACT--------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS S_CONTACT (
  ROW_ID  VARCHAR(255) NOT NULL ,
  SEND_NEWS_FLG CHAR(1),
  HARD_TO_REACH CHAR(1),
  SEX_MF VARCHAR(30) ,
  X_DATE_ACCES_WEB DATE,
  EMAIL_ADDR VARCHAR(350),
  SEND_FIN_FLG CHAR(1),
  FAX_PH_NUM VARCHAR(40),
  PRACTICE_TYPE VARCHAR(30),
  LAST_NAME  VARCHAR(50) NOT NULL,
  X_ACC_CONT_MAIL_FAX_FLG CHAR(1),
  PREF_COMM_METH_CD VARCHAR(30),
  FST_NAME   VARCHAR(50) NOT NULL,
  SUPPRESS_MAIL_FLG  CHAR(1) NOT NULL,
  SUPPRESS_CALL_FLG  CHAR(1) NOT NULL,
  WORK_PH_NUM VARCHAR(40),
  CELL_PH_NUM VARCHAR(40),
  ASST_PH_NUM VARCHAR(40),
  PR_RESP_ID VARCHAR(15),
  COMMENTS VARCHAR(255),
  X_SUPPRIME_FLG CHAR(1)
);

/*---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Insertion d'une ligne  la table S_CONTACT---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO S_CONTACT  (
  ROW_ID ,
  SEND_NEWS_FLG ,
  HARD_TO_REACH ,
  SEX_MF ,
  X_DATE_ACCES_WEB ,
  EMAIL_ADDR ,
  SEND_FIN_FLG ,
  FAX_PH_NUM ,
  PRACTICE_TYPE ,
  LAST_NAME ,
  X_ACC_CONT_MAIL_FAX_FLG ,
  PREF_COMM_METH_CD ,
  FST_NAME ,
  SUPPRESS_MAIL_FLG ,
  SUPPRESS_CALL_FLG ,
  WORK_PH_NUM ,
  CELL_PH_NUM ,
  ASST_PH_NUM ,
  PR_RESP_ID ,
  COMMENTS ,
  X_SUPPRIME_FLG
) 
VALUES (
  '1' ,
  '1' ,
  '1' ,
  'HOMME' ,
  NOW() ,
  'test@gmail.com',
  '1',
  '0098652467896457' ,
  'test pratice type' ,
  'Polo',
  '1',
  '',
  'FST_NAME'  ,
  '1',
  '1',
  '00000366886444',
  '00000366886444',
  '00000366886444',
  '11' ,
  'COMMENTS ',
  '1'
);
/*---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Creation de la table S_ADDR_PER-------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS S_ADDR_PER (
  ROW_ID VARCHAR(15) NOT NULL ,
  ZIPCODE VARCHAR(30),
  CITY VARCHAR(50),
  LANDLORD_NAME VARCHAR(100),
  PR_PER_ADDR_ID VARCHAR(15),
  ADDR_LINE_2 VARCHAR(100),
  COUNTRY VARCHAR(30),
  ADDR VARCHAR(200)
);

/*---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------Creation de la table S_ADDR_PER-------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------*/
INSERT INTO S_ADDR_PER (
  ROW_ID ,
  ZIPCODE ,
  CITY ,
  LANDLORD_NAME ,
  PR_PER_ADDR_ID ,
  ADDR_LINE_2 ,
  COUNTRY ,
  ADDR 
) 
VALUES (
  '1' ,
  '78500' ,
  'SARTROUVILLE' ,
  'Jean DUPONT' ,
  'test' ,
  '10 rue Jacqueline Auriol 78500',
  'FRANCE',
  '10 rue Jacqueline Auriol 78500'
);