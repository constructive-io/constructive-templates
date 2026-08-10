-- Deploy: migrate/view_rule
-- made with <3 @ constructive.io

-- requires: migrate/view_grant


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

INSERT INTO metaschema_public.view_rule (
  id,
  database_id,
  view_id,
  name,
  event,
  action
) VALUES
  ('019feb75-87c6-7849-80a1-5dc08b67322d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-87c8-71a7-a074-2fc2247afe81', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-87c8-7f8e-aae2-6d034d4d7433', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87c0-719e-8ed0-edba70fd3ce1', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019feb75-87d2-71a8-a1d3-4c06a6b0009b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-87d2-7ec1-8b63-8aaae631a42a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-87d3-7afa-82b1-39040f57c799', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-87cc-7dcd-9a63-a483ec264440', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019feb75-89b2-707f-b1ff-b74532c4bc55', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-89b3-72f6-b5d9-8237900fa3b9', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-89b3-7fa0-9dde-b00be924215b', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-89ae-72d5-b03b-8773c41c571f', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019feb75-8b78-7b60-bde8-8a930a1d5260', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-8b79-7d6d-8d9b-d1273dda80af', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-8b7a-79e2-932b-691544964f03', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8b74-7390-b746-225bdae365ce', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019feb75-8bdc-7d62-b434-91510f0aabc6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-8bdd-7a97-8696-2f0b7f3ba74d', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-8bde-76e0-a8f9-46eb688e4b7a', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-8bda-7193-ad61-35648599d0e3', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019feb75-9232-714a-99d5-318f71dab0c1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019feb75-9233-7707-b26b-5d3cc49bd0d6', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019feb75-9234-751e-b336-6adf0d174636', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-922c-73db-91d7-934470e13412', '_delete_rule', 'DELETE', 'NOTHING');


SET session_replication_role TO DEFAULT;


