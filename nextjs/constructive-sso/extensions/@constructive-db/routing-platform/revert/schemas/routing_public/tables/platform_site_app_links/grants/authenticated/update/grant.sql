-- Revert: schemas/routing_public/tables/platform_site_app_links/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_app_links FROM authenticated RESTRICT;