-- Revert: schemas/routing_public/tables/platform_apis/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_apis FROM authenticated RESTRICT;