-- Revert: schemas/routing_public/tables/platform_apis/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_apis FROM authenticated RESTRICT;