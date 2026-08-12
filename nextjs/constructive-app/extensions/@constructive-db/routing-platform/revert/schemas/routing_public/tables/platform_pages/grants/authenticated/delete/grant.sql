-- Revert: schemas/routing_public/tables/platform_pages/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_pages FROM authenticated RESTRICT;