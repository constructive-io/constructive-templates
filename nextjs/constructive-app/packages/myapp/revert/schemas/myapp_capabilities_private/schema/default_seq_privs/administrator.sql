-- Revert: schemas/myapp_capabilities_private/schema/default_seq_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_private REVOKE USAGE ON SEQUENCES FROM administrator;


