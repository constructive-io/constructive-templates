-- Revert: schemas/catalog_public/tables/namespaces/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.namespaces FROM authenticated RESTRICT;