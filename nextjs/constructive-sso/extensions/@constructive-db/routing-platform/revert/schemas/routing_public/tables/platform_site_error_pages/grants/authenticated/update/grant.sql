-- Revert: schemas/routing_public/tables/platform_site_error_pages/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_site_error_pages FROM authenticated RESTRICT;