USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS MODIF_SUSER$$
 CREATE PROCEDURE MODIF_SUSER()
 BEGIN

  DECLARE fin INT; 
  DECLARE x  INT;
  DECLARE ROW_ID_V VARCHAR(15);
  DECLARE LOGIN_V VARCHAR(50);
 	
 SET x = 1;
 SET fin =  3600;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V = CONCAT('CONT-' , x);
 SET LOGIN_V = CONCAT('EDF-LOGIN-',x);

 SET  x = x + 1; 
 UPDATE s_user
 SET  LOGIN = LOGIN_V
 WHERE ROW_ID = ROW_ID_V;
 SELECT SLEEP(10);
 END WHILE;
 END$$
DELIMITER ;
CALL MODIF_SUSER();