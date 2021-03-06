USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS DELETE_SRESP$$
 CREATE PROCEDURE DELETE_SRESP()
 BEGIN
 	DECLARE fin INT; 
 	DECLARE ROW_ID_V VARCHAR(15);
 	DECLARE x  INT;

 SET x = 1;
 SET fin =  1;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V=CONCAT(x,'-4ZJ7T');
 SET  x = x + 1; 
 SET  fin = fin + 1; 
 DELETE FROM s_resp WHERE ROW_ID = ROW_ID_V;

 SELECT SLEEP(20);
 END WHILE;

 END$$
DELIMITER ;
	
CALL DELETE_SRESP();