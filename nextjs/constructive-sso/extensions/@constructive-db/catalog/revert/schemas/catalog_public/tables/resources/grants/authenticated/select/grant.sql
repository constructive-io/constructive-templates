-- Revert: schemas/catalog_public/tables/resources/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.resources FROM authenticated RESTRICT;