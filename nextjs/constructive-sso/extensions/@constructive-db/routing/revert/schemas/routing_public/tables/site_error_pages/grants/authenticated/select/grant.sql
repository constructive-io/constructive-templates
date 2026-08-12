-- Revert: schemas/routing_public/tables/site_error_pages/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.site_error_pages FROM authenticated RESTRICT;