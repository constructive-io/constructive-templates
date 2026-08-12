-- Revert: schemas/routing_public/tables/site_modules/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_modules FROM authenticated RESTRICT;