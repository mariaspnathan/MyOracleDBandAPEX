--Version 2.0
select * from v$database;
select * from v$instance;
select * from dba_objects where object_name = 'HALITS_AUTHENTICATION';
SELECT status, version FROM dba_registry WHERE comp_id = 'APEX';
SELECT * FROM dba_roles WHERE role LIKE 'APEX_ADMIN%';
GRANT APEX_ADMINISTRATOR_ROLE TO TRAINEES;
SELECT * FROM session_roles WHERE role = 'APEX_ADMINISTRATOR_ROLE'; -- if not enable then set it for current session
SET ROLE APEX_ADMINISTRATOR_ROLE;
--ALTER USER TRAINEES DEFAULT APEX_ADMINISTRATOR_ROLE ALL;  -- it is for permenent assignment
SELECT * FROM dba_role_privs WHERE grantee = 'TRAINEES' AND granted_role = 'APEX_ADMINISTRATOR_ROLE';
SELECT *--workspace_name, application_id, application_name 
FROM apex_applications; 
-- Fetch all tables resides in OT schema
select * from OT.order_items;  
select * from OT.orders where customer_id=1;
select * from OT.inventories;
select * from OT.products order by product_id desc;
select max(product_id) from OT.products order by product_id;
select * from OT.product_categories;
select * from OT.warehouses;
select * from OT.employees order by employee_id;
select * from OT.contacts;
select * from OT.customers order by customer_id;
select * from OT.locations;
select * from OT.countries where country_id = 'IN';
select * from OT.regions;
/
CREATE SYNONYM order_items FOR OT.order_items;  
CREATE SYNONYM orders FOR OT.orders;
CREATE SYNONYM inventories FOR OT.inventories;
CREATE SYNONYM products FOR OT.products;
CREATE SYNONYM products FOR OT.products;
CREATE SYNONYM product_categories FOR OT.product_categories;
CREATE SYNONYM warehouses FOR OT.warehouses;
CREATE OR REPLACE SYNONYM employees FOR OT.employees;
CREATE SYNONYM contacts FOR OT.contacts;
CREATE SYNONYM customers FOR OT.customers;
CREATE SYNONYM locations FOR OT.locations;
CREATE SYNONYM countries FOR OT.countries;
CREATE SYNONYM regions FOR OT.regions;
/
select * from order_items;  
select * from orders where customer_id=1;
select * from inventories;
select * from products order by product_id desc;
select max(product_id) from products order by product_id;
select * from product_categories;
select * from warehouses;
select * from employees order by employee_id;
select * from contacts;
select * from customers order by customer_id;
select * from locations;
select * from countries where country_id = 'IN';
select * from regions;
/
-- Set the workshpace Context
BEGIN
    apex_util.set_security_group_id(apex_util.find_security_group_id('TRAINEES'));
END;
-- Run as SYS or SYSTEM
GRANT APEX_ADMINISTRATOR_READ_ROLE TO TRAINEES;

-- Replace 'MY_WORKSPACE' and 'MY_CUSTOM_SCHEMA' with your actual names
BEGIN
    APEX_INSTANCE_ADMIN.ADD_SCHEMA(
        p_workspace => 'MY_WORKSPACE',
        p_schema    => 'MY_CUSTOM_SCHEMA'
    );
    COMMIT;
END;
/
--APEX Owner
SELECT DISTINCT table_owner 
FROM all_synonyms 
WHERE synonym_name = 'WWV_FLOW' AND owner = 'PUBLIC';

select * from all_tables where table_name like 'HALITS%';
select * from sys.dba_users where username like 'APEX_%';
select * from sys.dba_users where username like 'TRAINEE%';
select * from sys.dba_users where username like 'GMAIL%';
select * from apex_240200.APEX_DG_DATASETS;
select * from apex_240200.APEX_DG_DATASET_ROWS;
select * from apex_application_static_files;
select * from apex_workspace_static_files;
SELECT workspace_name, schema FROM apex_workspace_schemas;
select * from APEX_240200.APEX_WORKSPACE_USERS;
select * from APEX_240200.APEX_WORKSPACE_APEX_USERS;
select * from APEX_APPL_ACL_USERS;
CREATE SYNONYM OT_PRODUCT_DETAIL_PKG FOR OT.OT_PRODUCT_DETAIL_PKG;
/
declare
 lv_product_id NUMBER := 2;
 lv_profit_amount NUMBER; 
 lv_product_name VARCHAR2(100);
begin
    OT_PRODUCT_DETAIL_PKG.GET_PROFIT_AMOUNT_PROC(lv_product_id, lv_profit_amount, lv_product_name);
    dbms_output.put_line('Profit Amount for the product '||lv_product_name||' is '||lv_profit_amount);
end;
/
declare
begin
    OT_PRODUCT_DETAIL_PKG.PRINT_PRODUCT_PROFIT_AMOUNT;
    dbms_output.put_line('Procedure Completed..');
end;
/