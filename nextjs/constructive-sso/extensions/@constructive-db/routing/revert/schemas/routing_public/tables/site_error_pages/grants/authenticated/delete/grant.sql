-- Revert: schemas/routing_public/tables/site_error_pages/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.site_error_pages FROM authenticated RESTRICT;