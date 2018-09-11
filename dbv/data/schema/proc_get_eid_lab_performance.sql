DROP PROCEDURE IF EXISTS `proc_get_lab_performance`;
DROP PROCEDURE IF EXISTS `proc_get_eid_lab_performance`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_lab_performance`
(IN filter_year INT(11))
BEGIN
  SET @QUERY =    "SELECT
                    `l`.`ID`, 
                    `l`.`labname` AS `name`, 
                    (`ls`.`alltests`) AS `tests`, 
                    (`ls`.`received`) AS `received`, 
                    `ls`.`pos`, 
                    `ls`.`neg`, 
                    `ls`.`rejected`, 
                    (`ls`.`pos` + `ls`.neg + `ls`.`confirmdna` + `ls`.repeatspos + `ls`.`tiebreaker`) AS `new_tests`,
                    `ls`.`month` 
                FROM `lab_summary` `ls`
                LEFT JOIN `labs` `l`
                ON `l`.`ID` = `ls`.`lab` 
                WHERE 1 ";

        SET @QUERY = CONCAT(@QUERY, " AND `ls`.`year` = '",filter_year,"' ");
  
  SET @QUERY = CONCAT(@QUERY, " ORDER BY `ls`.`month`, `l`.`ID` ");
  
    PREPARE stmt FROM @QUERY;
    EXECUTE stmt;
END //
DELIMITER ;
