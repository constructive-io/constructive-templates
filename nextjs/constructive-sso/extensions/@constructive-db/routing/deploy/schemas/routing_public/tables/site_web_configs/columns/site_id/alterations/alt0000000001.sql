-- Deploy: schemas/routing_public/tables/site_web_configs/columns/site_id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_web_configs/table
-- requires: schemas/routing_public/tables/site_web_configs/columns/site_id/column


ALTER TABLE routing_public.site_web_configs 
  ALTER COLUMN site_id SET NOT NULL;