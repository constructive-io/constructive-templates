-- Revert: schemas/myapp_storage_public/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_public REVOKE USAGE ON SEQUENCES FROM administrator;


