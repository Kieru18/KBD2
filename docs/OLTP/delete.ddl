DECLARE
  v_schema_owner VARCHAR2(100) := 'KBD1';
  v_object_name VARCHAR2(100);
  v_sql VARCHAR2(1000);
BEGIN
  -- Drop all tables
  FOR tbl IN (SELECT table_name FROM all_tables WHERE owner = v_schema_owner) LOOP
    v_object_name := tbl.table_name;
    v_sql := 'DROP TABLE ' || v_object_name || ' CASCADE CONSTRAINTS';
    EXECUTE IMMEDIATE v_sql;
  END LOOP;

  -- Drop all indexes
  FOR idx IN (SELECT index_name FROM all_indexes WHERE owner = v_schema_owner) LOOP
    v_object_name := idx.index_name;
    v_sql := 'DROP INDEX ' || v_object_name;
    EXECUTE IMMEDIATE v_sql;
  END LOOP;

  -- Drop all triggers
  FOR trg IN (SELECT trigger_name FROM all_triggers WHERE owner = v_schema_owner) LOOP
    v_object_name := trg.trigger_name;
    v_sql := 'DROP TRIGGER ' || v_object_name;
    EXECUTE IMMEDIATE v_sql;
  END LOOP;

  -- Drop all sequences
  FOR seq IN (SELECT sequence_name FROM all_sequences WHERE sequence_owner = v_schema_owner) LOOP
    v_object_name := seq.sequence_name;
    v_sql := 'DROP SEQUENCE ' || v_object_name;
    EXECUTE IMMEDIATE v_sql;
  END LOOP;
END;
/
