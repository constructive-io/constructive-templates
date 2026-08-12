-- Revert: schemas/routing_public/tables/platform_site_error_pages/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_site_error_pages FROM authenticated RESTRICT;