-- Revert: schemas/catalog_public/tables/apps/grants/authenticated/insert/grant


REVOKE INSERT ON catalog_public.apps FROM authenticated RESTRICT;