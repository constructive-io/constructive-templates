-- Deploy: schemas/routing_public/tables/platform_site_deep_links/constraints/platform_site_deep_links_pkey/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_site_deep_links/table


ALTER TABLE routing_public.platform_site_deep_links 
  ADD CONSTRAINT platform_site_deep_links_pkey PRIMARY KEY (id);