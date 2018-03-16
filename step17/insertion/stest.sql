USE MYSQL;
DELIMITER $$
 DROP PROCEDURE IF EXISTS INSERT_TEST$$
 CREATE PROCEDURE INSERT_TEST()
 BEGIN

  DECLARE fin INT; 
  DECLARE x  INT;
  DECLARE ROW_ID_V VARCHAR(255);
  DECLARE NOM_V VARCHAR(50);
  DECLARE PRENOM_V VARCHAR(50);
  DECLARE Date_Creation_V Date;
  DECLARE Date_Modification_V Date;
 	
 SET x = 1;
 SET fin =  1;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V = CONCAT('CONT-' , x);
 SET NOM_V = CONCAT('NOM-',x);
 SET PRENOM_V = CONCAT('PRENOM-',x);
 SET Date_Creation_V = NOW();
 SET Date_Modification_V = NOW();

 SET  x = x + 1; 
 SET  fin = fin + 1;
 INSERT INTO TEST (   
  ROW_ID ,
  NOM,
  PRENOM,
  Date_Creation,
  Date_Modification
  ) 
 VALUES 
 (
  ROW_ID_V ,
  NOM_V,
  PRENOM_V,
  Date_Creation_V,
  Date_Modification_V
  );
 SELECT SLEEP(1);
 END WHILE;
 END$$
DELIMITER ;
CALL INSERT_TEST();