-- Revert: schemas/routing_public/tables/platform_site_themes/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_site_themes FROM authenticated RESTRICT;