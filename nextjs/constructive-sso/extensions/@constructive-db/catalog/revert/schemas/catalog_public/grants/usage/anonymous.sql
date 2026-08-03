-- Revert: schemas/catalog_public/grants/usage/anonymous


REVOKE USAGE ON SCHEMA catalog_public FROM anonymous RESTRICT;