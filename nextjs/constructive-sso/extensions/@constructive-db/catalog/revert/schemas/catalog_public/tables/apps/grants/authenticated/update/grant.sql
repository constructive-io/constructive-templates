-- Revert: schemas/catalog_public/tables/apps/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.apps FROM authenticated RESTRICT;