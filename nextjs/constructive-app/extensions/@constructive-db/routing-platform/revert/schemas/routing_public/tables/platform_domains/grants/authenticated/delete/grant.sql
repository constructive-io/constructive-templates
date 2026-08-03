-- Revert: schemas/routing_public/tables/platform_domains/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.platform_domains FROM authenticated RESTRICT;