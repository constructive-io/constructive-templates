-- Revert: schemas/routing_public/tables/http_routes/grants/authenticated/delete/grant


REVOKE DELETE ON routing_public.http_routes FROM authenticated RESTRICT;