-- Deploy: schemas/routing_public/tables/platform_site_error_pages/constraints/platform_site_error_pages_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_error_pages/table


ALTER TABLE routing_public.platform_site_error_pages 
  ADD CONSTRAINT platform_site_error_pages_pkey PRIMARY KEY (id);