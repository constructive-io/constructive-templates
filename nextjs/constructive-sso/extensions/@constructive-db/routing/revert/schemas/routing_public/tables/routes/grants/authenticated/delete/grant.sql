-- Revert: schemas/routing_public/tables/routes/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.routes FROM authenticated RESTRICT;