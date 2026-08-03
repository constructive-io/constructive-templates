-- Deploy: schemas/routing_public/tables/site_metadata/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_metadata/table
-- requires: schemas/routing_public/tables/site_metadata/columns/id/column


ALTER TABLE routing_public.site_metadata 
  ALTER COLUMN id SET NOT NULL;