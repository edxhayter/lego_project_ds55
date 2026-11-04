------ LEGO PARTS TABLE CREATION ------

-- Query to check Schema of the staging table
SELECT *
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS
LIMIT 10;

-- For string cols: check column character length to set data types
SELECT MAX(LENGTH(NAME))
FROM TIL_PORTFOLIO_PROJECTS.STAGING.LEGO_PARTS;

CREATE OR REPLACE TABLE til_portfolio_projects.eh_ds55_lego.lego_parts (
	PART_NUMBER VARCHAR(15),
	PART_NAME VARCHAR(223),
    PART_CATEGORY_ID INTEGER
);

--

