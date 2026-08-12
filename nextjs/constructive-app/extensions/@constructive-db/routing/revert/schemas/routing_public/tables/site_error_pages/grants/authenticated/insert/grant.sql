-- Revert: schemas/routing_public/tables/site_error_pages/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.site_error_pages FROM authenticated RESTRICT;