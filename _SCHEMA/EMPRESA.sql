--alter session set "_oracle_script"=true;

CREATE    USER       "EMPRESA"
DEFAULT   TABLESPACE TS_EMPRESA
TEMPORARY TABLESPACE TEMP;

ALTER USER "EMPRESA" QUOTA UNLIMITED ON TS_EMPRESA;