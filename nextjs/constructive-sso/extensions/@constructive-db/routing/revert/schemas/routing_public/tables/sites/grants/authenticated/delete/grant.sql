-- Revert: schemas/routing_public/tables/sites/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.sites FROM authenticated RESTRICT;