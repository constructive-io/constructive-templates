-- Deploy: schemas/routing_public/tables/site_deep_links/constraints/site_deep_links_site_id_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table


ALTER TABLE routing_public.site_deep_links 
  ADD CONSTRAINT site_deep_links_site_id_slug_key 
    UNIQUE (site_id, slug);