USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS MODIF_SCONTACT_X$$
 CREATE PROCEDURE MODIF_SCONTACT_X()
 BEGIN
 	DECLARE fin INT; 
 	DECLARE ROW_ID_V VARCHAR(15);
 	DECLARE PAR_ROW_ID_V VARCHAR(15);
 	DECLARE ATTRIB_37_V VARCHAR(50);
 	DECLARE x  INT;

 SET x = 1;
 SET fin =  3600;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V=CONCAT('CONT-' , x);
 SET ATTRIB_37_V="EDF ENTREPRISE";
 SET  x = x + 1; 
 UPDATE s_contact_x
 SET  ATTRIB_37 = ATTRIB_37_V
 WHERE ROW_ID = ROW_ID_V;
 SELECT SLEEP(10);
 END WHILE;
 END$$
DELIMITER ;
	
CALL MODIF_SCONTACT_X();
