-- Revert: schemas/routing_public/tables/domains/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.domains FROM authenticated RESTRICT;