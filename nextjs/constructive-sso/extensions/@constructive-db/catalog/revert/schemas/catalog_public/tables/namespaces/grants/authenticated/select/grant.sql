-- Revert: schemas/catalog_public/tables/namespaces/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.namespaces FROM authenticated RESTRICT;