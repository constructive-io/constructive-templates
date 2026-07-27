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
  ('019fa2a1-5055-75b5-b085-77cf2b8fdbe9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', '019fa2a1-5053-737a-bf40-59ea3ee68b83', '{019fa2a1-503c-7fc0-a00a-4eb05fdea62f,019fa2a1-5048-7874-b9b6-ecb3b316d78c}', '{A,B}', '{pg_catalog.simple,pg_catalog.simple}', NULL);


SET session_replication_role TO DEFAULT;


