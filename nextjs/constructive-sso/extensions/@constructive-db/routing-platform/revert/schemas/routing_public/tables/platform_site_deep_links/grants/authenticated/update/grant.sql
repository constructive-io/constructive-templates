-- Revert: schemas/routing_public/tables/platform_site_deep_links/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_deep_links FROM authenticated RESTRICT;