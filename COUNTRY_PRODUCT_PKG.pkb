/*
	File Name: COUNTRY_PRODUCT_PKG.pkb
	Creation Date: 14-NOV-2025
	Created By: Nathan
*/
create or replace PACKAGE BODY COUNTRY_PRODUCT_PKG 
IS
    PROCEDURE GET_COUNTRY_DETAIL (p_country_id IN varchar2) AS 
        -- PLSQL Variables used to store single value
        lv_country_name ot.countries.country_name%TYPE;
        lv_region_name ot.regions.region_name%TYPE;
        lv_country_id CHAR(2) := p_country_id;

    BEGIN
        SELECT cty.country_name, reg.region_name INTO lv_country_name, lv_region_name 
         FROM ot.countries cty
            , ot.regions reg
         WHERE reg.region_id = cty.region_id
         AND country_id=lv_country_id;

            dbms_output.put_line('Country Name:'||lv_country_name||', Region Name:'||lv_region_name);
    END GET_COUNTRY_DETAIL;

    FUNCTION get_profit_amount (p_product_id NUMBER) RETURN number
    IS
       -- declarative section
       lv_product_id NUMBER:= p_product_id;
       lv_profit_amount NUMBER:=0;
    BEGIN
       -- executable section
       SELECT list_price - standard_cost INTO lv_profit_amount FROM products
        WHERE product_id = lv_product_id;

       RETURN lv_profit_amount;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN 0;
    END get_profit_amount;

END COUNTRY_PRODUCT_PKG;
