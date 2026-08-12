-- Revert: schemas/routing_public/tables/http_routes/grants/authenticated/insert/grant


REVOKE INSERT ON routing_public.http_routes FROM authenticated RESTRICT;