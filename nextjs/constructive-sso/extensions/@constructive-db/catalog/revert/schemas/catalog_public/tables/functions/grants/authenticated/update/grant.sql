-- Revert: schemas/catalog_public/tables/functions/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.functions FROM authenticated RESTRICT;