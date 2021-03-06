USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS INSERT_SCONTACT_X$$
 CREATE PROCEDURE INSERT_SCONTACT_X()
 BEGIN
 	DECLARE fin INT; 
 	DECLARE ROW_ID_V VARCHAR(15);
 	DECLARE PAR_ROW_ID_V VARCHAR(15);
 	DECLARE ATTRIB_37_V VARCHAR(50);
 	DECLARE x  INT;

 SET x = 1;
 SET fin =  1;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V=CONCAT('CONT-' , x);
 SET PAR_ROW_ID_V=CONCAT('CONT-' , x);
 SET ATTRIB_37_V=CONCAT('ATTRIB_37-',x);
 SET  x = x + 1; 
 SET fin = fin + 1;
 INSERT INTO s_contact_x ( ROW_ID, PAR_ROW_ID , ATTRIB_37) VALUES ( ROW_ID_V , PAR_ROW_ID_V, ATTRIB_37_V );
 SELECT SLEEP(1);
 END WHILE;

 END$$
DELIMITER ;
	
CALL INSERT_SCONTACT_X();
