-- Revert: schemas/routing_public/tables/sites/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.sites FROM authenticated RESTRICT;