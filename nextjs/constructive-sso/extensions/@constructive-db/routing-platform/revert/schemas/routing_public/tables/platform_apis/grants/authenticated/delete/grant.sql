-- Revert: schemas/routing_public/tables/platform_apis/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_apis FROM authenticated RESTRICT;