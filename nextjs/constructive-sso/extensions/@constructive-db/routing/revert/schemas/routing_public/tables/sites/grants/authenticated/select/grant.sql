-- Revert: schemas/routing_public/tables/sites/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.sites FROM authenticated RESTRICT;