-- Deploy: migrate/api_schemas
-- made with <3 @ constructive.io

-- requires: migrate/memberships_module


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

INSERT INTO routing_public.api_schemas (
  id,
  api_id,
  schema_id,
  database_id
) VALUES
  ('019fc104-f2f3-7d2c-bcca-b38d2d00461d', '019fc104-f2f3-71f4-834c-03b155978680', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc104-f428-7b6c-8814-28cd5f4fdeb2', '019fc104-f428-7741-b519-19163a1626fa', '019fc104-f3fb-7199-84be-973cb5027963', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc104-f4dd-77e8-990c-a76ecef9b3cd', '019fc104-f4dd-73ef-9fa6-aa0cb488fb8e', '019fc104-f4a9-7dad-b8d1-37fc33a66117', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc104-f8c7-7fa1-8f90-2fafa79639ac', '019fc104-f428-7741-b519-19163a1626fa', '019fc104-f39c-7300-895c-30b0b61a670e', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-0a8b-7bdf-b7dc-eaafc88921ff', '019fc105-0a8b-7828-9d1b-94e6b0601720', '019fc105-0a5d-726d-81e3-16720f03bcfa', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-0c4f-7411-a884-015d57859e7e', '019fc104-f2f3-71f4-834c-03b155978680', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-0cf5-7a52-962c-c6fba2fcae17', '019fc104-f2f3-71f4-834c-03b155978680', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-13bd-7f04-98e1-a116124f5cc8', '019fc104-f2f3-71f4-834c-03b155978680', '019fc105-1384-729e-90a7-7b2eadef8142', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-1b8f-707b-943e-82608a37a3df', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc104-f294-70c5-a245-14fc6887a0dd', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df5-777d-8cb7-a3738cc8d130', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc104-f2d5-7d8a-8559-fbeeb1c5ae3f', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df7-75b2-a105-262e1278c3e1', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc104-f39c-7300-895c-30b0b61a670e', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df7-7c2b-b6ff-cdfc2687ea91', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc104-f3fb-7199-84be-973cb5027963', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df8-723d-9623-911de721c0e1', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc104-f4a9-7dad-b8d1-37fc33a66117', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df8-7921-adb3-5449eab9d89c', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc105-0a5d-726d-81e3-16720f03bcfa', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df9-707b-82e4-bc23babdacea', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc105-0c1b-7bde-9736-c30b1029bcc9', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df9-7717-8a7e-14e5ad531a88', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc105-0c8d-72ee-983e-7d7c1610c7f5', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9df9-7c97-8fc1-1865ca33f203', '019fc105-1b8d-7ee0-8a16-c2def252283c', '019fc105-1384-729e-90a7-7b2eadef8142', '019fc104-f28d-7b9c-8d9d-8f338def573c'),
  ('019fc105-9e1d-710c-bc28-5307c9bd87e3', '019fc105-1bb2-741c-b9a3-d74fc015b293', 'fc04bdf6-abfa-55c6-74eb-4f765f024f7a', '019fc104-f28d-7b9c-8d9d-8f338def573c');


SET session_replication_role TO DEFAULT;


