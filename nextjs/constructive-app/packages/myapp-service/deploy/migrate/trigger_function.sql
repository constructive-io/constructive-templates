-- Deploy: migrate/trigger_function
-- made with <3 @ constructive.io

-- requires: migrate/schema


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

INSERT INTO metaschema_public.trigger_function (
  id,
  database_id,
  name,
  code
) VALUES
  ('019fa2a1-5060-7425-bb94-e372e98f6dbb', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'users_search_tsv_tsv', NULL),
  ('019fa2a1-66fb-7e79-84ef-d66f04aa260f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'user_secrets_hash', NULL),
  ('019fa2a1-689b-71cb-baf7-cb0392b7ba9f', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', 'app_internal_secrets_hash', NULL);


SET session_replication_role TO DEFAULT;


