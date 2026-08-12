-- Deploy: migrate/user_auth_module
-- made with <3 @ constructive.io

-- requires: migrate/storage_module


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

INSERT INTO metaschema_modules_public.user_auth_module (
  id,
  database_id,
  schema_id,
  emails_table_id,
  users_table_id,
  secrets_table_id,
  encrypted_table_id,
  sessions_table_id,
  session_credentials_table_id,
  audits_table_id,
  audits_table_name,
  sign_in_function,
  sign_up_function,
  sign_out_function,
  set_password_function,
  reset_password_function,
  forgot_password_function,
  send_verification_email_function,
  verify_email_function,
  verify_password_function,
  check_password_function,
  send_account_deletion_email_function,
  delete_account_function,
  sign_in_cross_origin_function,
  request_cross_origin_token_function,
  extend_token_expires,
  api_name,
  private_api_name
) VALUES
  ('019feb75-8d96-7849-908f-510f5e5e49a1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89de-7d6c-a0e8-f04fbeb7d8d9', '019feb75-8a23-70f0-bc0a-c082a8c80fda', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-8662-7462-bd4b-d8dee032dcdd', '019feb75-891b-7bcd-9ed3-1fc29a40c6cd', '019feb75-869f-77e5-b1bd-2954e3f87b89', '019feb75-86dd-7d4b-9a7a-f22c7ff73486', '019feb75-8da3-75f1-b809-0a4c23d44795', 'audit_log_auth', 'sign_in', 'sign_up', 'sign_out', 'set_password', 'reset_password', 'forgot_password', 'send_verification_email', 'verify_email', 'verify_password', 'check_password', 'send_account_deletion_email', 'confirm_delete_account', 'sign_in_cross_origin', 'request_cross_origin_token', 'extend_token_expires', 'auth', NULL);


SET session_replication_role TO DEFAULT;


