-- Revert: schemas/myapp_capabilities_public/schema/default_function_privs/administrator


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_public REVOKE ALL ON FUNCTIONS FROM administrator;


