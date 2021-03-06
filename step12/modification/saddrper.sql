USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS MODIF_SADDRPER$$
 CREATE PROCEDURE MODIF_SADDRPER()
 BEGIN

  DECLARE fin INT; 
  DECLARE x  INT;
  DECLARE ROW_ID_V VARCHAR(15);
  DECLARE ZIPCODE_V VARCHAR(30);
  DECLARE CITY_V VARCHAR(50);
  DECLARE LANDLORD_NAME_V VARCHAR(100);
  DECLARE PR_PER_ADDR_ID_v VARCHAR(15);
  DECLARE ADDR_LINE_2_V VARCHAR(100);
  DECLARE COUNTRY_V VARCHAR(30);
  DECLARE ADDR_V VARCHAR(200);
  
 SET x = 1;
 SET fin =  1;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V = CONCAT('AD',x);
 SET ADDR_V = CONCAT(x, ", Rue Edouard Vaillant");

 SET  x = x + 1; 
 SET  fin = fin + 1;
 UPDATE s_addr_per
 SET  ADDR  = ADDR_V 
 WHERE ROW_ID = ROW_ID_V;
 SELECT SLEEP(10);
 END WHILE;
 END$$
DELIMITER ;
CALL MODIF_SADDRPER();