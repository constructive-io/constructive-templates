-- Revert: schemas/routing_public/tables/platform_site_metadata/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_metadata FROM authenticated RESTRICT;