-- Revert: schemas/routing_public/tables/platform_pages/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_pages FROM authenticated RESTRICT;