DROP PROCEDURE IF EXISTS `proc_get_eid_tests_analysis`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_tests_analysis`
(IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11), IN type INT(11), IN ID INT(11))
BEGIN
  SET @QUERY =    "SELECT
        `join`.`name`,
        SUM(`main`.`pos`) AS `pos`,
        SUM(`main`.`neg`) AS `neg`,
        AVG(`main`.`medage`) AS `medage`,
        SUM(`main`.`alltests`) AS `alltests`,
        SUM(`main`.`eqatests`) AS `eqatests`,
        SUM(`main`.`firstdna`) AS `firstdna`,
        SUM(`main`.`confirmdna`) AS `confirmdna`,
        SUM(`main`.`confirmedPOS`) AS `confirmpos`,
        SUM(`main`.`repeatspos`) AS `repeatspos`,
        SUM(`main`.`pos`) AS `pos`,
        SUM(`main`.`neg`) AS `neg`,
        SUM(`main`.`repeatposPOS`) AS `repeatsposPOS`,
        SUM(`main`.`actualinfants`) AS `actualinfants`,
        SUM(`main`.`actualinfantsPOS`) AS `actualinfantspos`,
        SUM(`main`.`infantsless2m`) AS `infantsless2m`,
        SUM(`main`.`infantsless2mPOS`) AS `infantless2mpos`,
        SUM(`main`.`adults`) AS `adults`,
        SUM(`main`.`adultsPOS`) AS `adultsPOS`,
        SUM(`main`.`redraw`) AS `redraw`,
        SUM(`main`.`tests`) AS `tests`,
        SUM(`main`.`rejected`) AS `rejected`";

    IF (type = 0) THEN 
        IF (from_month != 0 && from_month != '') THEN
          SET @QUERY = CONCAT(@QUERY, " FROM `county_summary` `main` JOIN `countys` `join` ON `join`.`ID` = `main`.`county` WHERE 1 ");
        ELSE
            SET @QUERY = CONCAT(@QUERY, " FROM `county_summary_yearly` `main` JOIN `countys` `join` ON `join`.`ID` = `main`.`county` WHERE 1 ");
        END IF;
    END IF;
    IF (type = 1) THEN
        IF (from_month != 0 && from_month != '') THEN
          SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary` `main` JOIN `partners` `join` ON `join`.`ID` = `main`.`partner` WHERE `join`.`flag` = '1' ");
        ELSE
            SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary_yearly` `main` JOIN `partners` `join` ON `join`.`ID` = `main`.`partner` WHERE `join`.`flag` = '1' ");
        END IF;
    END IF;
    IF (type = 2) THEN
        IF (from_month != 0 && from_month != '') THEN
          SET @QUERY = CONCAT(@QUERY, " FROM `subcounty_summary` `main` JOIN `districts` `join` ON `join`.`ID` = `main`.`subcounty` WHERE 1 ");
        ELSE
            SET @QUERY = CONCAT(@QUERY, " FROM `subcounty_summary_yearly` `main` JOIN `districts` `join` ON `join`.`ID` = `main`.`subcounty` WHERE 1 ");
        END IF;
    END IF;
    IF (type = 3) THEN
        IF (from_month != 0 && from_month != '') THEN
          SET @QUERY = CONCAT(@QUERY, " FROM `site_summary` `main` JOIN `facilitys` `join` ON `join`.`ID` = `main`.`facility` WHERE 1 ");
        ELSE
            SET @QUERY = CONCAT(@QUERY, " FROM `site_summary_yearly` `main` JOIN `facilitys` `join` ON `join`.`ID` = `main`.`facility` WHERE 1 ");
        END IF;
    END IF;
    IF (type = 4) THEN
        IF (ID = 0) THEN
            IF (from_month != 0 && from_month != '') THEN
              SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary` `main` JOIN `partners` `trans` ON `trans`.`ID` = `main`.`partner` JOIN `funding_agencies` `join` ON `join`.`ID` = `trans`.`funding_agency_id` WHERE 1 ");
            ELSE
                SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary_yearly` `main` JOIN `partners` `trans` ON `trans`.`ID` = `main`.`partner` JOIN `funding_agencies` `join` ON `join`.`ID` = `trans`.`funding_agency_id` WHERE 1 ");
            END IF;
        ELSE
            IF (from_month != 0 && from_month != '') THEN
              SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary` `main` JOIN `partners` `join` ON `join`.`ID` = `main`.`partner` WHERE `join`.`funding_agency_id` = '",ID,"' ");
            ELSE
                SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary_yearly` `main` JOIN `partners` `join` ON `join`.`ID` = `main`.`partner` WHERE `join`.`funding_agency_id` = '",ID,"' ");
            END IF;
        END IF;
    END IF;

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

    SET @QUERY = CONCAT(@QUERY, " GROUP BY `name` ORDER BY `firstdna` DESC ");

     PREPARE stmt FROM @QUERY;
     EXECUTE stmt;
END //
DELIMITER ;
