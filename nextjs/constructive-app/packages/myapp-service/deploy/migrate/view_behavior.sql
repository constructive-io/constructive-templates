-- Deploy: migrate/view_behavior
-- made with <3 @ constructive.io

-- requires: migrate/webauthn_credentials_module


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

INSERT INTO metaschema_public.view_behavior (
  id,
  database_id,
  view_id,
  modifier,
  scope,
  sort_order
) VALUES
  ('019feb75-87ca-724b-a2c9-0ec56c7c2e7b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '-', 'insert', 0),
  ('019feb75-87ca-7620-b67b-b2f60db3f9de', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '-', 'update', 1),
  ('019feb75-87ca-7733-9109-6ec186f75a7f', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '-', 'delete', 2),
  ('019feb75-87d4-79c9-beda-591111998276', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '-', 'insert', 0),
  ('019feb75-87d4-7afd-a175-e0dbd019e57c', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '-', 'update', 1),
  ('019feb75-87d4-7bff-9d07-f3ac9dcd96d7', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '-', 'delete', 2),
  ('019feb75-89b4-7f46-8c33-0386fff9e959', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '-', 'insert', 0),
  ('019feb75-89b5-70e0-a370-f64ec62e3d3b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '-', 'update', 1),
  ('019feb75-89b5-71aa-b60e-81fa69a8291a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '-', 'delete', 2),
  ('019feb75-8b7b-7a0a-8634-beb4b6396860', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '-', 'insert', 0),
  ('019feb75-8b7b-7b9f-9ebd-ad39c8c15f73', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '-', 'update', 1),
  ('019feb75-8b7b-7c66-a828-2f8c6a716738', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '-', 'delete', 2),
  ('019feb75-8bdf-7917-b1e2-8db4ca555546', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '-', 'insert', 0),
  ('019feb75-8bdf-7a7c-8270-f51f18d45dc1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '-', 'update', 1),
  ('019feb75-8bdf-7b9e-8eab-fcf593574e6d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '-', 'delete', 2),
  ('019feb75-9235-772a-bdfb-cf3690e7c0d2', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '-', 'insert', 0),
  ('019feb75-9235-79e4-bcbd-6db2c6542478', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '-', 'update', 1),
  ('019feb75-9235-7aba-995d-73f1e8762ce0', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '-', 'delete', 2);


SET session_replication_role TO DEFAULT;


