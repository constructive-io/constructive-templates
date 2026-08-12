-- Deploy: schemas/routing_public/tables/http_routes/grants/authenticated/select/grant
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


GRANT SELECT ON routing_public.http_routes TO authenticated;