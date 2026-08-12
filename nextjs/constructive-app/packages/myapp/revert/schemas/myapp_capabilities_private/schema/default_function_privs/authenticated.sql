-- Revert: schemas/myapp_capabilities_private/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_private REVOKE ALL ON FUNCTIONS FROM authenticated;


