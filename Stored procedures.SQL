--UNIVERSE

CREATE OR REPLACE PROCEDURE pr_create_audit_universe (
    p_universe       VARCHAR2,
    p_errcode    OUT VARCHAR2,
    p_errmsg     OUT VARCHAR2)
AS
    l_id   NUMBER;
BEGIN
    IF (TRIM (p_universe) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'UNIVERSE NAME CANNOT BE NULL';
        RETURN;
    END IF;

    l_id := universe_seq.NEXTVAL;

    BEGIN
        INSERT INTO audit_universe (id, universe_name)
        VALUES (l_id, p_universe);

        COMMIT;

        p_errcode := '00';
        p_errmsg := 'SUUCESSFULLY SAVED';
        RETURN;
    EXCEPTION
        WHEN OTHERS
        THEN
            p_errcode := '99';
            p_errmsg := 'FAILED' || SQLERRM;
    END;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_universe;

--ENTITY

CREATE OR REPLACE PROCEDURE pr_create_audit_entity (
    p_entity            VARCHAR2,
    p_universe_id       NUMBER,
    p_errcode       OUT VARCHAR2,
    p_errmsg        OUT VARCHAR2)
AS
    l_id   NUMBER;
BEGIN
    IF (TRIM (p_entity) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'ENTITY NAME CANNOT BE NULL';
        RETURN;
    END IF;


    IF (TRIM (p_universe_id) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'UNIVERSE ID CANNOT BE NULL';
        RETURN;
    END IF;

    l_id := entity_seq.NEXTVAL;

    BEGIN
        INSERT INTO audit_entity (id, universe_id, entity_name)
        VALUES (l_id, p_universe_id, p_entity);

        COMMIT;

        p_errcode := '00';
        p_errmsg := 'SUUCESSFULLY SAVED';
        RETURN;
    EXCEPTION
        WHEN OTHERS
        THEN
            p_errcode := '99';
            p_errmsg := 'FAILED' || SQLERRM;
    END;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_entity;


--SCOPE

CREATE OR REPLACE PROCEDURE pr_create_audit_scope (
    p_entity_id              NUMBER,
    p_scope_of_audit         VARCHAR2,
    p_audit_period           VARCHAR2,
    p_purpose                VARCHAR2,
    p_scope                  VARCHAR2,
    p_scope_objectives       VARCHAR2,
    p_risk_rating            VARCHAR2,
    p_frequency              VARCHAR2,
    p_audit_type             VARCHAR2,
    p_schedulled_date        DATE,
    p_audit_start_date       DATE,
    p_audit_end_date         DATE,
    p_errcode            OUT VARCHAR2,
    p_errmsg             OUT VARCHAR2)
AS
    l_id   NUMBER;
BEGIN
    IF (TRIM (p_entity_id) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'ENTITY ID CANNOT BE NULL';
        RETURN;
    END IF;

    IF (TRIM (p_scope_of_audit) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'SCOPE OF AUDIT CANNOT BE NULL';
        RETURN;
    END IF;

    l_id := scope_seq.NEXTVAL;

    BEGIN
        INSERT INTO audit_scope (id,
                                 entity_id,
                                 scope_of_audit,
                                 audit_period,
                                 scope_purpose,
                                 scope,
                                 scope_objectives,
                                 risk_rating,
                                 frequency,
                                 audit_type,
                                 schedulled_date,
                                 audit_start_date,
                                 audit_end_date)
        VALUES (l_id,
                p_entity_id,
                p_scope_of_audit,
                p_audit_period,
                p_purpose,
                p_scope,
                p_scope_objectives,
                p_risk_rating,
                p_frequency,
                p_audit_type,
                TO_DATE (p_schedulled_date, 'DD-MON-YYYY'),
                TO_DATE (p_audit_start_date, 'DD-MON-YYYY'),
                TO_DATE (p_audit_end_date, 'DD-MON-YYYY'));

        COMMIT;

        p_errcode := '00';
        p_errmsg := 'SUUCESSFULLY SAVED';
        RETURN;
    EXCEPTION
        WHEN OTHERS
        THEN
            p_errcode := '99';
            p_errmsg := 'FAILED' || SQLERRM;
    END;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_scope;



--FOCUS


CREATE OR REPLACE PROCEDURE pr_create_audit_focus (
    p_scope_id                 NUMBER,
    p_area_of_focus            VARCHAR2,
    p_schedulled_date          DATE,
    p_work_program_start       VARCHAR2, --(SCHEDULED,ACTIVE,IN-PROGRESS/COMPLETED)
    p_risk_rating              VARCHAR2, --(very high, high, medium, low, process improvement)
    p_errcode              OUT VARCHAR2,
    p_errmsg               OUT VARCHAR2)
AS
    l_id   NUMBER;
BEGIN
    IF (TRIM (p_scope_id) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'SCOPE ID CANNOT BE NULL';
        RETURN;
    END IF;

    IF (TRIM (p_area_of_focus) IS NULL)
    THEN
        p_errcode := '99';
        p_errmsg := 'P_AREA_OF_FOCUS  CANNOT BE NULL';
        RETURN;
    END IF;

    l_id := focus_seq.NEXTVAL;

    BEGIN
        INSERT INTO audit_focus (id,
                                 scope_id,
                                 area_of_focus,
                                 schedulled_date,
                                 work_program_start,
                                 risk_rating)
        VALUES (l_id,
                p_scope_id,
                p_area_of_focus,
                TO_DATE (p_schedulled_date, 'DD-MON-YYYY'),
                p_work_program_start,
                p_risk_rating);

        COMMIT;

        p_errcode := '00';
        p_errmsg := 'SUUCESSFULLY SAVED';
        RETURN;
    EXCEPTION
        WHEN OTHERS
        THEN
            p_errcode := '99';
            p_errmsg := 'FAILED' || SQLERRM;
    END;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_focus;


CREATE OR REPLACE PROCEDURE pr_create_audit_scope_array (
    p_rec_data_scope   IN     rec_data_scope,
    p_errcode             OUT VARCHAR2,
    p_errmsg              OUT VARCHAR2)
IS
    l_count   NUMBER;
    l_id      NUMBER;
BEGIN
    l_count := p_rec_data_scope.COUNT;

    IF l_count <= 0
    THEN
        p_errcode := '99';
        p_errmsg := 'ARRAYS IS EMPTY';
        RETURN;
    END IF;

    FOR i IN p_rec_data_scope.FIRST .. p_rec_data_scope.LAST
    LOOP
        l_id := NULL;

        l_id := scope_seq.NEXTVAL;

        BEGIN
            INSERT INTO audit_scope (id,
                                     entity_id,
                                     scope_of_audit,
                                     audit_period,
                                     scope_purpose,
                                     scope,
                                     scope_objectives,
                                     risk_rating,
                                     frequency,
                                     audit_type,
                                     schedulled_date,
                                     audit_start_date,
                                     audit_end_date)
                VALUES (
                           l_id,
                           p_rec_data_scope (i).entity_id,
                           p_rec_data_scope (i).scope_of_audit,
                           p_rec_data_scope (i).audit_period,
                           p_rec_data_scope (i).purpose,
                           p_rec_data_scope (i).scope,
                           p_rec_data_scope (i).scope_objectives,
                           p_rec_data_scope (i).risk_rating,
                           p_rec_data_scope (i).frequency,
                           p_rec_data_scope (i).audit_type,
                           TO_DATE (p_rec_data_scope (i).schedulled_date,
                                    'DD-MON-YYYY'),
                           TO_DATE (p_rec_data_scope (i).audit_start_date,
                                    'DD-MON-YYYY'),
                           TO_DATE (p_rec_data_scope (i).audit_end_date,
                                    'DD-MON-YYYY'));
        EXCEPTION
            WHEN OTHERS
            THEN
                NULL;
        END;
    END LOOP;

    COMMIT;

    p_errcode := '00';
    p_errmsg := 'SUUCESSFULLY SAVED';
    RETURN;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_scope_array;


CREATE OR REPLACE PROCEDURE pr_create_audit_focus_array (
    p_rec_data_focus   IN     rec_data_focus,
    p_errcode             OUT VARCHAR2,
    p_errmsg              OUT VARCHAR2)
IS
    l_count   NUMBER;
    l_id      NUMBER;
BEGIN
    l_count := p_rec_data_focus.COUNT;

    IF l_count <= 0
    THEN
        p_errcode := '99';
        p_errmsg := 'ARRAYS IS EMPTY';
        RETURN;
    END IF;

    FOR i IN p_rec_data_focus.FIRST .. p_rec_data_focus.LAST
    LOOP
        l_id := NULL;

        l_id := scope_seq.NEXTVAL;

        BEGIN
            INSERT INTO audit_focus (id,
                                     scope_id,
                                     area_of_focus,
                                     schedulled_date,
                                     work_program_start,
                                     risk_rating)
                VALUES (
                           l_id,
                           p_rec_data_focus (i).scope_id,
                           p_rec_data_focus (i).area_of_focus,
                           TO_DATE (p_rec_data_focus (i).schedulled_date,
                                    'DD-MON-YYYY'),
                           p_rec_data_focus (i).work_program_start,
                           p_rec_data_focus (i).risk_rating);

            COMMIT;
        EXCEPTION
            WHEN OTHERS
            THEN
                NULL;
        END;
    END LOOP;

    p_errcode := '00';
    p_errmsg := 'SUUCESSFULLY SAVED';
    COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN
        p_errcode := SQLCODE;
        p_errmsg := SQLERRM;
END pr_create_audit_focus_array;