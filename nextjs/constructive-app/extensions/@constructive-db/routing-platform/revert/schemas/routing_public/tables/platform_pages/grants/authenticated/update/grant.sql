-- Revert: schemas/routing_public/tables/platform_pages/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_pages FROM authenticated RESTRICT;