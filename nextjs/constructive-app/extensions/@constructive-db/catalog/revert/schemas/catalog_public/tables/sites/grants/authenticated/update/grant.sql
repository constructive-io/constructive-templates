-- Revert: schemas/catalog_public/tables/sites/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.sites FROM authenticated RESTRICT;