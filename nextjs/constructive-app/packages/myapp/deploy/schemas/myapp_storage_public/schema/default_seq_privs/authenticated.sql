-- Deploy: schemas/myapp_storage_public/schema/default_seq_privs/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/myapp_storage_public/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public GRANT USAGE ON SEQUENCES TO authenticated;

