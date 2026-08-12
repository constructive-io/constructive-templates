-- Revert: schemas/routing_public/tables/platform_domains/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_domains FROM authenticated RESTRICT;