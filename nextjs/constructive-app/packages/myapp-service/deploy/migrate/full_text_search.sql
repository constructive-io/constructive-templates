-- Deploy: migrate/full_text_search
-- made with <3 @ constructive.io

-- requires: migrate/foreign_key_constraint


SET session_replication_role TO replica;
-- using replica in case we are deploying triggers to metaschema_public

-- unaccent, postgis affected and require grants
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public to public;

DO $LQLMIGRATION$
  DECLARE
  BEGIN

    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_user');
    EXECUTE format('GRANT CONNECT ON DATABASE %I TO %I', current_database(), 'app_admin');

  END;
$LQLMIGRATION$;

INSERT INTO metaschema_public.full_text_search (
  id,
  database_id,
  table_id,
  field_id,
  field_ids,
  weights,
  langs,
  lang_column
) VALUES
  ('019feb75-7904-709d-a774-3fb7dd696086', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-7903-72c9-97a6-cccbce13579b', '{019feb75-78f6-7075-a739-65eaadd1baa3,019feb75-78fd-722d-83cc-521d78e2c30b}', '{A,B}', '{pg_catalog.simple,pg_catalog.simple}', NULL);


SET session_replication_role TO DEFAULT;


