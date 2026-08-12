-- Deploy: migrate/table_behavior
-- made with <3 @ constructive.io

-- requires: migrate/primary_key_constraint


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

INSERT INTO metaschema_public.table_behavior (
  id,
  database_id,
  table_id,
  modifier,
  scope,
  sort_order
) VALUES
  ('019feb75-9150-76bf-9599-adf65c34b32e', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9149-78eb-8455-bb07f20208c6', '-', 'insert', 0),
  ('019feb75-9150-7a3f-821b-d4a2a89916b3', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9149-78eb-8455-bb07f20208c6', '-', 'update', 1),
  ('019feb75-9150-7b6d-822d-6e427c9b4fea', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-9149-78eb-8455-bb07f20208c6', '-', 'delete', 2),
  ('019feb75-91c1-7e9e-bafe-649602be21f1', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', '-', 'insert', 0),
  ('019feb75-91c2-7062-8b32-bfbcaeaf4313', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', '-', 'update', 1),
  ('019feb75-91c2-71df-87b9-a076154ca661', '019feb75-7843-7bd5-a19f-88c4cbec0ee6', '019feb75-91bb-7f0a-9d9d-fd451ffa01f4', '-', 'delete', 2);


SET session_replication_role TO DEFAULT;


