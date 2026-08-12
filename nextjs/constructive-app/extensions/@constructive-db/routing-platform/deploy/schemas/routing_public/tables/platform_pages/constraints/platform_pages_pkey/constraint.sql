-- Deploy: schemas/routing_public/tables/platform_pages/constraints/platform_pages_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_pages/table


ALTER TABLE routing_public.platform_pages 
  ADD CONSTRAINT platform_pages_pkey PRIMARY KEY (id);