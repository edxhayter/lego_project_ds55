------ LEGO PARTS TABLE CREATION ------

-- Query to check Schema of the staging table
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS
LIMIT 10;

-- For string cols: check column character length to set data types
SELECT MAX(LENGTH(NAME))
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS;

CREATE TABLE IF NOT EXISTS til_portfolio_projects.eh_ds55_lego.lego_parts (
	PART_NUMBER VARCHAR(15),
	PART_NAME VARCHAR(223),
    PART_CATEGORY_ID INTEGER
);

-- LEGO THEMES TABLE CREATION --
CREATE OR REPLACE TABLE til_portfolio_projects.eh_ds55_lego.lego_themes (

    THEME_ID INTEGER

    , THEME_NAME VARCHAR(32)

    , THEME_PARENT_ID INTEGER

);

-- LEGO COLORS TABLE CREATION --
create or replace table til_portfolio_projects.eh_ds55_lego.lego_colors (

    color_id integer,

    color_name varchar(28),

    color_rgb varchar(6),

    color_is_trans varchar(1)

);

-- INVENTORY SETS TABLE CREATION --
CREATE OR REPLACE TABLE til_portfolio_projects.eh_ds55_lego.lego_inventory_sets (

    Inventory_ID INTEGER,

    Set_Number VARCHAR(10),

    Quantity INTEGER

);

-- INVENTORIES TABLE CREATION --
CREATE OR REPLACE TABLE til_portfolio_projects.eh_ds55_lego.inventories (

    id integer,

    version integer,

    set_num varchar(16)

);

-- LEGO SETS TABLE CREATION --
create or replace table til_portfolio_projects.eh_ds55_lego.lego_sets(

    set_number varchar(16)

    , set_name varchar(95)

    , year integer

    , theme_id integer

    , num_parts integer

);

-- LEGO PART CATEGORIES TABLE CREATION --
CREATE OR REPLACE TABLE TIL_PORTFOLIO_PROJECTS.eh_ds55_lego.LEGO_PART_CATEGORIES (

PART_CAT_NAME VARCHAR(108),

PART_CAT_ID INTEGER

);


-- INVENTORY PARTS TABLE CREATION --
CREATE OR REPLACE TABLE til_portfolio_projects.eh_ds55_lego.lego_inventory_parts (

    INVENTORY_ID INTEGER,

    PART_NUM VARCHAR(255),

    COLOR_ID INTEGER,

    QUANTITY INTEGER,

    IS_SPARE VARCHAR(255)

);

