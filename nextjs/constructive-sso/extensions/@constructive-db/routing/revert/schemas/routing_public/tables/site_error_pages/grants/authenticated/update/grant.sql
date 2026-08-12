-- Revert: schemas/routing_public/tables/site_error_pages/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.site_error_pages FROM authenticated RESTRICT;