-- Revert: schemas/routing_public/tables/site_modules/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_modules FROM authenticated RESTRICT;