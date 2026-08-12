-- Revert: schemas/myapp_storage_private/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private REVOKE USAGE ON SEQUENCES FROM administrator;


