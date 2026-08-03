-- Revert: schemas/routing_public/tables/domains/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.domains FROM authenticated RESTRICT;