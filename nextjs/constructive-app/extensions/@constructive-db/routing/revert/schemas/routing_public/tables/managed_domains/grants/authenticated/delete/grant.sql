-- Revert: schemas/routing_public/tables/managed_domains/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.managed_domains FROM authenticated RESTRICT;