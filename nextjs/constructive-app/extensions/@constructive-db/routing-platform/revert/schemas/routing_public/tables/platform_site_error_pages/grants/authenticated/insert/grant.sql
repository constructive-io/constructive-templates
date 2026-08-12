-- Revert: schemas/routing_public/tables/platform_site_error_pages/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_site_error_pages FROM authenticated RESTRICT;