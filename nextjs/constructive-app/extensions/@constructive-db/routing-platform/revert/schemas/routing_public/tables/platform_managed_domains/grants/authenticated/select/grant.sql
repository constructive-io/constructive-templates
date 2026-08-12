-- Revert: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.platform_managed_domains FROM authenticated RESTRICT;