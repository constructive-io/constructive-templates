-- Deploy: schemas/routing_public/tables/pages/constraints/pages_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_pkey PRIMARY KEY (id);