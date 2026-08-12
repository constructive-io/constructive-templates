-- Deploy: migrate/user_auth_module
-- made with <3 @ constructive.io

-- requires: migrate/sessions_module


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
  ('019fc105-1383-7ebf-954c-4831ff5f3dfc', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc105-0cf6-7075-9d35-6b418c5f8913', '019fc104-f2f4-73b2-abcd-47aa47fa7997', '019fc104-fe6f-719a-8b3f-c157587194b5', '019fc105-0996-7bb7-8ecb-595462857b72', '019fc104-ff05-737a-9287-9dc91676dc85', '019fc104-ffd2-7869-bc0e-15e9e9f99044', '019fc105-13bf-7b4a-919a-37a5c5871c02', 'audit_log_auth', 'sign_in', 'sign_up', 'sign_out', 'set_password', 'reset_password', 'forgot_password', 'send_verification_email', 'verify_email', 'verify_password', 'check_password', 'send_account_deletion_email', 'confirm_delete_account', 'sign_in_cross_origin', 'request_cross_origin_token', 'extend_token_expires', 'auth', NULL);


SET session_replication_role TO DEFAULT;


