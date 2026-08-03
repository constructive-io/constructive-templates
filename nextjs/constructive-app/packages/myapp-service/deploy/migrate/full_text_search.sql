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
  ('019fbc96-8570-7f30-9221-884e3c075aec', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-856e-7182-bc0f-63622620e23a', '{019fbc96-8552-7c53-8c92-5ad667e6d165,019fbc96-8561-7835-9a4c-568e906ec2e6}', '{A,B}', '{pg_catalog.simple,pg_catalog.simple}', NULL);


SET session_replication_role TO DEFAULT;


