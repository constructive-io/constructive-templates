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
  ('019fc104-f335-76a8-9d67-9c006e871111', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '019fc104-f332-74a2-980b-1b04d6073993', '{019fc104-f315-7ce3-9fe4-2862b2c9c1ae,019fc104-f324-7b70-acd8-17a87d8086d2}', '{A,B}', '{pg_catalog.simple,pg_catalog.simple}', NULL);


SET session_replication_role TO DEFAULT;


