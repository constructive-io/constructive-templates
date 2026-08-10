-- Revert: schemas/routing_public/tables/platform_site_web_configs/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_web_configs FROM authenticated RESTRICT;