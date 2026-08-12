-- Deploy: schemas/routing_public/tables/platform_sites/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/platform_sites/table
-- requires: schemas/routing_public/tables/platform_sites/columns/name/column


ALTER TABLE routing_public.platform_sites 
  ALTER COLUMN name SET NOT NULL;