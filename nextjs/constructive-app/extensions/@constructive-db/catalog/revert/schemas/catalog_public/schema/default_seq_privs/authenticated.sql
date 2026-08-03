-- Revert: schemas/catalog_public/schema/default_seq_privs/authenticated


ALTER DEFAULT PRIVILEGES IN SCHEMA catalog_public
  REVOKE USAGE ON SEQUENCES FROM authenticated RESTRICT;