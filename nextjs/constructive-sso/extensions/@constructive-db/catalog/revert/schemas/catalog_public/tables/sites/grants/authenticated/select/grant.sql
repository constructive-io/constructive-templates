-- Revert: schemas/catalog_public/tables/sites/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.sites FROM authenticated RESTRICT;