-- Deploy: schemas/catalog_private/schema/default_table_privs/administrator
-- made with <3 @ constructive.io

-- requires: schemas/catalog_private/schema


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_private
  GRANT ALL ON TABLES TO administrator;