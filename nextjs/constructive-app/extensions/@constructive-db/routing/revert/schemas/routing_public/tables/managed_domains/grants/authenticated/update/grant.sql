-- Revert: schemas/routing_public/tables/managed_domains/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.managed_domains FROM authenticated RESTRICT;