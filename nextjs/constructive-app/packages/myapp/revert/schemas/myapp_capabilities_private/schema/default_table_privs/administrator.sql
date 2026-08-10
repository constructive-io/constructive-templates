-- Revert: schemas/myapp_capabilities_private/schema/default_table_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_private REVOKE ALL ON TABLES FROM administrator;


