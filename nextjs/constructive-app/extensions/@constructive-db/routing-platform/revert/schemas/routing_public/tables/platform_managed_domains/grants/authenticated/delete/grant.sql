-- Revert: schemas/routing_public/tables/platform_managed_domains/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_managed_domains FROM authenticated RESTRICT;