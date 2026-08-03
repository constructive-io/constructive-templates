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
  ('019fbc96-b643-7a58-a886-bfc390bf8ab4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b639-7c4f-8e7c-744b5346ac1e', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-b648-7472-bc29-1ac576aa75b8', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b639-7c4f-8e7c-744b5346ac1e', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-b64c-793f-b32f-c75123bda920', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b639-7c4f-8e7c-744b5346ac1e', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fbc96-b66a-7ae5-9422-8572e44a063b', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b660-7cc4-977a-e31b757ef8b2', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-b66e-786e-a4dd-00397e7cf408', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b660-7cc4-977a-e31b757ef8b2', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-b672-7535-a6bf-c2b7547407fa', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-b660-7cc4-977a-e31b757ef8b2', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fbc96-c0c3-7c4d-920d-1ab90fd769f4', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c0ba-7f88-a2dc-e9e346eb1902', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-c0c8-72ae-b058-4c335d0ff463', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c0ba-7f88-a2dc-e9e346eb1902', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-c0cc-7336-b75d-02fef04cc597', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c0ba-7f88-a2dc-e9e346eb1902', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fbc96-c86b-7e5f-87b0-723eaa2f09cf', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c862-701b-9ee6-d65f38de3b9a', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-c870-79b1-90d0-3aca9f821bff', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c862-701b-9ee6-d65f38de3b9a', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-c875-7c2c-880e-4546f2c22848', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-c862-701b-9ee6-d65f38de3b9a', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fbc96-cb37-7b03-a966-7e200162a846', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb2f-7488-a3f5-e0f742bd511e', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-cb3c-75da-ab35-4ca112cd8a60', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb2f-7488-a3f5-e0f742bd511e', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-cb41-7370-a960-0999b0ef816c', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-cb2f-7488-a3f5-e0f742bd511e', '_delete_rule', 'DELETE', 'NOTHING'),
  ('019fbc96-ddc5-7027-9c91-c5884a3607ca', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ddb8-785f-9297-c8f1a1540c35', '_insert_rule', 'INSERT', 'NOTHING'),
  ('019fbc96-ddca-7e9c-aba2-a907c94cb232', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ddb8-785f-9297-c8f1a1540c35', '_update_rule', 'UPDATE', 'NOTHING'),
  ('019fbc96-ddd0-7925-a418-85fa0f96d33d', '019fbc96-84d8-7d13-8acc-4c55ad35634c', '019fbc96-ddb8-785f-9297-c8f1a1540c35', '_delete_rule', 'DELETE', 'NOTHING');


SET session_replication_role TO DEFAULT;


