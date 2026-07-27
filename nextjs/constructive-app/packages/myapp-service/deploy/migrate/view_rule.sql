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
  ('019fa2a1-6110-799a-b719-2452d272f2ab', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6109-767a-8bfc-f1bb29779a76', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fa2a1-6113-7e34-bc1c-501ca1680362', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6109-767a-8bfc-f1bb29779a76', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fa2a1-6116-7aed-a959-c67b2f1996cd', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6109-767a-8bfc-f1bb29779a76', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fa2a1-612a-7bd1-ab4d-ac8cff0ede0e', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6123-71cd-865e-c366636985f4', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fa2a1-612d-782f-aa97-1cdf124f0f22', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6123-71cd-865e-c366636985f4', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fa2a1-6130-7666-9843-1030f793a9a8', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6123-71cd-865e-c366636985f4', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fa2a1-6882-78a4-9bc8-1fd12f3733e0', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-687b-7da2-9fdd-9d73f5d2db1e', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fa2a1-6885-7ea8-8ea8-d03b34a01e72', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-687b-7da2-9fdd-9d73f5d2db1e', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fa2a1-6888-7f1e-9825-5096db6c907a', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-687b-7da2-9fdd-9d73f5d2db1e', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fa2a1-6dea-71f4-a479-aa5079fb3fd6', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6de2-79f4-af72-b983ba08bf0f', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fa2a1-6ded-7bf2-a614-82e77b3c9afe', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6de2-79f4-af72-b983ba08bf0f', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fa2a1-6df1-7294-b02a-6caf59eb9b17', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6de2-79f4-af72-b983ba08bf0f', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fa2a1-6fe2-7acf-82a0-4713d93c2955', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6fdb-7e46-84b5-0b300d2c6f6e', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fa2a1-6fe6-71db-ae6f-da3622331d33', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6fdb-7e46-84b5-0b300d2c6f6e', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fa2a1-6fe9-7bcd-a39a-c1438e9fa976', '019fa2a1-4faf-7d97-ab36-59264d5d52d8', '019fa2a1-6fdb-7e46-84b5-0b300d2c6f6e', '_delete_rule', 'DELETE', 'NOTHING');


SET session_replication_role TO DEFAULT;


