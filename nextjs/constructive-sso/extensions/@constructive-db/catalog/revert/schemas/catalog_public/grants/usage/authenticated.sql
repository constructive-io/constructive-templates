-- Revert: schemas/catalog_public/grants/usage/authenticated


REVOKE USAGE ON SCHEMA catalog_public FROM authenticated RESTRICT;