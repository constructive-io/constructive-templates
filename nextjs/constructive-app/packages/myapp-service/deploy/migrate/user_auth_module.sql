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
  ('019fbc96-d3d8-779d-ac2d-370828805a1a', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c130-7558-9bec-78482a963cfe', '019fbc96-c250-7c44-b81a-baa69ea7f678', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-ad5b-7116-9f79-d037fdc40cd9', '019fbc96-bdd9-7379-be88-17a73f1d5320', '019fbc96-ae3f-7843-8d56-55dc4da7a445', '019fbc96-af80-75e3-9b05-4a449fcabc73', '019fbc96-d430-750d-8b5e-429956001965', 'audit_log_auth', 'sign_in', 'sign_up', 'sign_out', 'set_password', 'reset_password', 'forgot_password', 'send_verification_email', 'verify_email', 'verify_password', 'check_password', 'send_account_deletion_email', 'confirm_delete_account', 'sign_in_cross_origin', 'request_cross_origin_token', 'extend_token_expires', 'auth', NULL);


SET session_replication_role TO DEFAULT;


