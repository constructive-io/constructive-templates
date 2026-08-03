-- Revert: schemas/routing_public/tables/routes/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.routes FROM authenticated RESTRICT;