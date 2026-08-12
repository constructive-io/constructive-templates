-- Deploy: schemas/catalog_public/schema/default_function_privs/authenticated
-- made with <3 @ constructive.io

-- requires: schemas/catalog_public/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  GRANT ALL ON FUNCTIONS TO authenticated;