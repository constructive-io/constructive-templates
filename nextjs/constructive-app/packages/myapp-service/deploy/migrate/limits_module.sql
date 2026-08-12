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
  limit_defaults,
  api_name,
  private_api_name
) VALUES
  ('019feb75-79b3-7efd-a016-5087043ac822', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', NULL, '019feb75-79b4-722d-bbc4-c5ef8a53db6b', '019feb75-79bc-73be-9da4-a0da9c33a7fc', NULL, NULL, '019feb75-79c8-7b1d-97d4-30cd885258c7', 'app_limits', '019feb75-79ee-72c1-a134-d898911d2b82', 'app_limit_defaults', 'app_limits_inc', 'app_limits_dec', 'app_limits_inc_tg', 'app_limits_dec_tg', 'app_limits_upd_tg', 'app_limits_check', '019feb75-7a1f-70ad-af15-440dd2401c7e', '019feb75-7a56-789b-b3c7-a2b7134c8406', '019feb75-7aa4-7b5b-aacc-2517f0ff61eb', '019feb75-7aba-7a92-9d13-8877944a965f', '019feb75-7ad8-7045-8b15-a07b2abdb858', NULL, '019feb75-7b08-7ddd-a465-1505c8a5e604', '019feb75-7af8-783b-b7e9-73b66653c4a4', 'app_limits_cap_check_tg_fn', 'app_limits_resolve_cap', '019feb75-7b26-7496-8f57-9d3af1da9a94', '019feb75-7b39-7dcd-a575-3a0ef02c3a5b', 'app_limits_check_soft', '', 'app', 'app', NULL, '019feb75-78e2-720e-82dc-c3ed84264ce8', NULL, 'usage', NULL),
  ('019feb75-7f19-7876-85b3-f2ffc48a94f9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'entity_id', '019feb75-79b4-722d-bbc4-c5ef8a53db6b', '019feb75-79bc-73be-9da4-a0da9c33a7fc', NULL, NULL, '019feb75-7f1b-74ca-9a57-a7a77a490ba9', 'org_limits', '019feb75-7f42-7e7f-adeb-651d0ecc673c', 'org_limit_defaults', 'org_limits_inc', 'org_limits_dec', 'org_limits_inc_tg', 'org_limits_dec_tg', 'org_limits_upd_tg', 'org_limits_check', '019feb75-7f70-7a9a-b1b8-af5eaf063cc7', '019feb75-800e-723c-9bc5-bd7ad5ccacf4', NULL, NULL, NULL, '019feb75-7fb2-7e3f-accd-1083624b72d7', '019feb75-807a-7c6b-acaa-eba03b0252bd', '019feb75-8069-7350-adb8-7640b3b672a2', 'org_limits_cap_check_tg_fn', 'org_limits_resolve_cap', '019feb75-80a3-7086-aac3-48a15ab63067', '019feb75-80bd-7a38-8322-a23264db0479', 'org_limits_check_soft', 'org_limit_aggregates_check_soft', 'org', 'org', '019feb75-78e2-720e-82dc-c3ed84264ce8', '019feb75-78e2-720e-82dc-c3ed84264ce8', NULL, 'usage', NULL);


SET session_replication_role TO DEFAULT;


