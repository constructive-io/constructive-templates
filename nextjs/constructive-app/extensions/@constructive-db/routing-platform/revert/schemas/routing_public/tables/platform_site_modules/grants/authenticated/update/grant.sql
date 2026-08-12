-- Revert: schemas/routing_public/tables/platform_site_modules/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_modules FROM authenticated RESTRICT;