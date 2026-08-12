-- Deploy: schemas/routing_public/tables/sites/constraints/sites_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/sites/table


ALTER TABLE routing_public.sites 
  ADD CONSTRAINT sites_pkey PRIMARY KEY (id);