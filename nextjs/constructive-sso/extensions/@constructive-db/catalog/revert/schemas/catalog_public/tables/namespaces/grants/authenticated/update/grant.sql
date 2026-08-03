-- Revert: schemas/catalog_public/tables/namespaces/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.namespaces FROM authenticated RESTRICT;