DROP PROCEDURE IF EXISTS `proc_get_eid_lab_tat`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_lab_tat`
(IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11))
BEGIN
  SET @QUERY =    "SELECT
                    `ls`.`lab`, `l`.`labname` AS `name`, AVG(`ls`.`tat1`) AS `tat1`,
                    AVG(`ls`.`tat2`) AS `tat2`, AVG(`ls`.`tat3`) AS `tat3`,
                    AVG(`ls`.`tat4`) AS `tat4`
                FROM `lab_summary` `ls`
                LEFT JOIN `labs` `l`
                ON `l`.`ID` = `ls`.`lab` 
                WHERE 1 ";


    IF (from_month != 0 && from_month != '') THEN
      IF (to_month != 0 && to_month != '' && filter_year = to_year) THEN
            SET @QUERY = CONCAT(@QUERY, " AND `year` = '",filter_year,"' AND `month` BETWEEN '",from_month,"' AND '",to_month,"' ");
        ELSE IF(to_month != 0 && to_month != '' && filter_year != to_year) THEN
          SET @QUERY = CONCAT(@QUERY, " AND ((`year` = '",filter_year,"' AND `month` >= '",from_month,"')  OR (`year` = '",to_year,"' AND `month` <= '",to_month,"') OR (`year` > '",filter_year,"' AND `year` < '",to_year,"')) ");
        ELSE
            SET @QUERY = CONCAT(@QUERY, " AND `year` = '",filter_year,"' AND `month`='",from_month,"' ");
        END IF;
    END IF;
    ELSE
        SET @QUERY = CONCAT(@QUERY, " AND `year` = '",filter_year,"' ");
    END IF;
      

  SET @QUERY = CONCAT(@QUERY, " GROUP BY `ls`.`lab` ");
    SET @QUERY = CONCAT(@QUERY, " ORDER BY `ls`.`lab` ");

    PREPARE stmt FROM @QUERY;
    EXECUTE stmt;
END //
DELIMITER ;
