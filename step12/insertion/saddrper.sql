USE db;
DELIMITER $$
 DROP PROCEDURE IF EXISTS INSERT_SADDRPER$$
 CREATE PROCEDURE INSERT_SADDRPER()
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
 SET fin =  3600;
 
 WHILE fin  <= 3600 DO
 SET ROW_ID_V = CONCAT('AD',x);
 SET ZIPCODE_V = CONCAT('7500',x);
 SET CITY_V = CONCAT("PARIS",x);
 SET LANDLORD_NAME_V = CONCAT("VALUE-",x);
 SET PR_PER_ADDR_ID_V = CONCAT('CONT-' , x);
 SET ADDR_LINE_2_V = CONCAT("VALUE-",x);
 SET COUNTRY_V = "FRANCE";
 SET ADDR_V = CONCAT(x, ", Rue Eugène POUBELLE");

 SET  x = x + 1; 
 INSERT INTO s_addr_per (   
  ROW_ID ,
  ZIPCODE ,
  CITY ,
  LANDLORD_NAME ,
  PR_PER_ADDR_ID ,
  ADDR_LINE_2 ,
  COUNTRY ,
  ADDR 
  ) 
 VALUES 
 (
  ROW_ID_V ,
  ZIPCODE_V ,
  CITY_V ,
  LANDLORD_NAME_V ,
  PR_PER_ADDR_ID_V ,
  ADDR_LINE_2_V ,
  COUNTRY_V ,
  ADDR_V
  );
 SELECT SLEEP(1);
 END WHILE;
 END$$
DELIMITER ;
CALL INSERT_SADDRPER();