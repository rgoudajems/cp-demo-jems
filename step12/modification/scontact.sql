USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS MODIF_SCONTACT$$
 CREATE PROCEDURE MODIF_SCONTACT()
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
  SET SEX_MF_V = 'FEMININ';
  SET X_DATE_ACCES_WEB_V = NOW();
  SET EMAIL_ADDR_V = CONCAT('jeanne' , x, '.dupont@mail.com');
  SET FAX_PH_NUM_V = CONCAT('0761563629', x);
  SET LAST_NAME_V = CONCAT('DUPONT-' , x) ;
  SET FST_NAME_V = CONCAT('Jeanne-' , x) ;
  SET WORK_PH_NUM_V = CONCAT('0761563629', x);
  SET CELL_PH_NUM_V = CONCAT('0761563629', x);
  SET ASST_PH_NUM_V = CONCAT('0761563629', x);
  SET  x = x + 1; 
  SET  fin = fin + 1; 
  UPDATE s_contact
  SET  SEX_MF = SEX_MF_V, 
   X_DATE_ACCES_WEB = X_DATE_ACCES_WEB_V,
   EMAIL_ADDR = EMAIL_ADDR_V,
   FAX_PH_NUM = FAX_PH_NUM_V,
   LAST_NAME = LAST_NAME_V ,
   FST_NAME = FST_NAME_V,
   WORK_PH_NUM = WORK_PH_NUM_V,
   CELL_PH_NUM = CELL_PH_NUM_V,
   ASST_PH_NUM = ASST_PH_NUM_V
  WHERE ROW_ID = ROW_ID_V;
  SELECT SLEEP(10);
 END WHILE;

 END$$
DELIMITER ;
	
CALL MODIF_SCONTACT();


