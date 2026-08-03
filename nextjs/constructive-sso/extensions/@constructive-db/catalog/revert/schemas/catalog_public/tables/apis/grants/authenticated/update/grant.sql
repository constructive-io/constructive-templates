-- Revert: schemas/catalog_public/tables/apis/grants/authenticated/update/grant


REVOKE UPDATE ON catalog_public.apis FROM authenticated RESTRICT;