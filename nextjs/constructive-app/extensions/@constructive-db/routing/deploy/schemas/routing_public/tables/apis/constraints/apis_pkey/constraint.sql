-- Deploy: schemas/routing_public/tables/apis/constraints/apis_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/apis/table


ALTER TABLE routing_public.apis 
  ADD CONSTRAINT apis_pkey PRIMARY KEY (id);