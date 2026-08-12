-- Revert: schemas/routing_public/tables/routes/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.routes FROM authenticated RESTRICT;