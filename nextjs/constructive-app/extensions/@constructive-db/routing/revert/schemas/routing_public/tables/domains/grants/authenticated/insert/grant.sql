-- Revert: schemas/routing_public/tables/domains/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.domains FROM authenticated RESTRICT;