-- Deploy: migrate/trigger
-- made with <3 @ constructive.io

-- requires: migrate/table_grant


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

INSERT INTO metaschema_public.trigger (
  id,
  database_id,
  table_id,
  name,
  event,
  function_name,
  smart_tags,
  category,
  tags
) VALUES
  ('019fa2a1-5060-77a0-9110-94a00ea81be9', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_search_tsv_tsv_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fa2a1-5060-7a1f-a7e4-2195dca10a4d', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-5022-77c8-9de2-2ef6079855de', 'users_search_tsv_tsv_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fa2a1-66fc-796f-8ebf-7ea471fb58ae', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'user_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fa2a1-66fc-7a54-bca1-01c731625025', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', 'user_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fa2a1-689b-7cc9-9656-561ad1d1d355', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'app_internal_secrets_update_tg', NULL, NULL, NULL, 'app', '{}'),
  ('019fa2a1-689b-7dcb-a02e-cfcde4971ed4', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-674f-73fa-9633-39edfbd13c6c', 'app_internal_secrets_insert_tg', NULL, NULL, NULL, 'app', '{}');


SET session_replication_role TO DEFAULT;


