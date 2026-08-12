-- Deploy: schemas/routing_public/tables/site_modules/columns/data/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table
-- requires: schemas/routing_public/tables/site_modules/columns/data/column


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN data SET NOT NULL;