-- Revert: schemas/routing_public/tables/platform_apis/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.platform_apis FROM authenticated RESTRICT;