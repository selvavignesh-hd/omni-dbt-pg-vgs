create or replace TABLE FILING_WH.PUBLIC.PLAYER_SELECTION (
	ID NUMBER(38,0) NOT NULL AUTOINCREMENT,
	NAME VARCHAR(16777216),
	AREA VARCHAR(16777216),
	STATUS VARCHAR(16777216),
	UPDATED_AT TIMESTAMP_NTZ
);

alter table FILING_WH.PUBLIC.PLAYER_SELECTION add constraint pk_player_selection primary key (ID);
alter table FILING_WH.PUBLIC.PLAYER_SELECTION alter column ID set not null;
-- Alter column ID to auto increment for snowflake db
alter table FILING_WH.PUBLIC.PLAYER_SELECTION modify column ID SET AUTOINCREMENT;
-- Alter column updated_at to timestamp for snowflake db
alter table FILING_WH.PUBLIC.PLAYER_SELECTION modify column UPDATED_AT SET TIMESTAMP_NTZ;