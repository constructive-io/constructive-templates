-- Deploy: schemas/routing_public/tables/routes/constraints/routes_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/routes/table


ALTER TABLE routing_public.routes 
  ADD CONSTRAINT routes_pkey PRIMARY KEY (id);