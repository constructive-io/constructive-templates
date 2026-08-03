-- Deploy: migrate/limits_module
-- made with <3 @ constructive.io

-- requires: migrate/invites_module


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
  ('019fbc96-86cf-7afa-a562-05825b9f2987', '019fbc96-84d8-7d13-8acc-4c55ad35634c', NULL, '019fbc96-86cf-7ef2-a529-3dd72c52bfad', '019fbc96-86e7-79b0-a4ec-3be5025c1b2e', NULL, NULL, '019fbc96-8702-7a94-9e81-560580adcaeb', 'app_limits', '019fbc96-876c-7f34-b3b2-19c7fbae3f4f', 'app_limit_defaults', 'app_limits_inc', 'app_limits_dec', 'app_limits_inc_tg', 'app_limits_dec_tg', 'app_limits_upd_tg', 'app_limits_check', '019fbc96-87ad-7092-9b9c-f79aae366d47', '019fbc96-8810-7f7a-8805-483397318795', '019fbc96-88a2-7bb3-a792-7deab9133c17', '019fbc96-88e4-7573-883d-6076b169c481', '019fbc96-893b-70db-9825-27d695d8acfe', NULL, '019fbc96-89b5-7647-9922-f83e63461d5e', '019fbc96-8985-7211-b337-533f1418ea53', 'app_limits_cap_check_tg_fn', 'app_limits_resolve_cap', '019fbc96-89f9-77bd-ada7-8458562dae38', '019fbc96-8a36-72d6-9f45-a72f2e3d7f45', 'app_limits_check_soft', '', 'app', 'app', NULL, '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'usage', NULL),
  ('019fbc96-948b-7d33-8798-80fde6d37334', '019fbc96-84d8-7d13-8acc-4c55ad35634c', 'entity_id', '019fbc96-86cf-7ef2-a529-3dd72c52bfad', '019fbc96-86e7-79b0-a4ec-3be5025c1b2e', NULL, NULL, '019fbc96-948e-7191-adb1-ab09ac90689e', 'org_limits', '019fbc96-9542-74ef-b1d3-8502bfd69283', 'org_limit_defaults', 'org_limits_inc', 'org_limits_dec', 'org_limits_inc_tg', 'org_limits_dec_tg', 'org_limits_upd_tg', 'org_limits_check', '019fbc96-959d-75a6-bdfd-d5a0fe1321f3', '019fbc96-9731-7e68-81d5-1e8a9e273d88', NULL, NULL, NULL, '019fbc96-9653-7e0d-9ee8-3eaed61a69d2', '019fbc96-9855-783c-b950-9c834283e3c8', '019fbc96-980d-74f0-ae5e-9ff54538f26e', 'org_limits_cap_check_tg_fn', 'org_limits_resolve_cap', '019fbc96-98c4-7744-8d5a-86dd9eb2b9eb', '019fbc96-993a-79a3-a5c4-2758293cdd9b', 'org_limits_check_soft', 'org_limit_aggregates_check_soft', 'org', 'org', '019fbc96-8533-7560-9eea-55dbc7f7fcee', '019fbc96-8533-7560-9eea-55dbc7f7fcee', 'usage', NULL);


SET session_replication_role TO DEFAULT;


