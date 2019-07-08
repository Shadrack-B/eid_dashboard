DROP PROCEDURE IF EXISTS `proc_get_eid_county_subcounties_details`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_county_subcounties_details`
(IN C_id INT(11), IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11))
BEGIN
  SET @QUERY =    "SELECT 
                  `d`.`name` AS `subcounty`,
                   `c`.`name` AS `county`,
                  SUM(`alltests`) AS `alltests`, 
                  AVG(`sitessending`) AS `sitessending`,
                  SUM(`actualinfants`) AS `actualinfants`, 
                   SUM(`pos`) AS `positive`, 
                  SUM(`neg`) AS `negative`, 
                  SUM(`repeatspos`) AS `repeatspos`,
                  SUM(`repeatposPOS`) AS `repeatsposPOS`,
                  SUM(`confirmdna`) AS `confirmdna`,
                  SUM(`confirmedPOS`) AS `confirmedPOS`,
                  SUM(`infantsless2w`) AS `infantsless2w`, 
                  SUM(`infantsless2wPOS`) AS `infantsless2wpos`, 
                  SUM(`infantsless2m`) AS `infantsless2m`, 
                  SUM(`infantsless2mPOS`) AS `infantsless2mpos`, 
                  SUM(`infantsabove2m`) AS `infantsabove2m`, 
                  SUM(`infantsabove2mPOS`) AS `infantsabove2mpos`, 
                  AVG(`medage`) AS `medage`,
                  SUM(`rejected`) AS `rejected`   ";


     IF (from_month != 0 && from_month != '') THEN
      SET @QUERY = CONCAT(@QUERY, " FROM `subcounty_summary` `scs` ");
    ELSE
        SET @QUERY = CONCAT(@QUERY, " FROM `subcounty_summary_yearly` `scs` ");
    END IF;

    SET @QUERY = CONCAT(@QUERY, " LEFT JOIN `districts` `d` ON `scs`.`subcounty` = `d`.`ID`
            LEFT JOIN `countys` `c` ON `d`.`county` = `c`.`ID`  WHERE 1 ");


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

    SET @QUERY = CONCAT(@QUERY, " AND `c`.`ID` = '",C_id,"' ");

    SET @QUERY = CONCAT(@QUERY, " GROUP BY `subcounty` ORDER BY `tests` DESC ");

     PREPARE stmt FROM @QUERY;
     EXECUTE stmt;
END //
DELIMITER ;

    