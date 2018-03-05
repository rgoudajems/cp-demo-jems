USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS INSERT_SRESP$$
 CREATE PROCEDURE INSERT_SRESP()
 BEGIN
 	DECLARE fin INT; 
 	DECLARE ROW_ID_V VARCHAR(15);
 	DECLARE NAME_V VARCHAR(15);
 	DECLARE x  INT;

 SET x = 1;
 SET fin =  1;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V=CONCAT(x,'-4ZJ7T');
 SET NAME_V=CONCAT(x, '-Manager');
 SET  x = x + 1; 
 SET  x = fin + 1; 
 INSERT INTO s_resp ( ROW_ID,  NAME ) VALUES ( ROW_ID_V , NAME_V );
 SELECT SLEEP(1);
 END WHILE;

 END$$
DELIMITER ;
	
CALL INSERT_SRESP();