-- Deploy: schemas/routing_public/tables/http_routes/constraints/http_routes_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/http_routes/table


ALTER TABLE routing_public.http_routes 
  ADD CONSTRAINT http_routes_pkey PRIMARY KEY (id);