-- Revert: schemas/routing_public/tables/platform_site_modules/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_site_modules FROM authenticated RESTRICT;