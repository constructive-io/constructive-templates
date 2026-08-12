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
  ('019fc104-f4a9-7a31-b2bd-e110e422097f', '019fc104-f28d-7b9c-8d9d-8f338def573c', NULL, '019fc104-f4a9-7dad-b8d1-37fc33a66117', '019fc104-f4c1-7d26-9e70-bc3cc5757a99', NULL, NULL, '019fc104-f4e1-7642-9736-e6d5dfaceeac', 'app_limits', '019fc104-f551-7c69-b70e-4ba81d6e04f1', 'app_limit_defaults', 'app_limits_inc', 'app_limits_dec', 'app_limits_inc_tg', 'app_limits_dec_tg', 'app_limits_upd_tg', 'app_limits_check', '019fc104-f597-75f3-a67f-5fbd5f0e3faa', '019fc104-f604-726c-8678-a802736e11b8', '019fc104-f69f-7fbe-a15f-ad7b4e36cce1', '019fc104-f6e8-7711-ab24-10ebe24dbe7f', '019fc104-f748-73ab-8b1b-1b6201c67237', NULL, '019fc104-f7cb-724e-9322-353d4f589b28', '019fc104-f798-7c31-b507-71cb546e48e8', 'app_limits_cap_check_tg_fn', 'app_limits_resolve_cap', '019fc104-f812-7521-9ae3-ca04fb0dcced', '019fc104-f856-7ccd-9517-b0ea87623895', 'app_limits_check_soft', '', 'app', 'app', NULL, '019fc104-f2f4-73b2-abcd-47aa47fa7997', 'usage', NULL);


SET session_replication_role TO DEFAULT;


