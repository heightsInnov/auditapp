
--UNIVERSE 

CREATE OR REPLACE PROCEDURE PR_CREATE_AUDIT_UNIVERSE (P_UNIVERSE VARCHAR2, P_ERRCODE OUT VARCHAR2, P_ERRMSG OUT VARCHAR2)
AS 

l_id number;

BEGIN  

        IF (TRIM(P_UNIVERSE) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'UNIVERSE NAME CANNOT BE NULL';
            RETURN;
        END IF;

       l_id := universe_seq.NEXT;

        BEGIN
                INSERT INTO   audit_universe (ID,UNIVERSE_NAME) VALUES (l_id,P_UNIVERSE);
                COMMIT;

                P_ERRCODE:= '00';
                P_ERRMSG:= 'SUUCESSFULLY SAVED';
                    RETURN;
        EXCEPTION WHEN OTHERS THEN 
        P_ERRCODE:= '99';
        P_ERRMSG:= 'FAILED'||SQLERRM;
        END;
 EXCEPTION WHEN OTHERS THEN 
    P_ERRCODE:= SQLCODE;
    P_ERRMSG:= SQLERRM;
END PR_CREATE_AUDIT_UNIVERSE;


--ENTITY 
CREATE OR REPLACE PROCEDURE PR_CREATE_AUDIT_ENTITY (P_ENTITY VARCHAR2, P_UNIVERSE_ID NUMBER, P_ERRCODE OUT VARCHAR2, P_ERRMSG OUT VARCHAR2)
AS 

l_id number;

BEGIN  

        IF (TRIM(P_ENTITY) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'ENTITY NAME CANNOT BE NULL';
            RETURN;
        END IF;

            
        IF (TRIM(P_UNIVERSE_ID) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'UNIVERSE ID CANNOT BE NULL';
            RETURN;
        END IF;

       l_id := ENTITY_seq.NEXT;

        BEGIN 
        INSERT INTO AUDIT_ENTITY (ID,UNIVERSE_ID,ENTITY_NAME) 
                    VALUES (
                            l_id, UNIVERSE_ID,P_ENTITY
                        );
            COMMIT;

            P_ERRCODE:= '00';
            P_ERRMSG:= 'SUUCESSFULLY SAVED';
                        RETURN;
        EXCEPTION WHEN OTHERS THEN 
        P_ERRCODE:= '99';
        P_ERRMSG:= 'FAILED'||SQLERRM;
        END;

EXCEPTION WHEN OTHERS THEN 
    P_ERRCODE:= SQLCODE;
    P_ERRMSG:= SQLERRM;
END PR_CREATE_AUDIT_ENTITY;


--SCOPE 

CREATE OR REPLACE PROCEDURE PR_CREATE_AUDIT_SCOPE (P_ENTITY_ID NUMBER,
                                         P_SCOPE_OF_AUDIT VARCHAR2, 
                                         P_AUDIT_PERIOD  VARCHAR2,
                                         P_PURPOSE VARCHAR2,
                                         P_SCOPE VARCHAR2,
                                         P_SCOPE_OBJECTIVES VARCHAR2,
                                         P_RISK_RATING VARCHAR2,
                                         P_FREQUENCY VARCHAR2, 
                                         P_AUDIT_TYPE VARCHAR2 , 
                                         P_SCHEDULLED_DATE DATE,
                                         P_AUDIT_START_DATE DATE,
                                         P_AUDIT_END_DATE DATE
                                         P_ERRCODE OUT VARCHAR2, 
                                         P_ERRMSG OUT VARCHAR2
                                      )
AS 

l_id number;

BEGIN  

        IF (TRIM(P_ENTITY_ID) IS NULL)  
        THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'ENTITY ID CANNOT BE NULL';
            RETURN;
        END IF;

        IF (TRIM(P_SCOPE_OF_AUDIT) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'SCOPE OF AUDIT CANNOT BE NULL';
            RETURN;
        END IF;

     l_id := SCOPE_seq.NEXT;

        BEGIN 
        INSERT INTO   AUDIT_SCOPE (ID,  ENTITY_ID, SCOPE_OF_AUDIT, AUDIT_PERIOD,SCOPE_PURPOSE,
                                    SCOPE,SCOPE_OBJECTIVES, RISK_RATING,FREQUENCY,AUDIT_TYPE, SCHEDULLED_DATE,
                                    AUDIT_START_DATE, AUDIT_END_DATE 
                                    ) 
                                    VALUES 
                                    (
                                    l_id, P_ENTITY_ID,P_SCOPE_OF_AUDIT,P_AUDIT_PERIOD,P_PURPOSE,P_SCOPE,
                                    P_SCOPE_OBJECTIVES,P_RISK_RATING,P_FREQUENCY,P_AUDIT_TYPE,P_AUDIT_TYPE, TO_DATE(P_SCHEDULLED_DATE,'DD-MON-YYYY'),
                                    TO_DATE(P_AUDIT_START_DATE,'DD-MON-YYYY'), TO_DATE(P_AUDIT_END_DATE,'DD-MON-YYYY')
                                    );

            COMMIT;

            P_ERRCODE:= '00';
            P_ERRMSG:= 'SUUCESSFULLY SAVED';
            RETURN;
        EXCEPTION WHEN OTHERS THEN 
        P_ERRCODE:= '99';
        P_ERRMSG:= 'FAILED'||SQLERRM;
        END;

 EXCEPTION WHEN OTHERS THEN 
    P_ERRCODE:= SQLCODE;
    P_ERRMSG:= SQLERRM;
END PR_CREATE_AUDIT_ENTITY;





--FOCUS


CREATE OR REPLACE PROCEDURE PR_CREATE_AUDIT_FOCUS ( P_SCOPE_ID NUMBER,
                                                    P_AREA_OF_FOCUS VARCHAR2,
                                                    P_SCHEDULLED_DATE DATE,
                                                    P_WORK_PROGRAM_START VARCHAR2,  --(SCHEDULED,ACTIVE,IN-PROGRESS/COMPLETED)
                                                    P_RISK_RATING VARCHAR2, --(very high, high, medium, low, process improvement)
                                                    P_ERRCODE OUT VARCHAR2, 
                                                     P_ERRMSG OUT VARCHAR2
                                      ) 
AS 
BEGIN 

        IF (TRIM(P_SCOPE_ID) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'SCOPE ID CANNOT BE NULL';
            RETURN;
        END IF;

        IF (TRIM(P_AREA_OF_FOCUS) IS NULL)  
         THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'P_AREA_OF_FOCUS  CANNOT BE NULL';
            RETURN;
        END IF;

      l_id := FOCUS_seq.NEXT;

        BEGIN 
            INSERT INTO AUDIT_FOCUS (ID,SCOPE_ID,AREA_OF_FOCUS, SCHEDULLED_DATE,WORK_PROGRAM_START, RISK_RATING)
                                VALUES 
                                    (
                                        l_id,  P_SCOPE_ID, P_AREA_OF_FOCUS, TO_DATE(P_SCHEDULLED_DATE,'DD-MON-YYYY'),P_WORK_PROGRAM_START,P_RISK_RATING

                                    ) ;
                    COMMIT;
            
                P_ERRCODE:= '00';
                P_ERRMSG:= 'SUUCESSFULLY SAVED';
                RETURN;
        EXCEPTION WHEN OTHERS THEN 
            P_ERRCODE:= '99';
            P_ERRMSG:= 'FAILED'||SQLERRM;
        END;


 EXCEPTION WHEN OTHERS THEN 
    P_ERRCODE:= SQLCODE;
    P_ERRMSG:= SQLERRM;
END PR_CREATE_AUDIT_FOCUS;





CREATE OR REPLACE TYPE data_items AS OBJECT
(
    ENTITY_ID NUMBER,
    SCOPE_OF_AUDIT VARCHAR2 (2000),
    AUDIT_PERIOD VARCHAR2 (500),
    PURPOSE VARCHAR2 (2000),
    SCOPE
    SCOPE_OBJECTIVES
    RISK_RATING
    FREQUENCY
    AUDIT_TYPE
    SCHEDULLED_DATE
    AUDIT_START_DATE
    AUDIT_END_DATE

)
