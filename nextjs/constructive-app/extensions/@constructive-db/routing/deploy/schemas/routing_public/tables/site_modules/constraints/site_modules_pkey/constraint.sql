-- Deploy: schemas/routing_public/tables/site_modules/constraints/site_modules_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table


ALTER TABLE routing_public.site_modules 
  ADD CONSTRAINT site_modules_pkey PRIMARY KEY (id);