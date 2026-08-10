-- Deploy: migrate/trigger_function
-- made with <3 @ constructive.io

-- requires: migrate/schema


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

INSERT INTO metaschema_public.trigger_function (
  id,
  database_id,
  name,
  code
) VALUES
  ('019feb75-790c-7d0b-a582-2c5f31304491', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'users_search_tsv_tsv', NULL),
  ('019feb75-7b8c-71ac-90ff-a555469e5b2d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_memberships_peoplestamps', NULL),
  ('019feb75-7ba3-7a27-bba4-7e2d60e8f4b8', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_membership_defaults_peoplestamps', NULL),
  ('019feb75-8104-7018-ae01-1968ca13c647', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'org_memberships_peoplestamps', NULL),
  ('019feb75-811c-7e4c-baa9-fa9af6fd9791', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'org_membership_defaults_peoplestamps', NULL),
  ('019feb75-8159-7461-b0d7-a2ad9cb4ab26', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'org_membership_settings_peoplestamps', NULL),
  ('019feb75-8162-74d6-b1a5-049f0d143bd0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'org_membership_settings_seed_fn', NULL),
  ('019feb75-843c-7c2a-bf82-f1d281e3fe64', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'org_profile_templates_seed_fn', NULL),
  ('019feb75-8945-77aa-958d-7832c41ce125', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'user_secrets_hash', NULL),
  ('019feb75-89bc-7127-ab32-8715a91bf527', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_internal_secrets_hash', NULL),
  ('019feb75-9109-7706-8def-96e9a516198f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_settings_auth_guard_step_up_upd_fn', NULL),
  ('019feb75-912a-7040-8140-9c4df15c2f4c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_settings_auth_guard_step_up_del_fn', NULL),
  ('019feb75-9132-7634-9f25-ebcc0bdadd4c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'identity_providers_guard_step_up_upd_fn', NULL),
  ('019feb75-9146-7518-9b32-a13467b80aee', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'identity_providers_guard_step_up_del_fn', NULL),
  ('019feb75-9247-718d-b22b-1cdcc42f17bc', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'principals_guard_step_up_upd_fn', NULL),
  ('019feb75-9250-77dd-88c9-d00176c04c5f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'principal_scope_overrides_guard_step_up_upd_fn', NULL),
  ('019feb75-9257-73ee-9549-8215b90666fe', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'principal_scope_overrides_guard_step_up_del_fn', NULL),
  ('019feb75-931d-7a68-8282-89b2e88e267c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_buckets_force_current_user_actor_id', NULL),
  ('019feb75-9323-73d6-9a64-d772e0c0a134', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_buckets_immutable_fields', NULL),
  ('019feb75-9384-7cd9-9211-560dde4b7a27', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_files_inherit_from_parent', NULL),
  ('019feb75-9388-72f9-913a-5057225bbe7b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_files_force_current_user_actor_id', NULL),
  ('019feb75-938c-724a-a2f5-96ef5f4afd1f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_files_immutable_fields', NULL),
  ('019feb75-939c-779c-aecc-761c2fa4531f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_buckets_staging_guard', NULL),
  ('019feb75-93a5-780f-a8a5-bcf2d5dc5b59', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_files_promotion_guard', NULL),
  ('019feb75-93b1-7ad4-b803-d4705b0e3a41', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', 'app_files_gc_storage_object', NULL);


SET session_replication_role TO DEFAULT;


