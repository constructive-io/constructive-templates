-- Revert: schemas/catalog_public/tables/functions/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.functions FROM authenticated RESTRICT;