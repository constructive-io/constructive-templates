-- Revert: schemas/routing_public/tables/platform_site_error_pages/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_site_error_pages FROM authenticated RESTRICT;