DROP PROCEDURE IF EXISTS `proc_get_eid_fundingagencies_hei_validation`;
DELIMITER //
CREATE PROCEDURE `proc_get_eid_fundingagencies_hei_validation`
(IN filter_year INT(11), IN from_month INT(11), IN to_year INT(11), IN to_month INT(11), IN type INT(11), IN agency INT(11))
BEGIN
  SET @QUERY =    "SELECT
        SUM(`validation_confirmedpos`) AS `Confirmed Positive`,
        SUM(`validation_repeattest`) AS `Repeat Test`,
        SUM(`validation_viralload`) AS `Viral Load`,
        SUM(`validation_adult`) AS `Adult`,
        SUM(`validation_unknownsite`) AS `Unknown Facility`,
        SUM(`enrolled`+`ltfu`+`adult`+`transout`+`dead`+`other`) AS `followup_hei`, 
        sum(`actualinfantsPOS`) AS `positives`, 
        SUM(`actualinfants`-((`enrolled`+`ltfu`+`adult`+`transout`+`dead`+`other`)-(`validation_repeattest`+`validation_unknownsite`+`validation_adult`+`validation_viralload`))) AS `true_tests`";

    IF (from_month != 0 && from_month != '') THEN
      SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary` `ip` ");
    ELSE
        SET @QUERY = CONCAT(@QUERY, " FROM `ip_summary_yearly` `ip` ");
    END IF;

    SET @QUERY = CONCAT(@QUERY, " JOIN `partners` ON `partners`.`ID` = `ip`.`partner` WHERE 1");

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

    IF (type = 1) THEN
        SET @QUERY = CONCAT(@QUERY, " AND `partners`.`funding_agency_id` = '",agency,"' ");
    END IF;

     PREPARE stmt FROM @QUERY;
     EXECUTE stmt;
END //
DELIMITER ;