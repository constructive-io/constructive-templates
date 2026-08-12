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
  ('019fc105-0444-77d9-b37b-5f35aca5cf30', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-043c-703f-97e3-f65e06053632', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fc105-0447-7f7b-9d70-05145e1f1294', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-043c-703f-97e3-f65e06053632', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fc105-044a-7f68-a5d4-c688dc765767', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-043c-703f-97e3-f65e06053632', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fc105-045f-7205-a194-0fbc39592023', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0457-767b-9580-e8e1c84666db', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fc105-0462-734e-b1bb-bcc81db35fec', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0457-767b-9580-e8e1c84666db', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fc105-0465-7265-a991-3babfa549a9c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0457-767b-9580-e8e1c84666db', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fc105-0bcc-7fb9-ac69-d0cbbccd315d', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0bc6-738a-aefc-cde2c076c90b', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fc105-0bd0-74e2-8077-354ad0c8a8d2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0bc6-738a-aefc-cde2c076c90b', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fc105-0bd3-7535-996d-f8299835301c', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-0bc6-738a-aefc-cde2c076c90b', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fc105-1156-7e3a-9fe3-2d2b78e44aa2', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-114e-7a87-a64a-c3691f4580d1', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fc105-115d-72c9-a894-c75472d9ec78', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-114e-7a87-a64a-c3691f4580d1', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fc105-1160-793f-95cf-97c0a4415da6', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-114e-7a87-a64a-c3691f4580d1', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fc105-1365-725f-856c-96660347ee2f', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-135e-7fa7-b267-683833e57104', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fc105-1368-7c75-b3c2-1d9c67851edd', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-135e-7fa7-b267-683833e57104', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fc105-136c-7633-98d3-45bb8c502410', '019fc104-f28d-7b9c-8d9d-8f338def573c', '019fc105-135e-7fa7-b267-683833e57104', '_delete_rule', 'DELETE', 'NOTHING');


SET session_replication_role TO DEFAULT;


