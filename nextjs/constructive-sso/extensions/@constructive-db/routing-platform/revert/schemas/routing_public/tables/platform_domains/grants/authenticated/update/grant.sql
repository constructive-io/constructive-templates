-- Revert: schemas/routing_public/tables/platform_domains/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_domains FROM authenticated RESTRICT;