-- Deploy: schemas/routing_public/tables/platform_site_modules/constraints/platform_site_modules_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_modules/table


ALTER TABLE routing_public.platform_site_modules 
  ADD CONSTRAINT platform_site_modules_pkey PRIMARY KEY (id);