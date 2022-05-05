CREATE OR REPLACE TRIGGER COMPANY.TG_COLABORADOR
AFTER INSERT OR UPDATE OR DELETE ON COMPANY.COLABORADOR
FOR EACH ROW
DECLARE VTABLE COMPANY.COLABORADOR%ROWTYPE;
BEGIN
    IF INSERTING THEN
        INSERT INTO COMPANY.COLABORADOR_AUD
           (CD_AUDITORIA,
            CD_MATRICULA,
            NOME_SOCIAL ,
            NOME        ,
            CPF         ,
            DT_NASCIDO  ,
            FL_SEXO     ,
            CD_SETOR    ,
            CD_GESTOR   ,
            FL_ACAO     ,
            DT_AUDITORIA,
            LG_OPERADOR )
        VALUES
           (COMPANY.SQ_COLABORADOR_AUD.NEXTVAL,
            :NEW.CD_MATRICULA,
            :NEW.NOME_SOCIAL ,
            :NEW.NOME        ,
            :NEW.CPF         ,
            :NEW.DT_NASCIDO  ,
            :NEW.FL_SEXO     ,
            :NEW.CD_SETOR    ,
            :NEW.CD_GESTOR   ,
            'I'         ,
            SYSDATE     ,
            USER        );
    END IF;
    IF DELETING THEN
        INSERT INTO COMPANY.COLABORADOR_AUD
           (CD_AUDITORIA,
            CD_MATRICULA,
            NOME_SOCIAL ,
            NOME        ,
            CPF         ,
            DT_NASCIDO  ,
            FL_SEXO     ,
            CD_SETOR    ,
            CD_GESTOR   ,
            FL_ACAO     ,
            DT_AUDITORIA,
            LG_OPERADOR )
        VALUES
           (COMPANY.SQ_COLABORADOR_AUD.NEXTVAL,
            :OLD.CD_MATRICULA,
            :OLD.NOME_SOCIAL ,
            :OLD.NOME        ,
            :OLD.CPF         ,
            :OLD.DT_NASCIDO  ,
            :OLD.FL_SEXO     ,
            :OLD.CD_SETOR    ,
            :OLD.CD_GESTOR   ,
            'D'         ,
            SYSDATE     ,
            USER        );
    END IF;
    IF UPDATING THEN
        IF :NEW.CD_MATRICULA != :OLD.CD_MATRICULA THEN RAISE_APPLICATION_ERROR(-20001,'AÇÃO NÃO PERMITIDA'); END IF;
        
        IF :NEW.NOME_SOCIAL != :OLD.NOME_SOCIAL THEN
            VTABLE.NOME_SOCIAL := :OLD.NOME_SOCIAL;
        END IF;
        IF :NEW.NOME != :OLD.NOME THEN
            VTABLE.NOME := :OLD.NOME;
        END IF;
        IF :NEW.CPF != :OLD.CPF THEN
            VTABLE.CPF := :OLD.CPF;
        END IF;
        IF :NEW.DT_NASCIDO != :OLD.DT_NASCIDO THEN
            VTABLE.DT_NASCIDO := :OLD.DT_NASCIDO;
        END IF;
        IF :NEW.FL_SEXO != :OLD.FL_SEXO THEN
            VTABLE.FL_SEXO := :OLD.FL_SEXO;
        END IF;
        IF :NEW.CD_SETOR != :OLD.CD_SETOR THEN
            VTABLE.CD_SETOR := :OLD.CD_SETOR;
        END IF;
        IF :NEW.CD_GESTOR != :OLD.CD_GESTOR THEN
            VTABLE.CD_GESTOR := :OLD.CD_GESTOR;
        END IF;
        
        IF VTABLE.NOME_SOCIAL IS NOT NULL OR
           VTABLE.NOME        IS NOT NULL OR
           VTABLE.CPF         IS NOT NULL OR
           VTABLE.FL_SEXO     IS NOT NULL OR
           VTABLE.CD_SETOR    IS NOT NULL OR
           VTABLE.CD_GESTOR   IS NOT NULL 
        THEN
            INSERT INTO COMPANY.COLABORADOR_AUD
               (CD_AUDITORIA,
                CD_MATRICULA,
                NOME_SOCIAL ,
                NOME        ,
                CPF         ,
                DT_NASCIDO  ,
                FL_SEXO     ,
                CD_SETOR    ,
                CD_GESTOR   ,
                FL_ACAO     ,
                DT_AUDITORIA,
                LG_OPERADOR )
            VALUES
               (COMPANY.SQ_COLABORADOR_AUD.NEXTVAL,
                :OLD.CD_MATRICULA,
                :OLD.NOME_SOCIAL ,
                :OLD.NOME        ,
                :OLD.CPF         ,
                :OLD.DT_NASCIDO  ,
                :OLD.FL_SEXO     ,
                :OLD.CD_SETOR    ,
                :OLD.CD_GESTOR   ,
                'D'         ,
                SYSDATE     ,
                USER        );
        END IF;
    END IF;
END;