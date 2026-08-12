-- Deploy: schemas/routing_public/tables/site_themes/columns/name/alterations/alt0000000001
-- made with <3 @ constructive.io

-- requires: schemas/routing_public/schema
-- requires: schemas/routing_public/tables/site_themes/table
-- requires: schemas/routing_public/tables/site_themes/columns/name/column


ALTER TABLE routing_public.site_themes 
  ALTER COLUMN name SET NOT NULL;