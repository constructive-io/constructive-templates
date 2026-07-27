-- Deploy: migrate/limits_module
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

INSERT INTO metaschema_modules_public.limits_module (
  id,
  database_id,
  entity_field,
  schema_id,
  private_schema_id,
  public_schema_name,
  private_schema_name,
  table_id,
  table_name,
  default_table_id,
  default_table_name,
  limit_increment_function,
  limit_decrement_function,
  limit_increment_trigger,
  limit_decrement_trigger,
  limit_update_trigger,
  limit_check_function,
  limit_credits_table_id,
  events_table_id,
  credit_codes_table_id,
  credit_code_items_table_id,
  credit_redemptions_table_id,
  aggregate_table_id,
  limit_caps_table_id,
  limit_caps_defaults_table_id,
  cap_check_trigger,
  resolve_cap_function,
  limit_warnings_table_id,
  limit_warning_state_table_id,
  limit_check_soft_function,
  limit_aggregate_check_soft_function,
  scope,
  prefix,
  entity_table_id,
  actor_table_id,
  api_name,
  private_api_name
) VALUES
  ('019fa2a1-51a3-7aa0-9a9c-e4fbebdb1cc8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', NULL, '019fa2a1-51a3-7e09-92ab-08da59fa62d6', '019fa2a1-51bb-7c48-a313-feb84675ce8d', NULL, NULL, '019fa2a1-51d7-7525-a82f-f18b7765f445', 'app_limits', '019fa2a1-5245-7943-99d6-ab69b0046c4a', 'app_limit_defaults', 'app_limits_inc', 'app_limits_dec', 'app_limits_inc_tg', 'app_limits_dec_tg', 'app_limits_upd_tg', 'app_limits_check', '019fa2a1-5285-725c-9bcd-65d477e277f4', '019fa2a1-52e7-7b9a-83c9-44ece4f9c7a4', '019fa2a1-5378-7160-b636-5d7814a54a7c', '019fa2a1-53be-7020-a577-17e52f91740f', '019fa2a1-5416-73f2-acac-2d0393ddb8cb', NULL, '019fa2a1-5496-7d14-aea2-866a78236d8a', '019fa2a1-5468-7986-ba62-d5ec673318b9', 'app_limits_cap_check_tg_fn', 'app_limits_resolve_cap', '019fa2a1-54d8-72b7-8837-7d5008546c02', '019fa2a1-5515-74cb-b03a-e1a7265372b4', 'app_limits_check_soft', '', 'app', 'app', NULL, '019fa2a1-5022-77c8-9de2-2ef6079855de', 'usage', NULL);


SET session_replication_role TO DEFAULT;


