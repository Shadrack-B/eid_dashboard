DROP PROCEDURE IF EXISTS `proc_get_eid_lab_performance_stats`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_lab_performance_stats`
(IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11))
BEGIN
  SET @QUERY =    "SELECT 
                    `l`.`labname` AS `name`, 
                    AVG(`ls`.`sitessending`) AS `sitesending`, 
                    SUM(`ls`.`batches`) AS `batches`, 
                    SUM(`ls`.`received`) AS `received`, 
                    SUM(`ls`.`tests`) AS `tests`, 
                    SUM(`ls`.`alltests`) AS `alltests`,  
                    SUM(`ls`.`rejected`) AS `rejected`,  
                    SUM(`ls`.`confirmdna`) AS `confirmdna`,  
                    SUM(`ls`.`confirmedPOs`) AS `confirmedpos`,
                    SUM(`ls`.`tiebreaker`) AS `tiebreaker`,
                    SUM(`ls`.`tiebreakerPOS`) AS `tiebreakerPOS`,
                    SUM(`ls`.`fake_confirmatory`) AS `fake_confirmatory`,
                    SUM(`ls`.`repeatspos`) AS `repeatspos`,  
                    SUM(`ls`.`repeatposPOS`) AS `repeatspospos`,
                    SUM(`ls`.`eqatests`) AS `eqa`, 
                    SUM(`ls`.`controls`) AS `controls`,  
                    SUM(`ls`.`pos`) AS `pos`, 
                    SUM(`ls`.`neg`) AS `neg`, 
                    SUM(`ls`.`redraw`) AS `redraw` 
                  FROM `lab_summary` `ls` LEFT JOIN `labs` `l` ON `ls`.`lab` = `l`.`ID` 
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

      SET @QUERY = CONCAT(@QUERY, " GROUP BY `ls`.`lab` ORDER BY `alltests` DESC ");
      

    PREPARE stmt FROM @QUERY;
    EXECUTE stmt;
END //
DELIMITER ;
