-- Revert: schemas/myapp_capabilities_public/schema/default_seq_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_public REVOKE USAGE ON SEQUENCES FROM authenticated;


