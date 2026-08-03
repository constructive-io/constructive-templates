-- Revert: schemas/catalog_public/tables/apis/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.apis FROM authenticated RESTRICT;