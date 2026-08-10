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
  ('019feb75-8be9-708b-9108-efa2e54ceffa', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', NULL, '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', '019feb75-8bf4-70ee-94b8-840941a142ac', NULL, NULL, '019feb75-8a23-70f0-bc0a-c082a8c80fda', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-8c00-72b9-b512-4719a73b24a5', '019feb75-8c5c-78a0-a5bc-ac52a3e98db5', 'app_invites', 'app_claimed_invites', 'submit_app_invite_code', 'app', 'app', NULL, 'admin', NULL),
  ('019feb75-8cbf-7193-af2a-5fbcf95f4321', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'entity_id', '019feb75-8be9-73c3-b3e4-bf7ac46b5d76', '019feb75-8bf4-70ee-94b8-840941a142ac', NULL, NULL, '019feb75-8a23-70f0-bc0a-c082a8c80fda', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-8cc1-72cd-aaa8-39befebe8af8', '019feb75-8d26-7dd5-8a1e-47949cbdb6a7', 'org_invites', 'org_claimed_invites', 'submit_org_invite_code', 'org', 'org', '019feb75-78e2-720e-82dc-c3ed84264ce8', 'admin', NULL);


SET session_replication_role TO DEFAULT;


