-- Revert: schemas/catalog_public/tables/apps/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.apps FROM authenticated RESTRICT;