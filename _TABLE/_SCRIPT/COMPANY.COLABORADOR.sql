INSERT INTO COMPANY.COLABORADOR
   (CD_MATRICULA,
    NOME_SOCIAL ,
    NOME        ,
    CPF         ,
    DT_NASCIDO  ,
    FL_SEXO     ,
    CD_SETOR    ,
    CD_GESTOR   )
VALUES
   (COMPANY.GERAR_MATRICULA()         ,
    'JAILTON DPAULA'                  ,
    'LUIZ JAILTON VIANA DE PAULA'     ,
    00000000000                       ,
    TO_DATE('13/01/1995','DD/MM/YYYY'),
    'M'                               ,
    1                                 ,
    NULL                              );
    