CREATE OR REPLACE TRIGGER COMPANY.TG_SETOR
AFTER INSERT OR UPDATE OR DELETE ON COMPANY.SETOR
FOR EACH ROW
DECLARE VTABLE COMPANY.SETOR%ROWTYPE;
BEGIN
    IF INSERTING THEN
        INSERT INTO COMPANY.SETOR_AUD
           (CD_AUDITORIA,
            CD_SETOR    ,
            SETOR       ,
            CD_SUP_SETOR,
            FL_ACAO     ,
            DT_AUDITORIA,
            LG_AUDITORIA)
        VALUES
           (COMPANY.SQ_SETOR_AUD.NEXTVAL,
            :NEW.CD_SETOR    ,
            :NEW.SETOR       ,
            :NEW.CD_SUP_SETOR,
            'I'              ,
            SYSDATE          ,
            USER             );
    END IF;
    IF DELETING THEN
        INSERT INTO COMPANY.SETOR_AUD
           (CD_AUDITORIA,
            CD_SETOR    ,
            SETOR       ,
            CD_SUP_SETOR,
            FL_ACAO     ,
            DT_AUDITORIA,
            LG_AUDITORIA)
        VALUES
           (COMPANY.SQ_SETOR_AUD.NEXTVAL,
            :OLD.CD_SETOR    ,
            :OLD.SETOR       ,
            :OLD.CD_SUP_SETOR,
            'D'              ,
            SYSDATE          ,
            USER             );
    END IF;
    IF UPDATING THEN
        IF :NEW.CD_SETOR != :OLD.CD_SETOR THEN RAISE_APPLICATION_ERROR(-20001,'AÇÃO NÃO PERMITIDA'); END IF;
        IF :NEW.SETOR != :OLD.SETOR THEN
           VTABLE.SETOR := :OLD.SETOR;
        END IF;
        IF (:NEW.CD_SUP_SETOR != :OLD.CD_SUP_SETOR) OR (:NEW.CD_SUP_SETOR IS NULL AND :OLD.CD_SUP_SETOR IS NOT NULL) THEN
            VTABLE.CD_SUP_SETOR := :OLD.CD_SUP_SETOR;
        END IF;
        
        IF VTABLE.SETOR        IS NOT NULL OR
           VTABLE.CD_SUP_SETOR IS NOT NULL OR
           (:NEW.CD_SUP_SETOR IS NOT NULL AND :OLD.CD_SUP_SETOR IS NULL)
        THEN
            INSERT INTO COMPANY.SETOR_AUD
               (CD_AUDITORIA,
                CD_SETOR    ,
                SETOR       ,
                CD_SUP_SETOR,
                FL_ACAO     ,
                DT_AUDITORIA,
                LG_AUDITORIA)
            VALUES
               (COMPANY.SQ_SETOR_AUD.NEXTVAL,
                :OLD.CD_SETOR      ,
                VTABLE.SETOR       ,
                VTABLE.CD_SUP_SETOR,
                'U'                ,
                SYSDATE            ,
                USER               );
        END IF;
    END IF;
END;
/