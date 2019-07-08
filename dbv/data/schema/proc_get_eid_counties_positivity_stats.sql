DROP PROCEDURE IF EXISTS `proc_get_eid_counties_positivity_stats`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_counties_positivity_stats`
(IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11))
BEGIN
  SET @QUERY =  "SELECT 
                    `c`.`name`,
                    SUM(`actualinfantsPOS`) AS `pos`,
                    SUM(`actualinfants`-`actualinfantsPOS`) AS `neg`,
                    ((SUM(`actualinfantsPOS`)/(SUM(`actualinfants`)))*100) AS `pecentage`";

    IF (from_month != 0 && from_month != '') THEN
      SET @QUERY = CONCAT(@QUERY, " FROM `county_summary` `cs` ");
    ELSE
        SET @QUERY = CONCAT(@QUERY, " FROM `county_summary_yearly` `cs` ");
    END IF;

    SET @QUERY = CONCAT(@QUERY, " LEFT JOIN countys `c`
                    ON c.ID = cs.county WHERE 1 ");

   
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

    SET @QUERY = CONCAT(@QUERY, " GROUP BY `c`.`name` ORDER BY `pecentage` DESC ");

    PREPARE stmt FROM @QUERY;
    EXECUTE stmt;
    
END //
DELIMITER ;
