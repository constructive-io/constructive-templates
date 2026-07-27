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
  ('019fa2a1-7000-7603-87ed-c37301ff3e82', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-68d3-7385-938c-1973d9bed8f2', '019fa2a1-69aa-7ba6-a7ef-3303f246936b', '019fa2a1-5022-77c8-9de2-2ef6079855de', '019fa2a1-5b1d-7b27-bab2-e3c469e536af', '019fa2a1-6661-7502-b1a4-7ebfccb37ee9', '019fa2a1-5bbc-7d2a-a42f-af8235516fb4', '019fa2a1-5c8d-7633-a186-023c9c2285e6', '019fa2a1-703c-73a4-bcd4-ef0ed194b005', 'audit_log_auth', 'sign_in', 'sign_up', 'sign_out', 'set_password', 'reset_password', 'forgot_password', 'send_verification_email', 'verify_email', 'verify_password', 'check_password', 'send_account_deletion_email', 'confirm_delete_account', 'sign_in_cross_origin', 'request_cross_origin_token', 'extend_token_expires', 'auth', NULL);


SET session_replication_role TO DEFAULT;


