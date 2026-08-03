-- Revert: schemas/routing_public/tables/platform_sites/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_sites FROM authenticated RESTRICT;