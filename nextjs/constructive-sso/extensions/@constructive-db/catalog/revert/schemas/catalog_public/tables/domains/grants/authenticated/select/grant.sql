-- Revert: schemas/catalog_public/tables/domains/grants/authenticated/select/grant


REVOKE SELECT ON catalog_public.domains FROM authenticated RESTRICT;