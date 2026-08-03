-- Revert: schemas/catalog_public/tables/namespaces/grants/authenticated/delete/grant


REVOKE DELETE ON catalog_public.namespaces FROM authenticated RESTRICT;