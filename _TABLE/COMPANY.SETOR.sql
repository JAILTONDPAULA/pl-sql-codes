CREATE TABLE COMPANY.SETOR(
    CD_SETOR     NUMBER        CONSTRAINT PK_SETOR       PRIMARY KEY,
    SETOR        VARCHAR2(150) CONSTRAINT UK_PERADOR     UNIQUE     ,
    CD_SUP_SETOR NUMBER        CONSTRAINT FK_SETOR_SETOR REFERENCES COMPANY.SETOR(CD_SETOR)
);

COMMENT ON TABLE  COMPANY.SETOR              IS 'Tabela contendo os setores de uma empresa';
COMMENT ON COLUMN COMPANY.SETOR.CD_SUP_SETOR IS 'Chave estrangeira do setor superior';