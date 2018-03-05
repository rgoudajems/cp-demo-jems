USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS INSERT_SCONTACT$$
 CREATE PROCEDURE INSERT_SCONTACT()
 BEGIN
  DECLARE fin INT; 
  DECLARE ROW_ID_V VARCHAR(255);
  DECLARE SEND_NEWS_FLG_V CHAR(1);
  DECLARE HARD_TO_REACH_V CHAR(1);
  DECLARE SEX_MF_V VARCHAR(30);
  DECLARE X_DATE_ACCES_WEB_V DATE;
  DECLARE EMAIL_ADDR_V VARCHAR(350);
  DECLARE SEND_FIN_FLG_V CHAR(1);
  DECLARE FAX_PH_NUM_V VARCHAR(40);
  DECLARE PRACTICE_TYPE_V VARCHAR(30);
  DECLARE LAST_NAME_V  VARCHAR(50);
  DECLARE X_ACC_CONT_MAIL_FAX_FLG_V CHAR(1);
  DECLARE PREF_COMM_METH_CD_V VARCHAR(30);
  DECLARE FST_NAME_V   VARCHAR(50);
  DECLARE SUPPRESS_MAIL_FLG_V  CHAR(1);
  DECLARE SUPPRESS_CALL_FLG_V  CHAR(1);
  DECLARE WORK_PH_NUM_V VARCHAR(40);
  DECLARE CELL_PH_NUM_V VARCHAR(40);
  DECLARE ASST_PH_NUM_V VARCHAR(40);
  DECLARE PR_RESP_ID_V VARCHAR(15);
  DECLARE COMMENTS_V VARCHAR(255);
  DECLARE X_SUPPRIME_FLG_V CHAR(1);
  DECLARE PR_ADDR_ID_V VARCHAR(15);
  DECLARE EMP_FLG CHAR(1);
  DECLARE PRIV_FLG CHAR(1);
  DECLARE x  INT;

 SET x = 1;
 SET fin =  1;
 WHILE fin  <= 3600 DO

  SET ROW_ID_V = CONCAT('CONT-' , x);
  SET SEND_NEWS_FLG_V = 'N';
  SET HARD_TO_REACH_V = 'N';
  SET SEX_MF_V = 'MASCULIN';
  SET X_DATE_ACCES_WEB_V = NOW();
  SET EMAIL_ADDR_V = CONCAT('robert' , x, '.trousseau@mail.com');
  SET SEND_FIN_FLG_V = 'N';
  SET FAX_PH_NUM_V = CONCAT('0761253628', x);
  SET PRACTICE_TYPE_V = CONCAT('VALUE-', x);
  SET LAST_NAME_V = CONCAT('TROUSSEAU-' , x) ;
  SET X_ACC_CONT_MAIL_FAX_FLG_V = "N";
  SET PREF_COMM_METH_CD_V = CONCAT('VALUE-', x);
  SET FST_NAME_V = CONCAT('Robert-' , x) ;
  SET SUPPRESS_MAIL_FLG_V  = 'N';
  SET SUPPRESS_CALL_FLG_V  = "N";
  SET WORK_PH_NUM_V = CONCAT('0761253628', x);
  SET CELL_PH_NUM_V = CONCAT('0761253628', x);
  SET ASST_PH_NUM_V = CONCAT('0761253628', x);
  SET PR_RESP_ID_V = CONCAT(x,'-4ZJ7T');
  SET COMMENTS_V = CONCAT('COMMENT-', x);
  SET X_SUPPRIME_FLG_V = "N";
  SET PR_ADDR_ID_V = CONCAT('AD',x);
  SET EMP_FLG = "N";
  SET PRIV_FLG = "N";
  SET  x = x + 1; 
  SET  fin = fin + 1;
  INSERT INTO s_contact ( 
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
  X_SUPPRIME_FLG, 
  PR_ADDR_ID,
  EMP_FLG,
  PRIV_FLG
  ) 
  VALUES (
  ROW_ID_V ,
  SEND_NEWS_FLG_V,
  HARD_TO_REACH_V ,
  SEX_MF_V,
  X_DATE_ACCES_WEB_V ,
  EMAIL_ADDR_V ,
  SEND_FIN_FLG_V ,
  FAX_PH_NUM_V ,
  PRACTICE_TYPE_V ,
  LAST_NAME_V ,
  X_ACC_CONT_MAIL_FAX_FLG_V ,
  PREF_COMM_METH_CD_V ,
  FST_NAME_V ,
  SUPPRESS_MAIL_FLG_V  ,
  SUPPRESS_CALL_FLG_V ,
  WORK_PH_NUM_V ,
  CELL_PH_NUM_V ,
  ASST_PH_NUM_V ,
  PR_RESP_ID_V ,
  COMMENTS_V ,
  X_SUPPRIME_FLG_V ,
  PR_ADDR_ID_V ,
  EMP_FLG ,
  PRIV_FLG 
  );

  SELECT SLEEP(1);
 END WHILE;

 END$$
DELIMITER ;
	
CALL INSERT_SCONTACT();


