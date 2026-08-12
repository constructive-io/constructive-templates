-- Deploy: schemas/routing_public/tables/pages/constraints/pages_site_id_slug_key/constraint
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/pages/table


ALTER TABLE routing_public.pages 
  ADD CONSTRAINT pages_site_id_slug_key 
    UNIQUE (site_id, slug);