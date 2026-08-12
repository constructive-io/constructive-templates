-- Revert: schemas/routing_public/tables/platform_sites/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_sites FROM authenticated RESTRICT;