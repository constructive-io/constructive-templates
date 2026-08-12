-- Revert: schemas/routing_public/tables/domains/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.domains FROM authenticated RESTRICT;