-- Deploy: migrate/invites_module
-- made with <3 @ constructive.io

-- requires: migrate/internal_secrets_module


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

INSERT INTO metaschema_modules_public.invites_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  emails_table_id,
  users_table_id,
  invites_table_id,
  claimed_invites_table_id,
  invites_table_name,
  claimed_invites_table_name,
  submit_invite_code_function,
  scope,
  prefix,
  entity_table_id,
  api_name,
  private_api_name
) VALUES
  ('019fbc96-cb63-7e90-9a52-b89f40723073', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-cb64-72af-8517-bb56ec9a9e4a', '019fbc96-cbab-7606-911c-c330b58955f9', NULL, NULL, '019fbc96-c250-7c44-b81a-baa69ea7f678', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-cbfa-72b5-bec3-82d33e693371', '019fbc96-ce07-7cb4-8a74-36d41e6de69f', 'app_invites', 'app_claimed_invites', 'submit_app_invite_code', 'app', 'app', NULL, 'admin', NULL),
  ('019fbc96-cf7c-7cd5-aee7-fbd45dae9da2', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-cb64-72af-8517-bb56ec9a9e4a', '019fbc96-cbab-7606-911c-c330b58955f9', NULL, NULL, '019fbc96-c250-7c44-b81a-baa69ea7f678', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-cf7f-7041-9b02-6402219dc422', '019fbc96-d218-741e-9bc2-e59d1d1a7edd', 'org_invites', 'org_claimed_invites', 'submit_org_invite_code', 'org', 'org', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'admin', NULL);


SET session_replication_role TO DEFAULT;


