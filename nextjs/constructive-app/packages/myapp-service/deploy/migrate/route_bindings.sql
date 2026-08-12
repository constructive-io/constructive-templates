-- Deploy: migrate/route_bindings
-- made with <3 @ constructive.io

-- requires: migrate/hostname_bindings


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

INSERT INTO routing_public.route_bindings (
  id,
  domain_id,
  target_api_id,
  target_site_id,
  target_function_id,
  target_service_id,
  target_bucket_id,
  path,
  method,
  priority,
  is_active
) VALUES
  ('019feb75-9403-788f-b0a3-90e7b6fb277a', '019feb75-93ff-7511-abb5-c4110a0d5abb', '019feb75-797a-7084-aa15-4fa0cfa05f39', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9404-7990-a294-2c19117b1a46', '019feb75-93ff-7f96-bf4d-b2c46b9acee8', '019feb75-78e1-7197-a9bd-7f9075c774b2', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9404-7dbd-9398-2cddeba60686', '019feb75-9400-71e8-868d-9f6b33211c1d', '019feb75-9402-7b4f-b836-399f826c4fb0', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9405-7151-97ac-bc7aaebe054a', '019feb75-9400-73fe-bbc9-e1d4da7b04b6', '019feb75-79c5-7aca-bac5-7e2c2ebb0400', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9405-7513-a154-b0e32866d3b9', '019feb75-9400-7601-8113-e4d028e45bcb', '019feb75-9402-7ce7-9a76-1ac03513c5f0', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9405-786b-b862-39f592e3fe4b', '019feb75-9400-7acd-a43b-b81000ff25f3', '019feb75-9402-7d94-a3f7-065838d00cec', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9405-7f0f-9905-9923b69745b1', '019feb75-9400-7c4e-ba3c-b356c58848bb', '019feb75-9402-7e3e-a71f-bd6bb963e246', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-9407-7c9e-a74e-dc7144f04b8a', '019feb75-9400-7835-99f2-1cd51bf8d106', '019feb75-8966-7142-a594-0faf10ac7cd3', NULL, NULL, NULL, NULL, '/', NULL, 0, true),
  ('019feb75-be38-7716-b271-0df400368a6a', '019feb75-be29-7996-a9fb-191bf253a037', '019feb75-b40f-7c2a-b4b0-fe1bf220facd', NULL, NULL, NULL, NULL, '/', NULL, 0, true);


SET session_replication_role TO DEFAULT;


