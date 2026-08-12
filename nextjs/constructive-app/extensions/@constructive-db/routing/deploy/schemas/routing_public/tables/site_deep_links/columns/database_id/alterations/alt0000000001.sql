-- Deploy: schemas/routing_public/tables/site_deep_links/columns/database_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_deep_links/table
-- requires: schemas/routing_public/tables/site_deep_links/columns/database_id/column


ALTER TABLE routing_public.site_deep_links 
  ALTER COLUMN database_id SET NOT NULL;