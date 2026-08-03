-- Revert: schemas/routing_public/tables/http_routes/grants/authenticated/update/grant


REVOKE UPDATE ON routing_public.http_routes FROM authenticated RESTRICT;