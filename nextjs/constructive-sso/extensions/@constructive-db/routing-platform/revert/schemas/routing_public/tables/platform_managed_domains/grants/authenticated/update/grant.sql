-- Revert: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.platform_managed_domains FROM authenticated RESTRICT;