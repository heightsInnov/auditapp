

-- 1 universe 
create table audit_universe 
            (
                id  number,
                UNIVERSE_NAME VARCHAR2(2000),
                Record_Stat VARCHAR2(1),  -- (O -open, C- Closed)
                Auth_stat  VARCHAR2(1),  --  (A - Authorised, U - unathorised)
                Create_Date  DATE
            );



---2. Entity 

    CREATE TABLE AUDIT_ENTITY 
                    (
                        ID NUMBER,
                        UNIVERSE_ID NUMBER, 
                        ENTITY_NAME VARCHAR2(2000),
                        Record_Stat VARCHAR2(1),  -- (O -open, C- Closed)
                        Auth_stat  VARCHAR2(1),  --  (A - Authorised, U - unathorised)
                        Create_Date  DATE

                    );

--3 Audit scope ( the entire audit is call plan)
    
   CREATE TABLE AUDIT_SCOPE 
                    (
                        ID NUMBER,
                        ENTITY_ID NUMBER,
                        SCOPE_OF_AUDIT  VARCHAR2(3000),
                        AUDIT_PERIOD    VARCHAR2(3000),
                        SCOPE_PURPOSE   VARCHAR2(3000),
                        SCOPE           VARCHAR2(3000),
                        SCOPE_OBJECTIVES VARCHAR2(3000),
                        RISK_RATING      VARCHAR2(3000),    --(very high, high, medium, low, process improvement)
                        FREQUENCY        VARCHAR2(3000),    --(daily, weekly, monthly, quarterly, biannual, annual)
                        AUDIT_TYPE       VARCHAR2(3000),    -- (routine, adhoc, spot check, follow-up, special investigation)
                        AUDIT_START_DATE  DATE,
                        AUDIT_END_DATE    DATE,
                        APPROVAL_STATUS   VARCHAR2(3000),     --(DRAFT,UNDER-REVIEW,COMPLETED)
                        USER_NAME         VARCHAR2(3000),
                        Record_Stat VARCHAR2(1),  -- (O -open, C- Closed)
                        Auth_stat  VARCHAR2(1),  --  (A - Authorised, U - unathorised)
                        Create_Date  DATE

                    );


-- 4 AUDIT FOCUS 
         CREATE TABLE AUDIT_FOCUS 
                        (
                            ID NUMBER,
                            SCOPE_ID NUMBER,
                            AREA_OF_FOCUS VARCHAR2(3000),
                            VIEW_FLAG     CHAR(1),  --(Y-YES/N-NO)
                            SCHEDULED_FLAG CHAR(1), --(Y-YES/N-NO)
                            SCHEDULLED_DATE DATE, 
                            START_DATE      DATE,
                            WORK_PROGRAM_START  VARCHAR2(3000), --(SCHEDULED,ACTIVE,IN-PROGRESS)
                            START_FLAG      CHAR(1), --(Y-YES/N-NO)
                            FOCUS_EXCEPTION  VARCHAR2(3000),
                            FOCUS_RECOMMENDATION VARCHAR2(3000),
                            COMMENTS             VARCHAR2(3000),
                            CONTROL_STATUS       VARCHAR2(3000),  --(Adequate/Partially Adequate/Inadequate)
                            REQUEST_ADDITIONAL_INFO VARCHAR2(3000),
                            RECIPIET_NAME         VARCHAR2(3000),
                            RECIPIET_EMAIL        VARCHAR2(3000),
                            APPROVAL_STATUS   VARCHAR2(3000),     --(DRAFT,UNDER-REVIEW,COMPLETED)
                            USER_NAME         VARCHAR2(3000),
                            Record_Stat VARCHAR2(1),  -- (O -open, C- Closed)
                            Auth_stat  VARCHAR2(1),  --  (A - Authorised, U - unathorised)
                             Create_Date  DATE
                        );
