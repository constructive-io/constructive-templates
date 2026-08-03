-- Revert: schemas/routing_public/tables/routes/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.routes FROM authenticated RESTRICT;