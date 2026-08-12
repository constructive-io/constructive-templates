-- Revert: schemas/routing_public/tables/platform_site_themes/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_themes FROM authenticated RESTRICT;