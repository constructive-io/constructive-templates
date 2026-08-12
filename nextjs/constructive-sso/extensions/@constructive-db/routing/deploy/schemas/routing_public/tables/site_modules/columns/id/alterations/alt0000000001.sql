-- Deploy: schemas/routing_public/tables/site_modules/columns/id/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table
-- requires: schemas/routing_public/tables/site_modules/columns/id/column


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN id SET NOT NULL;