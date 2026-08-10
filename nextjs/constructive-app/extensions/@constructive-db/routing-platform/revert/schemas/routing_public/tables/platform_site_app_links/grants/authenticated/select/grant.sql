-- Revert: schemas/routing_public/tables/platform_site_app_links/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_site_app_links FROM authenticated RESTRICT;