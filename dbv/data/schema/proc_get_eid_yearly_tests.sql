DROP PROCEDURE IF EXISTS `proc_get_yearly_tests`;
DROP PROCEDURE IF EXISTS `proc_get_eid_yearly_tests`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_yearly_tests`
(IN county INT(11))
BEGIN
  SET @QUERY =    "SELECT
                    `cs`.`year`, `cs`.`month`, SUM(`cs`.`firstdna`) AS `tests`, 
                    SUM(`cs`.`pos`) AS `positive`,
                    SUM(`cs`.`neg`) AS `negative`,
                    SUM(`ns`.`allpos`) AS `allpositive`,
                    SUM(`ns`.`allneg`) AS `allnegative`,
                    SUM(`ns`.`rpos`) AS `rpos`,
                    SUM(`ns`.`rneg`) AS `rneg`,
                    SUM(`cs`.`rejected`) AS `rejected`,
                    SUM(`cs`.`infantsless2m`) AS `infants`,
                    SUM(`ns`.`infantsless2mPOS`) AS `infantspos`,
                    SUM(`cs`.`redraw`) AS `redraw`,
                    SUM(`cs`.`tat4`) AS `tat4`
                FROM `county_summary` `cs`
                WHERE 1 ";

      IF (county != 0 && county != '') THEN
           SET @QUERY = CONCAT(@QUERY, " AND `cs`.`county` = '",county,"' ");
      END IF;  

    
      SET @QUERY = CONCAT(@QUERY, " GROUP BY `cs`.`month`, `cs`.`year` ");

     
      SET @QUERY = CONCAT(@QUERY, " ORDER BY `cs`.`year` DESC, `cs`.`month` ASC ");
      

    PREPARE stmt FROM @QUERY;
    EXECUTE stmt;
END //
DELIMITER ;
