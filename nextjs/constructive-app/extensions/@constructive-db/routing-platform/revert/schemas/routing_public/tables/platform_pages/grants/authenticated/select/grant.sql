-- Revert: schemas/routing_public/tables/platform_pages/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_pages FROM authenticated RESTRICT;