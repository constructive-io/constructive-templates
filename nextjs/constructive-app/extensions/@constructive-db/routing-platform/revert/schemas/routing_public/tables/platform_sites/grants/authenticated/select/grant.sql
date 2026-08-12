-- Revert: schemas/routing_public/tables/platform_sites/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_sites FROM authenticated RESTRICT;