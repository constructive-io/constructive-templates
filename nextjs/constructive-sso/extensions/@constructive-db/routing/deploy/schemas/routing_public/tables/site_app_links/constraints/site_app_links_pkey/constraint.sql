-- Deploy: schemas/routing_public/tables/site_app_links/constraints/site_app_links_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_app_links/table


ALTER TABLE routing_public.site_app_links 
  ADD CONSTRAINT site_app_links_pkey PRIMARY KEY (id);