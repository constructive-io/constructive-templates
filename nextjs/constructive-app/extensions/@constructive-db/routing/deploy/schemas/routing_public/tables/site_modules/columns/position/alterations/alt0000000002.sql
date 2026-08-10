-- Deploy: schemas/routing_public/tables/site_modules/columns/position/alterations/alt0000000002
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_modules/table
-- requires: schemas/routing_public/tables/site_modules/columns/position/column


ALTER TABLE routing_public.site_modules 
  ALTER COLUMN "position" SET DEFAULT 0;