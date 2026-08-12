-- Deploy: schemas/myapp_capabilities_private/schema/default_function_privs/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/myapp_capabilities_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA myapp_capabilities_private GRANT ALL ON FUNCTIONS TO authenticated;

