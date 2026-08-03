-- Revert: schemas/routing_public/tables/managed_domains/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.managed_domains FROM authenticated RESTRICT;