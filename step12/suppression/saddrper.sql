USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS DELETE_SADDRPER$$
 CREATE PROCEDURE DELETE_SADDRPER()
 BEGIN
  DECLARE fin INT; 
  DECLARE x  INT;
  DECLARE ROW_ID_V VARCHAR(15);
 SET x = 1;
 SET fin =  1;
 WHILE fin  <= 3600 DO
 SET ROW_ID_V = CONCAT('AD',x);
 SET  x = x + 1; 
 SET  fin = fin + 1; 
 DELETE FROM s_addr_per WHERE ROW_ID = ROW_ID_V;
 SELECT SLEEP(20);
 END WHILE;
 END$$
DELIMITER ;
CALL DELETE_SADDRPER();