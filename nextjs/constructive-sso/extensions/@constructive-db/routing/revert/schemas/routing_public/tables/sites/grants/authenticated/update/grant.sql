-- Revert: schemas/routing_public/tables/sites/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.sites FROM authenticated RESTRICT;