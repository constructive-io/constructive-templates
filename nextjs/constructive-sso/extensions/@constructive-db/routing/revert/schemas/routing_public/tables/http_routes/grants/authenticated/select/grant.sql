-- Revert: schemas/routing_public/tables/http_routes/grants/authenticated/select/grant


REVOKE SELECT ON routing_public.http_routes FROM authenticated RESTRICT;