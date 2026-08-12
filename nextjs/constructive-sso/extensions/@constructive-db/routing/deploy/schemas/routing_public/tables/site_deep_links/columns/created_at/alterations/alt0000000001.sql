-- Deploy: schemas/routing_public/tables/site_deep_links/columns/created_at/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table
-- requires: schemas/routing_public/tables/site_deep_links/columns/created_at/column


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN created_at SET DEFAULT now();