--alter session set "_oracle_script"=true;
CREATE    USER       "COMPANY"
DEFAULT   TABLESPACE TS_COMPANY
TEMPORARY TABLESPACE TEMP;

ALTER USER "COMPANY" QUOTA UNLIMITED ON TS_COMPANY;