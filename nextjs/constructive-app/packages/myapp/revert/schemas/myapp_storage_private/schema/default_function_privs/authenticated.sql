-- Revert: schemas/myapp_storage_private/schema/default_function_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_storage_private REVOKE ALL ON FUNCTIONS FROM authenticated;


